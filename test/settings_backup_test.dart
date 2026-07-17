import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/application/local_backup_coordinator.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';
import 'package:satu_dulu/features/settings/presentation/controllers/settings_providers.dart';
import 'package:satu_dulu/features/settings/presentation/widgets/local_backup_section.dart';

void main() {
  testWidgets('compact backup section creates one full local copy', (
    tester,
  ) async {
    _useCompactViewport(tester);
    final actions = _FakeBackupActions();
    await _pumpSection(tester, actions);

    expect(find.text('Satu file, seluruh arahmu'), findsOneWidget);
    expect(find.text('ZIP ke Files'), findsOneWidget);
    expect(tester.takeException(), isNull);

    final createButton = find.byKey(const Key('create-local-backup'));
    await tester.ensureVisible(createButton);
    await tester.pumpAndSettle();
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    expect(actions.createCalls, 1);
    expect(find.text('Backup tersimpan'), findsOneWidget);
    expect(find.textContaining('3 proyek dan 2 PDF'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('restore previews content and requires explicit confirmation', (
    tester,
  ) async {
    _useCompactViewport(tester);
    final actions = _FakeBackupActions();
    await _pumpSection(tester, actions);

    final restoreButton = find.byKey(const Key('restore-local-backup'));
    await tester.ensureVisible(restoreButton);
    await tester.pumpAndSettle();
    await tester.tap(restoreButton);
    await tester.pumpAndSettle();

    expect(find.text('Pulihkan backup ini?'), findsOneWidget);
    expect(find.text('3 proyek'), findsOneWidget);
    expect(find.text('2 PDF'), findsOneWidget);
    expect(find.text('Data saat ini akan diganti'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Batal'));
    await tester.pumpAndSettle();
    expect(actions.restoreCalls, 0);

    await tester.ensureVisible(restoreButton);
    await tester.pumpAndSettle();
    await tester.tap(restoreButton);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm-local-restore')));
    await tester.pumpAndSettle();

    expect(actions.restoreCalls, 1);
    expect(find.text('Data berhasil dipulihkan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('file failure stays recoverable without losing the actions', (
    tester,
  ) async {
    final actions = _FakeBackupActions()
      ..createError = const BackupException('Files sedang tidak tersedia.');
    await _pumpSection(tester, actions);

    await tester.tap(find.byKey(const Key('create-local-backup')));
    await tester.pumpAndSettle();

    expect(find.text('Backup belum selesai'), findsOneWidget);
    expect(find.text('Files sedang tidak tersedia.'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Buat backup sekarang'),
          )
          .onPressed,
      isNotNull,
    );
  });
}

Future<void> _pumpSection(WidgetTester tester, LocalBackupActions actions) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [localBackupCoordinatorProvider.overrideWithValue(actions)],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.standard),
              child: LocalBackupSection(),
            ),
          ),
        ),
      ),
    ),
  );
}

void _useCompactViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 640);
  tester.platformDispatcher.textScaleFactorTestValue = 1.3;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

class _FakeBackupActions implements LocalBackupActions {
  int createCalls = 0;
  int inspectCalls = 0;
  int restoreCalls = 0;
  Object? createError;

  @override
  bool get isSupported => true;

  @override
  Future<LocalBackupSaveResult?> createBackup() async {
    createCalls += 1;
    if (createError case final error?) throw error;
    return LocalBackupSaveResult(
      fileName: 'satu-dulu-backup.zip',
      manifest: _manifest(),
      sizeBytes: 1024,
    );
  }

  @override
  Future<PreparedLocalBackup?> inspectBackup() async {
    inspectCalls += 1;
    return PreparedLocalBackup(
      sourceName: 'satu-dulu-backup.zip',
      manifest: _manifest(),
      snapshot: _snapshot(),
      pdfBytes: {
        'pdfs/one.pdf': Uint8List.fromList('%PDF-one'.codeUnits),
        'pdfs/two.pdf': Uint8List.fromList('%PDF-two'.codeUnits),
      },
    );
  }

  @override
  Future<LocalBackupRestoreResult> restoreBackup(
    PreparedLocalBackup backup,
  ) async {
    restoreCalls += 1;
    return const LocalBackupRestoreResult();
  }
}

LocalBackupManifest _manifest() {
  final counts = _snapshot().counts..['projects'] = 3;
  final checksum = List.filled(64, '0').join();
  return LocalBackupManifest(
    createdAt: DateTime.utc(2026, 7, 17, 9, 30),
    databaseSchemaVersion: 2,
    dataSha256: checksum,
    counts: counts,
    pdfs: [
      BackupPdfEntry(path: 'pdfs/one.pdf', sizeBytes: 8, sha256: checksum),
      BackupPdfEntry(path: 'pdfs/two.pdf', sizeBytes: 8, sha256: checksum),
    ],
  );
}

BackupDataSnapshot _snapshot() {
  return BackupDataSnapshot(
    databaseSchemaVersion: 2,
    tables: {
      for (final name in localBackupTableNames) name: <Map<String, dynamic>>[],
    },
  );
}
