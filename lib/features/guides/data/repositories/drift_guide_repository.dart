import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/domain/repositories/guide_repository.dart';
import 'package:uuid/uuid.dart';

class DriftGuideRepository implements GuideRepository {
  DriftGuideRepository(this._database, [this._uuid = const Uuid()]);

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Stream<List<GuideDocument>> watchDocuments({String query = ''}) {
    final joined =
        _database.select(_database.guideDocuments).join([
          leftOuterJoin(
            _database.projects,
            _database.projects.id.equalsExp(_database.guideDocuments.projectId),
          ),
        ])..orderBy([
          OrderingTerm.desc(_database.guideDocuments.isPinned),
          OrderingTerm.desc(_database.guideDocuments.lastOpenedAt),
          OrderingTerm.desc(_database.guideDocuments.importedAt),
        ]);
    final needle = query.trim().toLowerCase();
    return joined.watch().map((rows) {
      final documents = rows.map((row) {
        return _fromRows(
          row.readTable(_database.guideDocuments),
          row.readTableOrNull(_database.projects),
        );
      });
      return List.unmodifiable(
        needle.isEmpty
            ? documents
            : documents.where((document) => _matches(document, needle)),
      );
    });
  }

  @override
  Future<GuideDocument?> getDocument(String documentId) async {
    final joined = _database.select(_database.guideDocuments).join([
      leftOuterJoin(
        _database.projects,
        _database.projects.id.equalsExp(_database.guideDocuments.projectId),
      ),
    ])..where(_database.guideDocuments.id.equals(documentId));
    final row = await joined.getSingleOrNull();
    return row == null
        ? null
        : _fromRows(
            row.readTable(_database.guideDocuments),
            row.readTableOrNull(_database.projects),
          );
  }

  @override
  Future<void> insertDocument(
    StagedGuideFile file,
    GuideMetadataInput metadata,
  ) async {
    _validateMetadata(metadata);
    if (file.pageCount < 1) {
      throw const ValidationException('PDF tidak memiliki halaman.');
    }
    final now = DateTime.now().toUtc();
    try {
      await _database
          .into(_database.guideDocuments)
          .insert(
            GuideDocumentsCompanion.insert(
              id: file.id,
              originalFileName: file.originalFileName,
              displayTitle: metadata.displayTitle.trim(),
              storedRelativePath: file.storedRelativePath,
              fileSizeBytes: file.fileSizeBytes,
              checksum: Value(file.checksum),
              projectId: Value(metadata.projectId),
              category: metadata.category.trim(),
              description: Value(_nullableTrim(metadata.description)),
              whenToRead: Value(_nullableTrim(metadata.whenToRead)),
              isPinned: Value(metadata.isPinned),
              pageCount: file.pageCount,
              importedAt: now,
              updatedAt: now,
            ),
          );
    } catch (error) {
      throw DatabaseException('Metadata PDF tidak dapat disimpan.', error);
    }
  }

