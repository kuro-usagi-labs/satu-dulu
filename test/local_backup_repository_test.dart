import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/data/drift_local_backup_repository.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

void main() {
  test('backup round-trip preserves every schema v3 table', () async {
    final source = AppDatabase.forTesting(NativeDatabase.memory());
    final target = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(source.close);
    addTearDown(target.close);
    await _seedCompleteDatabase(source);
    await _seedOldDatabase(target);

    final sourceRepository = DriftLocalBackupRepository(source);
    final targetRepository = DriftLocalBackupRepository(target);
    final snapshot = await sourceRepository.exportSnapshot();

    expect(snapshot.counts.values.every((count) => count > 0), isTrue);
    sourceRepository.validateSnapshot(snapshot);
    await targetRepository.restoreSnapshot(snapshot);

    final restored = await targetRepository.exportSnapshot();
    expect(restored.toJson(), snapshot.toJson());
  });

  test('constraint failure rolls back the existing database', () async {
    final source = AppDatabase.forTesting(NativeDatabase.memory());
    final target = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(source.close);
    addTearDown(target.close);
    await _seedCompleteDatabase(source);
    await _seedOldDatabase(target);

    final sourceRepository = DriftLocalBackupRepository(source);
    final targetRepository = DriftLocalBackupRepository(target);
    final before = await targetRepository.exportSnapshot();
    final valid = await sourceRepository.exportSnapshot();
    final tables = {
      for (final entry in valid.tables.entries)
        entry.key: [
          for (final row in entry.value) Map<String, dynamic>.from(row),
        ],
    };
    final duplicatePosition = Map<String, dynamic>.from(
      tables['dailyActions']!.single,
    )..['id'] = 'action-duplicate-position';
    tables['dailyActions']!.add(duplicatePosition);
    final invalid = BackupDataSnapshot(
      databaseSchemaVersion: valid.databaseSchemaVersion,
      tables: tables,
    );

    await expectLater(
      targetRepository.restoreSnapshot(invalid),
      throwsA(isA<DatabaseException>()),
    );
    final after = await targetRepository.exportSnapshot();
    expect(after.toJson(), before.toJson());
  });
}

