import 'dart:typed_data';

const localBackupFormat = 'satu-dulu-backup';
const localBackupFormatVersion = 1;
const maxLocalBackupBytes = 256 * 1024 * 1024;
const maxLocalBackupEntries = 1002;

const localBackupTableNames = <String>[
  'projects',
  'ideas',
  'restartCapsules',
  'dailyCheckIns',
  'sprints',
  'dailyPlans',
  'dailyActions',
  'shipRecords',
  'guideDocuments',
  'pdfBookmarks',
  'pdfNotes',
  'metricEntries',
  'weeklyReviews',
  'notificationPreferences',
  'sprintClosures',
];

class BackupDataSnapshot {
  const BackupDataSnapshot({
    required this.databaseSchemaVersion,
    required this.tables,
  });

  final int databaseSchemaVersion;
  final Map<String, List<Map<String, dynamic>>> tables;

  Map<String, int> get counts => {
    for (final name in localBackupTableNames) name: tables[name]?.length ?? 0,
  };

  List<String> get guidePaths {
    final paths = <String>[];
    for (final row in tables['guideDocuments'] ?? const []) {
      final path = row['storedRelativePath'];
      if (path is String) paths.add(path);
    }
    paths.sort();
    return List.unmodifiable(paths);
  }

  Map<String, dynamic> toJson() => {
    'databaseSchemaVersion': databaseSchemaVersion,
    'tables': {
      for (final name in localBackupTableNames)
        name: tables[name] ?? const <Map<String, dynamic>>[],
    },
  };

  factory BackupDataSnapshot.fromJson(Map<String, dynamic> json) {
    final schema = json['databaseSchemaVersion'];
    final rawTables = json['tables'];
    if (schema is! int || rawTables is! Map) {
      throw const FormatException('Snapshot database tidak lengkap.');
    }

    final tables = <String, List<Map<String, dynamic>>>{};
    for (final name in localBackupTableNames) {
      final rawRows = rawTables[name];
      if (rawRows is! List) {
        throw FormatException('Tabel backup $name tidak tersedia.');
      }
      tables[name] = [
        for (final row in rawRows)
          if (row is Map)
            Map<String, dynamic>.from(row)
          else
            throw FormatException('Isi tabel $name tidak valid.'),
      ];
    }

    final names = rawTables.keys.whereType<String>().toSet();
    if (names.length != localBackupTableNames.length ||
        !names.containsAll(localBackupTableNames)) {
      throw const FormatException('Daftar tabel backup tidak dikenali.');
    }
    return BackupDataSnapshot(
      databaseSchemaVersion: schema,
      tables: Map.unmodifiable(tables),
    );
  }
}

class BackupPdfEntry {
  const BackupPdfEntry({
    required this.path,
    required this.sizeBytes,
    required this.sha256,
  });

  final String path;
  final int sizeBytes;
  final String sha256;

  Map<String, dynamic> toJson() => {
    'path': path,
    'sizeBytes': sizeBytes,
    'sha256': sha256,
  };
}

class LocalBackupManifest {
  const LocalBackupManifest({
    required this.createdAt,
    required this.databaseSchemaVersion,
    required this.dataSha256,
    required this.counts,
    required this.pdfs,
  });

  final DateTime createdAt;
  final int databaseSchemaVersion;
  final String dataSha256;
  final Map<String, int> counts;
  final List<BackupPdfEntry> pdfs;

  int get projectCount => counts['projects'] ?? 0;
  int get pdfCount => pdfs.length;

  Map<String, dynamic> toJson() => {
    'format': localBackupFormat,
    'formatVersion': localBackupFormatVersion,
    'createdAtUtc': createdAt.toUtc().toIso8601String(),
    'databaseSchemaVersion': databaseSchemaVersion,
    'dataSha256': dataSha256,
    'counts': counts,
    'pdfs': [for (final pdf in pdfs) pdf.toJson()],
  };
}

class EncodedLocalBackup {
  const EncodedLocalBackup({required this.bytes, required this.manifest});

  final Uint8List bytes;
  final LocalBackupManifest manifest;
}

class SelectedLocalBackupFile {
  const SelectedLocalBackupFile({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;
}

class PreparedLocalBackup {
  const PreparedLocalBackup({
    required this.sourceName,
    required this.manifest,
    required this.snapshot,
    required this.pdfBytes,
  });

  final String sourceName;
  final LocalBackupManifest manifest;
  final BackupDataSnapshot snapshot;
  final Map<String, Uint8List> pdfBytes;
}

class LocalBackupSaveResult {
  const LocalBackupSaveResult({
    required this.fileName,
    required this.manifest,
    required this.sizeBytes,
  });

  final String fileName;
  final LocalBackupManifest manifest;
  final int sizeBytes;
}

class LocalBackupRestoreResult {
  const LocalBackupRestoreResult({this.warning});

  final String? warning;
}