  @override
  Future<void> updateMetadata(
    String documentId,
    GuideMetadataInput metadata,
  ) async {
    _validateMetadata(metadata);
    final affected =
        await (_database.update(
          _database.guideDocuments,
        )..where((table) => table.id.equals(documentId))).write(
          GuideDocumentsCompanion(
            displayTitle: Value(metadata.displayTitle.trim()),
            projectId: Value(metadata.projectId),
            category: Value(metadata.category.trim()),
            description: Value(_nullableTrim(metadata.description)),
            whenToRead: Value(_nullableTrim(metadata.whenToRead)),
            isPinned: Value(metadata.isPinned),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    if (affected != 1) {
      throw const DatabaseException('PDF tidak ditemukan.');
    }
  }

  @override
  Future<void> updateLastPage(String documentId, int pageNumber) async {
    final row = await (_database.select(
      _database.guideDocuments,
    )..where((table) => table.id.equals(documentId))).getSingleOrNull();
    if (row == null) throw const DatabaseException('PDF tidak ditemukan.');
    final clamped = pageNumber.clamp(1, row.pageCount);
    final now = DateTime.now().toUtc();
    await (_database.update(
      _database.guideDocuments,
    )..where((table) => table.id.equals(documentId))).write(
      GuideDocumentsCompanion(
        lastReadPage: Value(clamped),
        lastOpenedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> markCleanupNeeded(String documentId) async {
    await (_database.update(_database.guideDocuments)
          ..where((table) => table.id.equals(documentId)))
        .write(const GuideDocumentsCompanion(cleanupNeeded: Value(true)));
  }

  @override
  Future<void> setPrimaryGuide(String projectId, String? documentId) async {
    await (_database.update(
      _database.projects,
    )..where((table) => table.id.equals(projectId))).write(
      ProjectsCompanion(
        primaryGuideDocumentId: Value(documentId),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> deleteMetadata(String documentId) async {
    await _database.transaction(() async {
      await (_database.update(_database.projects)
            ..where((table) => table.primaryGuideDocumentId.equals(documentId)))
          .write(
            ProjectsCompanion(
              primaryGuideDocumentId: const Value(null),
              updatedAt: Value(DateTime.now().toUtc()),
            ),
          );
      await (_database.delete(
        _database.guideDocuments,
      )..where((table) => table.id.equals(documentId))).go();
    });
  }

  @override
  Stream<List<PdfBookmark>> watchBookmarks(String documentId) {
    final query = _database.select(_database.pdfBookmarks)
      ..where((table) => table.documentId.equals(documentId))
      ..orderBy([(table) => OrderingTerm.asc(table.pageNumber)]);
    return query.watch().map(
      (rows) => List.unmodifiable(
        rows.map(
          (row) => PdfBookmark(
            id: row.id,
            pageNumber: row.pageNumber,
            createdAt: row.createdAt.toUtc(),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> toggleBookmark(String documentId, int pageNumber) async {
    if (pageNumber < 1) {
      throw const ValidationException('Nomor halaman tidak valid.');
    }
    final existing =
        await (_database.select(_database.pdfBookmarks)..where(
              (table) =>
                  table.documentId.equals(documentId) &
                  table.pageNumber.equals(pageNumber),
            ))
            .getSingleOrNull();
    if (existing == null) {
      await _database
          .into(_database.pdfBookmarks)
          .insert(
            PdfBookmarksCompanion.insert(
              id: _uuid.v4(),
              documentId: documentId,
              pageNumber: pageNumber,
              createdAt: DateTime.now().toUtc(),
            ),
          );
    } else {
      await (_database.delete(
        _database.pdfBookmarks,
      )..where((table) => table.id.equals(existing.id))).go();
    }
  }

  @override
  Stream<List<PdfNote>> watchNotes(String documentId) {
    final query = _database.select(_database.pdfNotes)
      ..where((table) => table.documentId.equals(documentId))
      ..orderBy([
        (table) => OrderingTerm.asc(table.pageNumber),
        (table) => OrderingTerm.desc(table.updatedAt),
      ]);
    return query.watch().map(
      (rows) => List.unmodifiable(
        rows.map(
          (row) => PdfNote(
            id: row.id,
            pageNumber: row.pageNumber,
            content: row.content,
            createdAt: row.createdAt.toUtc(),
            updatedAt: row.updatedAt.toUtc(),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> saveNote(
    String documentId,
    int pageNumber,
    String content,
  ) async {
    if (pageNumber < 1 || content.trim().isEmpty) {
      throw const ValidationException('Catatan dan halaman wajib valid.');
    }
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.pdfNotes)
        .insert(
          PdfNotesCompanion.insert(
            id: _uuid.v4(),
            documentId: documentId,
            pageNumber: pageNumber,
            content: content.trim(),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  void _validateMetadata(GuideMetadataInput metadata) {
    if (metadata.displayTitle.trim().isEmpty) {
      throw const ValidationException('Judul panduan wajib diisi.');
    }
    if (metadata.category.trim().isEmpty) {
      throw const ValidationException('Kategori panduan wajib dipilih.');
    }
  }

  bool _matches(GuideDocument document, String needle) {
    return [
      document.displayTitle,
      document.originalFileName,
      document.description,
      document.whenToRead,
      document.category,
      document.projectName,
    ].whereType<String>().any((value) => value.toLowerCase().contains(needle));
  }

  GuideDocument _fromRows(GuideDocumentRow row, ProjectRow? project) {
    return GuideDocument(
      id: row.id,
      originalFileName: row.originalFileName,
      displayTitle: row.displayTitle,
      storedRelativePath: row.storedRelativePath,
      fileSizeBytes: row.fileSizeBytes,
      checksum: row.checksum,
      projectId: row.projectId,
      projectName: project?.name,
      category: row.category,
      description: row.description,
      whenToRead: row.whenToRead,
      isPinned: row.isPinned,
      pageCount: row.pageCount,
      lastReadPage: row.lastReadPage,
      lastOpenedAt: row.lastOpenedAt?.toUtc(),
      importedAt: row.importedAt.toUtc(),
      updatedAt: row.updatedAt.toUtc(),
      cleanupNeeded: row.cleanupNeeded,
    );
  }

  String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
