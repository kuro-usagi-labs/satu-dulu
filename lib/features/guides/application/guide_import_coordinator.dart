import 'package:file_picker/file_picker.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/domain/repositories/guide_repository.dart';
import 'package:satu_dulu/features/guides/domain/services/guide_file_service.dart';
import 'package:uuid/uuid.dart';

class GuideImportCoordinator {
  GuideImportCoordinator(
    this._files,
    this._repository, [
    this._uuid = const Uuid(),
  ]);

  final GuideFileService _files;
  final GuideRepository _repository;
  final Uuid _uuid;

  Future<StagedGuideFile?> pickAndStage() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      allowMultiple: false,
      withData: false,
    );
    if (result == null) return null;
    final selected = result.files.single;
    final path = selected.path;
    if (path == null) {
      throw const FileImportException(
        'Preview web tidak menyimpan PDF. Gunakan build iOS untuk import.',
      );
    }
    return _files.stageImport(
      sourcePath: path,
      originalFileName: selected.name,
      documentId: _uuid.v4(),
    );
  }

  Future<void> save(StagedGuideFile staged, GuideMetadataInput metadata) async {
    try {
      await _repository.insertDocument(staged, metadata);
    } catch (error) {
      try {
        await _files.delete(staged.storedRelativePath);
      } catch (_) {
        // The database row was never created, so orphan cleanup runs on launch.
      }
      rethrow;
    }
  }

  Future<void> discard(StagedGuideFile staged) {
    return _files.delete(staged.storedRelativePath);
  }

  Future<String?> deleteDocument(GuideDocument document) async {
    await _repository.deleteMetadata(document.id);
    try {
      await _files.delete(document.storedRelativePath);
    } catch (error) {
      return 'Panduan sudah dihapus dari pustaka. Sisa file lokal akan dibersihkan pada kesempatan berikutnya.';
    }
    return null;
  }
}
