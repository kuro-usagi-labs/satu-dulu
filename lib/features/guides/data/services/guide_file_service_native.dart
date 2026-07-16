import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/domain/services/guide_file_service.dart';

GuideFileService createPlatformGuideFileService() => NativeGuideFileService();

class NativeGuideFileService implements GuideFileService {
  @override
  Future<StagedGuideFile> stageImport({
    required String sourcePath,
    required String originalFileName,
    required String documentId,
  }) async {
    if (!originalFileName.toLowerCase().endsWith('.pdf')) {
      throw const FileImportException('Hanya file PDF yang dapat diimpor.');
    }
    final source = File(sourcePath);
    if (!await source.exists()) {
      throw const FileImportException('File sumber tidak ditemukan.');
    }

    final header = await source
        .openRead(0, 5)
        .fold<List<int>>(<int>[], (buffer, bytes) => buffer..addAll(bytes));
    if (header.length < 5 || String.fromCharCodes(header) != '%PDF-') {
      throw const FileImportException(
        'File yang dipilih bukan PDF yang valid.',
      );
    }

    final directory = await _pdfDirectory();
    final relativePath = 'pdfs/$documentId.pdf';
    final destination = File(
      '${directory.path}${Platform.pathSeparator}$documentId.pdf',
    );
    PdfDocument? document;
    try {
      await source.copy(destination.path);
      document = await PdfDocument.openFile(destination.path);
      final pageCount = document.pages.length;
      if (pageCount < 1) {
        throw const FileImportException('PDF tidak memiliki halaman.');
      }
      final bytes = await destination.readAsBytes();
      return StagedGuideFile(
        id: documentId,
        originalFileName: originalFileName,
        storedRelativePath: relativePath,
        absolutePath: destination.path,
        fileSizeBytes: bytes.length,
        checksum: sha256.convert(bytes).toString(),
        pageCount: pageCount,
      );
    } on AppException {
      if (await destination.exists()) await destination.delete();
      rethrow;
    } catch (error) {
      if (await destination.exists()) await destination.delete();
      throw FileImportException(
        'PDF tidak dapat dibaca atau dilindungi password.',
        error,
      );
    } finally {
      await document?.dispose();
    }
  }

  @override
  Future<String> resolveAbsolutePath(String storedRelativePath) async {
    _validateRelativePath(storedRelativePath);
    final documents = await getApplicationDocumentsDirectory();
    final platformPath = storedRelativePath.replaceAll(
      '/',
      Platform.pathSeparator,
    );
    return '${documents.path}${Platform.pathSeparator}$platformPath';
  }

  @override
  Future<bool> exists(String storedRelativePath) async {
    return File(await resolveAbsolutePath(storedRelativePath)).exists();
  }

  @override
  Future<void> delete(String storedRelativePath) async {
    final file = File(await resolveAbsolutePath(storedRelativePath));
    if (await file.exists()) await file.delete();
  }

  Future<Directory> _pdfDirectory() async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(
      '${documents.path}${Platform.pathSeparator}pdfs',
    );
    if (!await directory.exists()) await directory.create(recursive: true);
    return directory;
  }

  void _validateRelativePath(String value) {
    if (!RegExp(r'^pdfs/[a-zA-Z0-9-]+\.pdf$').hasMatch(value)) {
      throw const FileImportException('Path PDF lokal tidak valid.');
    }
  }
}
