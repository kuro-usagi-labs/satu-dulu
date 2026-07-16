class GuideDocument {
  const GuideDocument({
    required this.id,
    required this.originalFileName,
    required this.displayTitle,
    required this.storedRelativePath,
    required this.fileSizeBytes,
    required this.category,
    required this.isPinned,
    required this.pageCount,
    required this.lastReadPage,
    required this.importedAt,
    required this.updatedAt,
    this.checksum,
    this.projectId,
    this.projectName,
    this.description,
    this.whenToRead,
    this.lastOpenedAt,
    this.cleanupNeeded = false,
  });

  final String id;
  final String originalFileName;
  final String displayTitle;
  final String storedRelativePath;
  final int fileSizeBytes;
  final String? checksum;
  final String? projectId;
  final String? projectName;
  final String category;
  final String? description;
  final String? whenToRead;
  final bool isPinned;
  final int pageCount;
  final int lastReadPage;
  final DateTime? lastOpenedAt;
  final DateTime importedAt;
  final DateTime updatedAt;
  final bool cleanupNeeded;

  double get progress => pageCount <= 0 ? 0 : lastReadPage / pageCount;
}

class StagedGuideFile {
  const StagedGuideFile({
    required this.id,
    required this.originalFileName,
    required this.storedRelativePath,
    required this.absolutePath,
    required this.fileSizeBytes,
    required this.pageCount,
    this.checksum,
  });

  final String id;
  final String originalFileName;
  final String storedRelativePath;
  final String absolutePath;
  final int fileSizeBytes;
  final int pageCount;
  final String? checksum;
}

class GuideMetadataInput {
  const GuideMetadataInput({
    required this.displayTitle,
    required this.category,
    required this.isPinned,
    this.projectId,
    this.description,
    this.whenToRead,
  });

  final String displayTitle;
  final String? projectId;
  final String category;
  final String? description;
  final String? whenToRead;
  final bool isPinned;
}

class PdfBookmark {
  const PdfBookmark({
    required this.id,
    required this.pageNumber,
    required this.createdAt,
  });

  final String id;
  final int pageNumber;
  final DateTime createdAt;
}

class PdfNote {
  const PdfNote({
    required this.id,
    required this.pageNumber,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final int pageNumber;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
}
