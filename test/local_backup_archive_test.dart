import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/data/local_backup_archive_codec.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

void main() {
  const codec = LocalBackupArchiveCodec();
  final createdAt = DateTime.utc(2026, 7, 17, 10, 30);
  final pdf = Uint8List.fromList('%PDF-backup-fixture'.codeUnits);

  test('archive round-trip verifies manifest, data, and PDF', () {
    final encoded = codec.encode(
      snapshot: _snapshotWithGuide(),
      pdfBytes: {'pdfs/guide-one.pdf': pdf},
      createdAt: createdAt,
    );

    final restored = codec.decode(
      sourceName: 'backup.zip',
      bytes: encoded.bytes,
    );

    expect(restored.manifest.createdAt, createdAt);
    expect(restored.manifest.projectCount, 0);
    expect(restored.manifest.pdfCount, 1);
    expect(restored.snapshot.toJson(), _snapshotWithGuide().toJson());
    expect(restored.pdfBytes['pdfs/guide-one.pdf'], pdf);
  });

  test('archive rejects a PDF whose checksum no longer matches', () {
    final encoded = codec.encode(
      snapshot: _snapshotWithGuide(),
      pdfBytes: {'pdfs/guide-one.pdf': pdf},
      createdAt: createdAt,
    );
    final tampered = _rewriteArchive(encoded.bytes, {
      'pdfs/guide-one.pdf': Uint8List.fromList('%PDF-changed'.codeUnits),
    });

    expect(
      () => codec.decode(sourceName: 'tampered.zip', bytes: tampered),
      throwsA(
        isA<BackupException>().having(
          (error) => error.message,
          'message',
          contains('PDF'),
        ),
      ),
    );
  });

  test('archive rejects foreign and traversal entries before restore', () {
    final encoded = codec.encode(
      snapshot: _snapshotWithGuide(),
      pdfBytes: {'pdfs/guide-one.pdf': pdf},
      createdAt: createdAt,
    );
    final decoded = ZipDecoder().decodeBytes(encoded.bytes);
    final archive = Archive();
    for (final entry in decoded) {
      archive.add(ArchiveFile.bytes(entry.name, entry.content));
    }
    archive.add(ArchiveFile.string('../outside.txt', 'not allowed'));
    final unsafe = ZipEncoder().encodeBytes(archive);

    expect(
      () => codec.decode(sourceName: 'unsafe.zip', bytes: unsafe),
      throwsA(
        isA<BackupException>().having(
          (error) => error.message,
          'message',
          contains('path'),
        ),
      ),
    );
  });

  test('archive refuses metadata when its PDF is missing', () {
    expect(
      () => codec.encode(
        snapshot: _snapshotWithGuide(),
        pdfBytes: const {},
        createdAt: createdAt,
      ),
      throwsA(isA<BackupException>()),
    );
  });
}

BackupDataSnapshot _snapshotWithGuide() {
  return BackupDataSnapshot(
    databaseSchemaVersion: AppDatabase.currentSchemaVersion,
    tables: {
      for (final name in localBackupTableNames)
        name: name == 'guideDocuments'
            ? [
                {'storedRelativePath': 'pdfs/guide-one.pdf'},
              ]
            : <Map<String, dynamic>>[],
    },
  );
}

Uint8List _rewriteArchive(
  Uint8List bytes,
  Map<String, Uint8List> replacements,
) {
  final decoded = ZipDecoder().decodeBytes(bytes);
  final archive = Archive();
  for (final entry in decoded) {
    archive.add(
      ArchiveFile.bytes(entry.name, replacements[entry.name] ?? entry.content),
    );
  }
  return ZipEncoder().encodeBytes(archive);
}
