import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/application/local_backup_coordinator.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_file_service.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_repository.dart';

void main() {
  test('create and inspect use one valid local archive', () async {
    final repository = _FakeBackupRepository(_emptySnapshot());
    final files = _FakeBackupFileService();
    final coordinator = LocalBackupCoordinator(
      repository,
      files,
      clock: () => DateTime.utc(2026, 7, 17, 8, 9, 10),
    );

    final saved = await coordinator.createBackup();
    expect(saved?.fileName, 'satu-dulu-backup-2026-07-17-080910.zip');
    expect(files.savedBytes, isNotEmpty);

    files.selected = SelectedLocalBackupFile(
      name: saved!.fileName,
      bytes: files.savedBytes!,
    );
    final inspected = await coordinator.inspectBackup();
    expect(inspected?.manifest.createdAt, DateTime.utc(2026, 7, 17, 8, 9, 10));
    expect(repository.validationCount, 2);
  });

  test('database failure activates compensating PDF rollback', () async {
    final repository = _FakeBackupRepository(_emptySnapshot())
      ..restoreError = const DatabaseException('simulated');
    final files = _FakeBackupFileService();
    final coordinator = LocalBackupCoordinator(repository, files);

    await expectLater(
      coordinator.restoreBackup(_preparedBackup()),
      throwsA(isA<DatabaseException>()),
    );

    expect(files.restore.activated, isTrue);
    expect(files.restore.rolledBack, isTrue);
    expect(files.restore.committed, isFalse);
  });

  test('cleanup failure is a warning after restored data commits', () async {
    final repository = _FakeBackupRepository(_emptySnapshot());
    final files = _FakeBackupFileService()
      ..restore.commitError = const BackupException('cleanup warning');
    final coordinator = LocalBackupCoordinator(repository, files);

    final result = await coordinator.restoreBackup(_preparedBackup());

    expect(repository.restoreCount, 1);
    expect(files.restore.rolledBack, isFalse);
    expect(result.warning, contains('cleanup warning'));
  });
}

BackupDataSnapshot _emptySnapshot() {
  return BackupDataSnapshot(
    databaseSchemaVersion: 2,
    tables: {
      for (final name in localBackupTableNames) name: <Map<String, dynamic>>[],
    },
  );
}

PreparedLocalBackup _preparedBackup() {
  final snapshot = _emptySnapshot();
  return PreparedLocalBackup(
    sourceName: 'backup.zip',
    manifest: LocalBackupManifest(
      createdAt: DateTime.utc(2026, 7, 17),
      databaseSchemaVersion: 2,
      dataSha256: List.filled(64, '0').join(),
      counts: snapshot.counts,
      pdfs: const [],
    ),
    snapshot: snapshot,
    pdfBytes: const {},
  );
}

class _FakeBackupRepository implements LocalBackupRepository {
  _FakeBackupRepository(this.snapshot);

  final BackupDataSnapshot snapshot;
  Object? restoreError;
  int validationCount = 0;
  int restoreCount = 0;

  @override
  Future<BackupDataSnapshot> exportSnapshot() async => snapshot;

  @override
  Future<void> restoreSnapshot(BackupDataSnapshot snapshot) async {
    restoreCount += 1;
    if (restoreError case final error?) throw error;
  }

  @override
  void validateSnapshot(BackupDataSnapshot snapshot) {
    validationCount += 1;
  }
}

class _FakeBackupFileService implements LocalBackupFileService {
  SelectedLocalBackupFile? selected;
  Uint8List? savedBytes;
  final restore = _FakeFileRestore();

  @override
  bool get isSupported => true;

  @override
  Future<SelectedLocalBackupFile?> pickArchive() async => selected;

  @override
  Future<Map<String, Uint8List>> readPdfFiles(
    Iterable<String> relativePaths,
  ) async => const {};

  @override
  Future<String?> saveArchive({
    required String fileName,
    required Uint8List bytes,
  }) async {
    savedBytes = bytes;
    return '/saved/$fileName';
  }

  @override
  Future<LocalBackupFileRestore> stagePdfRestore(
    Map<String, Uint8List> pdfBytes,
  ) async => restore;
}

class _FakeFileRestore implements LocalBackupFileRestore {
  bool activated = false;
  bool committed = false;
  bool rolledBack = false;
  Object? commitError;

  @override
  Future<void> activate() async {
    activated = true;
  }

  @override
  Future<void> commit() async {
    committed = true;
    if (commitError case final error?) throw error;
  }

  @override
  Future<void> rollback() async {
    rolledBack = true;
  }
}
