import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';

abstract interface class GuideFileService {
  Future<StagedGuideFile> stageImport({
    required String sourcePath,
    required String originalFileName,
    required String documentId,
  });

  Future<String> resolveAbsolutePath(String storedRelativePath);

  Future<bool> exists(String storedRelativePath);

  Future<void> delete(String storedRelativePath);
}
