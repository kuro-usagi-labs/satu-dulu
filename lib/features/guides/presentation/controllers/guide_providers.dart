import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/guides/application/guide_import_coordinator.dart';
import 'package:satu_dulu/features/guides/data/repositories/drift_guide_repository.dart';
import 'package:satu_dulu/features/guides/data/services/guide_file_service_factory.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/domain/repositories/guide_repository.dart';
import 'package:satu_dulu/features/guides/domain/services/guide_file_service.dart';

final guideRepositoryProvider = Provider<GuideRepository>((ref) {
  return DriftGuideRepository(ref.watch(appDatabaseProvider));
});

final guideFileServiceProvider = Provider<GuideFileService>((ref) {
  return createGuideFileService();
});

final guideImportCoordinatorProvider = Provider<GuideImportCoordinator>((ref) {
  return GuideImportCoordinator(
    ref.watch(guideFileServiceProvider),
    ref.watch(guideRepositoryProvider),
  );
});

class GuideSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final guideSearchQueryProvider = NotifierProvider<GuideSearchQuery, String>(
  GuideSearchQuery.new,
);

final guideDocumentsProvider = StreamProvider<List<GuideDocument>>((ref) {
  final query = ref.watch(guideSearchQueryProvider);
  return ref.watch(guideRepositoryProvider).watchDocuments(query: query);
});

final guideDocumentProvider = FutureProvider.autoDispose
    .family<GuideDocument?, String>((ref, documentId) {
      return ref.watch(guideRepositoryProvider).getDocument(documentId);
    });

final guidePathProvider = FutureProvider.autoDispose.family<String, String>((
  ref,
  relativePath,
) {
  return ref.watch(guideFileServiceProvider).resolveAbsolutePath(relativePath);
});

final guideExistsProvider = FutureProvider.autoDispose.family<bool, String>((
  ref,
  relativePath,
) {
  return ref.watch(guideFileServiceProvider).exists(relativePath);
});

final guideBookmarksProvider = StreamProvider.autoDispose
    .family<List<PdfBookmark>, String>((ref, documentId) {
      return ref.watch(guideRepositoryProvider).watchBookmarks(documentId);
    });

final guideNotesProvider = StreamProvider.autoDispose
    .family<List<PdfNote>, String>((ref, documentId) {
      return ref.watch(guideRepositoryProvider).watchNotes(documentId);
    });
