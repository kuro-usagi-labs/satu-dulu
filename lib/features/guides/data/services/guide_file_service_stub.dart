import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/domain/services/guide_file_service.dart';

GuideFileService createPlatformGuideFileService() =>
    const UnsupportedGuideFileService();

class UnsupportedGuideFileService implements GuideFileService {
  const UnsupportedGuideFileService();

  Never _unsupported() {
    throw const FileImportException(
      'Import PDF tersedia pada build iOS. Preview web hanya untuk melihat UI.',
    );
  }

  @override
  Future<void> delete(String storedRelativePath) async => _unsupported();

  @override
  Future<bool> exists(String storedRelativePath) async => _unsupported();

  @override
  Future<String> resolveAbsolutePath(String storedRelativePath) async =>
      _unsupported();

  @override
  Future<StagedGuideFile> stageImport({
    required String sourcePath,
    required String originalFileName,
    required String documentId,
  }) async => _unsupported();
}
