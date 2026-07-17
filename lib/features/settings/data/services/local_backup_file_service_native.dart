import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_file_service.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';
import 'package:uuid/uuid.dart';

LocalBackupFileService createPlatformLocalBackupFileService() {
  return NativeLocalBackupFileService();
}

class NativeLocalBackupFileService implements LocalBackupFileService {
  NativeLocalBackupFileService([this._uuid = const Uuid()]);

  final Uuid _uuid;
  static final _pdfPathPattern = RegExp(r'^pdfs/[a-zA-Z0-9-]+\.pdf$');

  @override
  bool get isSupported => true;

  @override
  Future<Map<String, Uint8List>> readPdfFiles(
    Iterable<String> relativePaths,
  ) async {
    try {
      final documents = await getApplicationDocumentsDirectory();
      final paths = relativePaths.toSet().toList()..sort();
      final files = <String, File>{};
      var totalSize = 0;
      for (final relativePath in paths) {
        _validatePdfPath(relativePath);
        final file = File(_absolutePdfPath(documents, relativePath));
        if (!await file.exists()) {
          throw const BackupException(
            'Salah satu PDF lokal tidak ditemukan. Backup penuh dibatalkan.',
          );
        }
        totalSize += await file.length();
        if (totalSize > maxLocalBackupBytes) {
          throw const BackupException(
            'Total PDF melebihi batas backup 256 MB.',
          );
        }
        files[relativePath] = file;
      }

      final result = <String, Uint8List>{};
      for (final entry in files.entries) {
        result[entry.key] = await entry.value.readAsBytes();
      }
      return result;
    } on BackupException {
      rethrow;
    } catch (error) {
      throw BackupException('PDF lokal belum dapat dibaca.', error);
    }
  }

  @override
  Future<String?> saveArchive({
    required String fileName,
    required Uint8List bytes,
  }) async {
    try {
      return FilePicker.saveFile(
        dialogTitle: 'Simpan backup Satu Dulu',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: const ['zip'],
        bytes: bytes,
      );
    } catch (error) {
      throw BackupException('File backup belum dapat disimpan.', error);
    }
  }

  @override
  Future<SelectedLocalBackupFile?> pickArchive() async {
    try {
      final result = await FilePicker.pickFiles(
        dialogTitle: 'Pilih backup Satu Dulu',
        type: FileType.custom,
        allowedExtensions: const ['zip'],
        allowMultiple: false,
        withData: false,
      );
      if (result == null) return null;
      final selected = result.files.single;
      if (selected.size <= 0 || selected.size > maxLocalBackupBytes) {
        throw const BackupException(
          'Ukuran file backup tidak valid atau melebihi 256 MB.',
        );
      }
      final path = selected.path;
      if (path == null) {
        throw const BackupException(
          'File backup tidak dapat dibaca dari penyedia Files ini.',
        );
      }
      final file = File(path);
      if (!await file.exists()) {
        throw const BackupException('File backup tidak ditemukan.');
      }
      return SelectedLocalBackupFile(
        name: selected.name,
        bytes: await file.readAsBytes(),
      );
    } on BackupException {
      rethrow;
    } catch (error) {
      throw BackupException('File backup belum dapat dibuka.', error);
    }
  }

  @override
  Future<LocalBackupFileRestore> stagePdfRestore(
    Map<String, Uint8List> pdfBytes,
  ) async {
    final documents = await getApplicationDocumentsDirectory();
    final transactionId = _uuid.v4();
    final stagingRoot = Directory(
      '${documents.path}${Platform.pathSeparator}.satu-dulu-restore-$transactionId',
    );
    final stagingPdfs = Directory(
      '${stagingRoot.path}${Platform.pathSeparator}pdfs',
    );
    final rollback = Directory(
      '${documents.path}${Platform.pathSeparator}.satu-dulu-rollback-$transactionId',
    );
    try {
      await stagingPdfs.create(recursive: true);
      final entries = pdfBytes.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      for (final entry in entries) {
        _validatePdfPath(entry.key);
        final name = entry.key.substring('pdfs/'.length);
        final target = File(
          '${stagingPdfs.path}${Platform.pathSeparator}$name',
        );
        await target.writeAsBytes(entry.value, flush: true);
      }
      return _NativeLocalBackupFileRestore(
        activePdfs: Directory('${documents.path}${Platform.pathSeparator}pdfs'),
        stagingRoot: stagingRoot,
        stagingPdfs: stagingPdfs,
        rollbackPdfs: rollback,
      );
    } on BackupException {
      if (await stagingRoot.exists()) {
        await stagingRoot.delete(recursive: true);
      }
      rethrow;
    } catch (error) {
      if (await stagingRoot.exists()) {
        await stagingRoot.delete(recursive: true);
      }
      throw BackupException('PDF restore belum dapat disiapkan.', error);
    }
  }

  String _absolutePdfPath(Directory documents, String relativePath) {
    final name = relativePath.substring('pdfs/'.length);
    return '${documents.path}${Platform.pathSeparator}pdfs${Platform.pathSeparator}$name';
  }

  void _validatePdfPath(String value) {
    if (!_pdfPathPattern.hasMatch(value)) {
      throw const BackupException('Path PDF backup tidak valid.');
    }
  }
}

class _NativeLocalBackupFileRestore implements LocalBackupFileRestore {
  _NativeLocalBackupFileRestore({
    required this.activePdfs,
    required this.stagingRoot,
    required this.stagingPdfs,
    required this.rollbackPdfs,
  });

  final Directory activePdfs;
  final Directory stagingRoot;
  final Directory stagingPdfs;
  final Directory rollbackPdfs;
  bool _activated = false;
  bool _finished = false;

  @override
  Future<void> activate() async {
    if (_finished || _activated) {
      throw const BackupException('Tahap restore file tidak valid.');
    }
    try {
      if (await activePdfs.exists()) {
        await activePdfs.rename(rollbackPdfs.path);
      }
      try {
        await stagingPdfs.rename(activePdfs.path);
        _activated = true;
      } catch (_) {
        if (await rollbackPdfs.exists() && !await activePdfs.exists()) {
          await rollbackPdfs.rename(activePdfs.path);
        }
        rethrow;
      }
    } catch (error) {
      throw BackupException('Penyimpanan PDF belum dapat diganti.', error);
    }
  }

  @override
  Future<void> commit() async {
    if (_finished || !_activated) {
      throw const BackupException('Restore file belum aktif.');
    }
    _finished = true;
    try {
      if (await rollbackPdfs.exists()) {
        await rollbackPdfs.delete(recursive: true);
      }
      if (await stagingRoot.exists()) {
        await stagingRoot.delete(recursive: true);
      }
    } catch (error) {
      throw BackupException(
        'Data sudah pulih, tetapi file sementara belum terbersihkan.',
        error,
      );
    }
  }

  @override
  Future<void> rollback() async {
    if (_finished) return;
    _finished = true;
    try {
      if (_activated && await activePdfs.exists()) {
        await activePdfs.delete(recursive: true);
      }
      if (await rollbackPdfs.exists()) {
        await rollbackPdfs.rename(activePdfs.path);
      }
      if (await stagingRoot.exists()) {
        await stagingRoot.delete(recursive: true);
      }
    } catch (error) {
      throw BackupException(
        'Rollback PDF tidak selesai. Jangan tutup aplikasi dan coba lagi.',
        error,
      );
    }
  }
}
