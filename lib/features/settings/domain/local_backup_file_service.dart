import 'dart:typed_data';

import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

abstract interface class LocalBackupFileService {
  bool get isSupported;

  Future<Map<String, Uint8List>> readPdfFiles(Iterable<String> relativePaths);

  Future<String?> saveArchive({
    required String fileName,
    required Uint8List bytes,
  });

  Future<SelectedLocalBackupFile?> pickArchive();

  Future<LocalBackupFileRestore> stagePdfRestore(
    Map<String, Uint8List> pdfBytes,
  );
}

abstract interface class LocalBackupFileRestore {
  Future<void> activate();

  Future<void> commit();

  Future<void> rollback();
}