Future<void> _seedCompleteDatabase(AppDatabase database) async {
  final startedAt = DateTime.utc(2026, 1, 1);
  final nextAt = DateTime.utc(2026, 1, 31);
  await database.batch((batch) {
    batch.insert(
      database.projects,
      ProjectsCompanion.insert(
        id: 'project-focus',
        name: 'Toko digital',
        shortGoal: 'Terbitkan produk pertama',
        whyChosen: const Value('Paling dekat ke penjualan'),
        successDefinition: const Value('30 konten dan satu produk'),
        status: 'focus',
        primaryGuideDocumentId: const Value('guide-one'),
        startDate: Value(startedAt),
        reviewDate: Value(nextAt.add(const Duration(days: 29))),
        createdAt: startedAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.ideas,
      IdeasCompanion.insert(
        id: 'idea-one',
        title: 'Coba format carousel',
        note: const Value('Uji setelah putaran aktif selesai'),
        disposition: 'inbox',
        capturedAt: startedAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.restartCapsules,
      RestartCapsulesCompanion.insert(
        id: 'capsule-one',
        projectId: 'project-focus',
        lastKnownState: const Value('Riset topik sudah selesai'),
        nextAction: const Value('Tulis outline video pertama'),
        createdAt: startedAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.dailyCheckIns,
      DailyCheckInsCompanion.insert(
        id: 'check-in-one',
        checkInDate: nextAt,
        energyLevel: 'normal',
        availableMinutes: 45,
        note: const Value('Fokus setelah makan siang'),
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.projects,
      ProjectsCompanion.insert(
        id: 'project-parked',
        name: 'Channel video',
        shortGoal: 'Simpan untuk nanti',
        status: 'parkingLot',
        startDate: Value(startedAt),
        createdAt: startedAt,
        updatedAt: startedAt,
      ),
    );
    batch.insert(
      database.sprints,
      SprintsCompanion.insert(
        id: 'sprint-closed',
        projectId: 'project-focus',
        name: 'Putaran 1',
        startDate: startedAt,
        endDate: startedAt.add(const Duration(days: 29)),
        status: 'completed',
        createdAt: startedAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.sprints,
      SprintsCompanion.insert(
        id: 'sprint-active',
        projectId: 'project-focus',
        name: 'Putaran 2',
        startDate: nextAt,
        endDate: nextAt.add(const Duration(days: 29)),
        status: 'active',
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.dailyPlans,
      DailyPlansCompanion.insert(
        id: 'plan-one',
        sprintId: 'sprint-active',
        planDate: nextAt,
        requiredOutcome: 'Unggah satu video',
        linkedGuideDocumentId: const Value('guide-one'),
        linkedGuidePage: const Value(1),
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.dailyActions,
      DailyActionsCompanion.insert(
        id: 'action-one',
        dailyPlanId: 'plan-one',
        position: 0,
        label: 'Rekam video',
        isCompleted: const Value(true),
        completedAt: Value(nextAt),
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.shipRecords,
      ShipRecordsCompanion.insert(
        id: 'ship-one',
        dailyPlanId: 'plan-one',
        outputType: 'video',
        outputTitle: 'Video pertama',
        evidenceNote: const Value('Sudah tayang'),
        shippedAt: nextAt,
      ),
    );
    batch.insert(
      database.guideDocuments,
      GuideDocumentsCompanion.insert(
        id: 'guide-one',
        originalFileName: 'panduan.pdf',
        displayTitle: 'Panduan jualan',
        storedRelativePath: 'pdfs/guide-one.pdf',
        fileSizeBytes: 12,
        checksum: const Value('checksum'),
        projectId: const Value('project-focus'),
        category: 'Strategi',
        pageCount: 2,
        lastReadPage: const Value(2),
        importedAt: startedAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.pdfBookmarks,
      PdfBookmarksCompanion.insert(
        id: 'bookmark-one',
        documentId: 'guide-one',
        pageNumber: 2,
        createdAt: nextAt,
      ),
    );
    batch.insert(
      database.pdfNotes,
      PdfNotesCompanion.insert(
        id: 'note-one',
        documentId: 'guide-one',
        pageNumber: 2,
        content: 'Coba bagian ini',
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.metricEntries,
      MetricEntriesCompanion.insert(
        id: 'metric-one',
        projectId: 'project-focus',
        entryDate: nextAt,
        outputsCount: const Value(1),
        views: const Value(120),
        orders: const Value(2),
        revenueMinor: const Value(5000000),
        workMinutes: const Value(45),
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.weeklyReviews,
      WeeklyReviewsCompanion.insert(
        id: 'review-one',
        projectId: 'project-focus',
        sprintId: const Value('sprint-closed'),
        weekStart: startedAt,
        weekEnd: startedAt.add(const Duration(days: 6)),
        decision: 'continueFocus',
        nextWeekFocus: const Value('Ulangi format video'),
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.notificationPreferences,
      NotificationPreferencesCompanion.insert(
        id: const Value(1),
        morningEnabled: const Value(true),
        morningMinutes: const Value(450),
        timeZoneId: const Value('Asia/Jakarta'),
        updatedAt: nextAt,
      ),
    );
    batch.insert(
      database.sprintClosures,
      SprintClosuresCompanion.insert(
        id: 'closure-one',
        sprintId: 'sprint-closed',
        decision: 'continueFocus',
        evidenceSummary: const Value('Satu format mulai bekerja'),
        nextSprintId: const Value('sprint-active'),
        closedAt: nextAt,
        createdAt: nextAt,
        updatedAt: nextAt,
      ),
    );
  });
}

Future<void> _seedOldDatabase(AppDatabase database) async {
  final now = DateTime.utc(2025, 1, 1);
  await database
      .into(database.projects)
      .insert(
        ProjectsCompanion.insert(
          id: 'old-project',
          name: 'Data sekarang',
          shortGoal: 'Harus bertahan bila restore gagal',
          status: 'focus',
          createdAt: now,
          updatedAt: now,
        ),
      );
}
