import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';

abstract interface class GuideRepository {
  Stream<List<GuideDocument>> watchDocuments({String query = ''});

  Future<GuideDocument?> getDocument(String documentId);

  Future<void> insertDocument(
    StagedGuideFile file,
    GuideMetadataInput metadata,
  );

  Future<void> updateMetadata(String documentId, GuideMetadataInput metadata);

  Future<void> updateLastPage(String documentId, int pageNumber);

  Future<void> markCleanupNeeded(String documentId);

  Future<void> setPrimaryGuide(String projectId, String? documentId);

  Future<void> deleteMetadata(String documentId);

  Stream<List<PdfBookmark>> watchBookmarks(String documentId);

  Future<void> toggleBookmark(String documentId, int pageNumber);

  Stream<List<PdfNote>> watchNotes(String documentId);

  Future<void> saveNote(String documentId, int pageNumber, String content);
}
