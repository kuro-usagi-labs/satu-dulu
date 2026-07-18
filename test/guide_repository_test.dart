import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/application/guide_import_coordinator.dart';
import 'package:satu_dulu/features/guides/data/repositories/drift_guide_repository.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/domain/repositories/guide_repository.dart';
import 'package:satu_dulu/features/guides/domain/services/guide_file_service.dart';

void main() {
  late AppDatabase database;
  late DriftGuideRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftGuideRepository(database);
  });

  tearDown(() => database.close());

  test('metadata rename preserves physical file path', () async {
    await repository.insertDocument(_file(), _metadata(title: 'Nama awal'));

    await repository.updateMetadata('guide-1', _metadata(title: 'Nama baru'));

    final document = await repository.getDocument('guide-1');
    expect(document?.displayTitle, 'Nama baru');
    expect(document?.originalFileName, 'asli.pdf');
    expect(document?.storedRelativePath, 'pdfs/guide-1.pdf');
  });

  test('search is case insensitive across guide metadata', () async {
    await repository.insertDocument(
      _file(),
      _metadata(title: 'Strategi Penawaran', description: 'Validasi pasar'),
    );

    expect(
      await repository.watchDocuments(query: 'PENAWARAN').first,
      hasLength(1),
    );
    expect(
      await repository.watchDocuments(query: 'validasi').first,
      hasLength(1),
    );
    expect(await repository.watchDocuments(query: 'tidak ada').first, isEmpty);
  });

  test(
    'last page is clamped and bookmarks toggle without duplicates',
    () async {
      await repository.insertDocument(_file(pageCount: 8), _metadata());

      await repository.updateLastPage('guide-1', 99);
      expect((await repository.getDocument('guide-1'))?.lastReadPage, 8);

      await repository.toggleBookmark('guide-1', 3);
      await repository.toggleBookmark('guide-1', 3);
      expect(await repository.watchBookmarks('guide-1').first, isEmpty);
    },
  );

  test('deleting guide cascades bookmarks and notes', () async {
    await repository.insertDocument(_file(), _metadata());
    await repository.toggleBookmark('guide-1', 2);
    await repository.saveNote('guide-1', 2, 'Ingat bagian ini');

    await repository.deleteMetadata('guide-1');

    expect(await repository.getDocument('guide-1'), isNull);
    expect(await repository.watchBookmarks('guide-1').first, isEmpty);
    expect(await repository.watchNotes('guide-1').first, isEmpty);
  });

  test('failed metadata save rolls back the staged physical file', () async {
    final files = _RecordingFileService();
    final coordinator = GuideImportCoordinator(files, _FailingRepository());

    await expectLater(
      coordinator.save(_file(), _metadata()),
      throwsA(isA<DatabaseException>()),
    );

    expect(files.deletedPaths, ['pdfs/guide-1.pdf']);
  });

  test('delete removes metadata before touching the physical file', () async {
    final events = <String>[];
    final files = _RecordingFileService(events: events);
    final coordinator = GuideImportCoordinator(
      files,
      _DeletionRepository(events),
    );
    final document = GuideDocument(
      id: 'guide-1',
      originalFileName: 'asli.pdf',
      displayTitle: 'Panduan fokus',
      storedRelativePath: 'pdfs/guide-1.pdf',
      fileSizeBytes: 1024,
      category: 'Strategi',
      isPinned: false,
      pageCount: 12,
      lastReadPage: 1,
      importedAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );

    expect(await coordinator.deleteDocument(document), isNull);
    expect(events, ['metadata', 'file']);
  });
}

StagedGuideFile _file({int pageCount = 12}) {
  return StagedGuideFile(
    id: 'guide-1',
    originalFileName: 'asli.pdf',
    storedRelativePath: 'pdfs/guide-1.pdf',
    absolutePath: '/tmp/pdfs/guide-1.pdf',
    fileSizeBytes: 1024,
    pageCount: pageCount,
  );
}

GuideMetadataInput _metadata({
  String title = 'Panduan fokus',
  String? description,
}) {
  return GuideMetadataInput(
    displayTitle: title,
    category: 'Strategi',
    description: description,
    isPinned: false,
  );
}

class _FailingRepository implements GuideRepository {
  @override
  Future<void> insertDocument(
    StagedGuideFile file,
    GuideMetadataInput metadata,
  ) {
    throw const DatabaseException('Simulasi gagal.');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingFileService implements GuideFileService {
  _RecordingFileService({this.events});

  final deletedPaths = <String>[];
  final List<String>? events;

  @override
  Future<void> delete(String storedRelativePath) async {
    events?.add('file');
    deletedPaths.add(storedRelativePath);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _DeletionRepository implements GuideRepository {
  _DeletionRepository(this.events);

  final List<String> events;

  @override
  Future<void> deleteMetadata(String documentId) async {
    events.add('metadata');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
