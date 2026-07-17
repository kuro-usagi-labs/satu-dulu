import 'dart:typed_data';

import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_file_service.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

LocalBackupFileService createPlatformLocalBackupFileService() {
  return const UnsupportedLocalBackupFileService();
}

class UnsupportedLocalBackupFileService implements LocalBackupFileService {
  const UnsupportedLocalBackupFileService();

  @override
  bool get isSupported => false;

  Never _unsupported() {
    throw const BackupException(
      'Backup dan restore tersedia pada build iOS, bukan preview web.',
    );
  }

  @override
  Future<SelectedLocalBackupFile?> pickArchive() async => _unsupported();

  @override
  Future<Map<String, Uint8List>> readPdfFiles(
    Iterable<String> relativePaths,
  ) async => _unsupported();

  @override
  Future<String?> saveArchive({
    required String fileName,
    required Uint8List bytes,
  }) async => _unsupported();

  @override
  Future<LocalBackupFileRestore> stagePdfRestore(
    Map<String, Uint8List> pdfBytes,
  ) async => _unsupported();
}
