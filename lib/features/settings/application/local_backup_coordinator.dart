import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/data/local_backup_archive_codec.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_file_service.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_repository.dart';

abstract interface class LocalBackupActions {
  bool get isSupported;

  Future<LocalBackupSaveResult?> createBackup();

  Future<PreparedLocalBackup?> inspectBackup();

  Future<LocalBackupRestoreResult> restoreBackup(PreparedLocalBackup backup);
}

class LocalBackupCoordinator implements LocalBackupActions {
  LocalBackupCoordinator(
    this._repository,
    this._files, {
    this._codec = const LocalBackupArchiveCodec(),
    DateTime Function()? clock,
    this._onRestored,
  }) : _clock = clock ?? DateTime.now;

  final LocalBackupRepository _repository;
  final LocalBackupFileService _files;
  final LocalBackupArchiveCodec _codec;
  final DateTime Function() _clock;
  final Future<void> Function()? _onRestored;

  @override
  bool get isSupported => _files.isSupported;

  @override
  Future<LocalBackupSaveResult?> createBackup() async {
    _requireSupport();
    final snapshot = await _repository.exportSnapshot();
    _repository.validateSnapshot(snapshot);
    final pdfBytes = await _files.readPdfFiles(snapshot.guidePaths);
    final createdAt = _clock().toUtc();
    final encoded = _codec.encode(
      snapshot: snapshot,
      pdfBytes: pdfBytes,
      createdAt: createdAt,
    );
    final fileName = _fileName(createdAt);
    final savedPath = await _files.saveArchive(
      fileName: fileName,
      bytes: encoded.bytes,
    );
    if (savedPath == null) return null;
    return LocalBackupSaveResult(
      fileName: fileName,
      manifest: encoded.manifest,
      sizeBytes: encoded.bytes.length,
    );
  }

  @override
  Future<PreparedLocalBackup?> inspectBackup() async {
    _requireSupport();
    final selected = await _files.pickArchive();
    if (selected == null) return null;
    final prepared = _codec.decode(
      sourceName: selected.name,
      bytes: selected.bytes,
    );
    _repository.validateSnapshot(prepared.snapshot);
    return prepared;
  }

  @override
  Future<LocalBackupRestoreResult> restoreBackup(
    PreparedLocalBackup backup,
  ) async {
    _requireSupport();
    _repository.validateSnapshot(backup.snapshot);
    final fileRestore = await _files.stagePdfRestore(backup.pdfBytes);
    try {
      await fileRestore.activate();
      await _repository.restoreSnapshot(backup.snapshot);
    } catch (error) {
      try {
        await fileRestore.rollback();
      } catch (rollbackError) {
        throw BackupException(
          'Restore gagal dan PDF lama belum dapat dikembalikan sepenuhnya.',
          rollbackError,
        );
      }
      if (error is AppException) rethrow;
      throw BackupException(
        'Restore gagal. Data sebelumnya tetap dipertahankan.',
        error,
      );
    }

    String? warning;
    try {
      await fileRestore.commit();
    } on AppException catch (error) {
      warning = error.message;
    }
    try {
      await _onRestored?.call();
    } catch (_) {
      const notificationWarning =
          'Data sudah pulih, tetapi jadwal pengingat perlu disimpan ulang.';
      warning = warning == null
          ? notificationWarning
          : '$warning $notificationWarning';
    }
    return LocalBackupRestoreResult(warning: warning);
  }

  void _requireSupport() {
    if (!isSupported) {
      throw const BackupException(
        'Backup dan restore tersedia pada build iOS, bukan preview web.',
      );
    }
  }

  String _fileName(DateTime value) {
    String two(int number) => number.toString().padLeft(2, '0');
    return 'satu-dulu-backup-${value.year}-${two(value.month)}-${two(value.day)}-'
        '${two(value.hour)}${two(value.minute)}${two(value.second)}.zip';
  }
}
