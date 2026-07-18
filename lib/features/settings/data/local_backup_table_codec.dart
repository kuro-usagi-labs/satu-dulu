import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

class LocalBackupTableCodec {
  const LocalBackupTableCodec();

  ParsedBackupTables parse(BackupDataSnapshot snapshot) {
    if (snapshot.databaseSchemaVersion != AppDatabase.currentSchemaVersion) {
      throw BackupException(
        'Backup memakai schema ${snapshot.databaseSchemaVersion}, sedangkan aplikasi ini mendukung schema ${AppDatabase.currentSchemaVersion}.',
      );
    }
    try {
      final parsed = ParsedBackupTables(
        projects: _rows(snapshot, 'projects', ProjectRow.fromJson),
        ideas: _rows(snapshot, 'ideas', IdeaRow.fromJson),
        restartCapsules: _rows(
          snapshot,
          'restartCapsules',
          RestartCapsuleRow.fromJson,
        ),
        dailyCheckIns: _rows(
          snapshot,
          'dailyCheckIns',
          DailyCheckInRow.fromJson,
        ),
        sprints: _rows(snapshot, 'sprints', SprintRow.fromJson),
        dailyPlans: _rows(snapshot, 'dailyPlans', DailyPlanRow.fromJson),
        dailyActions: _rows(snapshot, 'dailyActions', DailyActionRow.fromJson),
        shipRecords: _rows(snapshot, 'shipRecords', ShipRecordRow.fromJson),
        guideDocuments: _rows(
          snapshot,
          'guideDocuments',
          GuideDocumentRow.fromJson,
        ),
        pdfBookmarks: _rows(snapshot, 'pdfBookmarks', PdfBookmarkRow.fromJson),
        pdfNotes: _rows(snapshot, 'pdfNotes', PdfNoteRow.fromJson),
        metricEntries: _rows(
          snapshot,
          'metricEntries',
          MetricEntryRow.fromJson,
        ),
        weeklyReviews: _rows(
          snapshot,
          'weeklyReviews',
          WeeklyReviewRow.fromJson,
        ),
        notificationPreferences: _rows(
          snapshot,
          'notificationPreferences',
          NotificationPreferenceRow.fromJson,
        ),
        sprintClosures: _rows(
          snapshot,
          'sprintClosures',
          SprintClosureRow.fromJson,
        ),
      );
      _validate(parsed);
      return parsed;
    } on BackupException {
      rethrow;
    } catch (error) {
      throw BackupException('Isi database backup tidak dapat dibaca.', error);
    }
  }

  List<T> _rows<T>(
    BackupDataSnapshot snapshot,
    String name,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return [
      for (final row in snapshot.tables[name] ?? const <Map<String, dynamic>>[])
        fromJson(row),
    ];
  }

  void _validate(ParsedBackupTables value) {
    _requireUnique(value.projects.map((row) => row.id), 'proyek');
    _requireUnique(value.ideas.map((row) => row.id), 'ide');
    _requireUnique(value.restartCapsules.map((row) => row.id), 'kapsul');
    _requireUnique(value.dailyCheckIns.map((row) => row.id), 'check-in');
    _requireUnique(value.sprints.map((row) => row.id), 'putaran');
    _requireUnique(value.dailyPlans.map((row) => row.id), 'rencana harian');
    _requireUnique(value.dailyActions.map((row) => row.id), 'tindakan');
    _requireUnique(value.shipRecords.map((row) => row.id), 'Ship');
    _requireUnique(value.guideDocuments.map((row) => row.id), 'panduan');
    _requireUnique(value.pdfBookmarks.map((row) => row.id), 'bookmark');
    _requireUnique(value.pdfNotes.map((row) => row.id), 'catatan');
    _requireUnique(value.metricEntries.map((row) => row.id), 'metrik');
    _requireUnique(value.weeklyReviews.map((row) => row.id), 'review');
    _requireUnique(value.sprintClosures.map((row) => row.id), 'penutupan');

    final projectIds = value.projects.map((row) => row.id).toSet();
    final projectStatuses = ProjectStatus.values
        .map((item) => item.name)
        .toSet();
    if (value.projects.any(
          (row) => !projectStatuses.contains(row.status) || row.id.isEmpty,
        ) ||
        value.projects
                .where((row) => row.status == ProjectStatus.focus.name)
                .length >
            1 ||
        value.projects
                .where((row) => row.status == ProjectStatus.maintenance.name)
                .length >
            1) {
      throw const BackupException(
        'Aturan satu fokus atau status proyek pada backup tidak valid.',
      );
    }

    final ideaDispositions = IdeaDisposition.values
        .map((item) => item.name)
        .toSet();
    if (value.ideas.any(
      (row) =>
          !ideaDispositions.contains(row.disposition) ||
          (row.convertedProjectId != null &&
              !projectIds.contains(row.convertedProjectId)),
    )) {
      throw const BackupException('Idea Inbox pada backup tidak valid.');
    }
    if (value.restartCapsules.any(
          (row) => !projectIds.contains(row.projectId),
        ) ||
        value.dailyCheckIns.any(
          (row) =>
              !EnergyLevel.values.any(
                (level) => level.name == row.energyLevel,
              ) ||
              row.availableMinutes < 0 ||
              row.availableMinutes > 1440,
        )) {
      throw const BackupException('Data anti-lupa pada backup tidak valid.');
    }

    final sprintIds = value.sprints.map((row) => row.id).toSet();
    final sprintStatuses = SprintStatus.values.map((item) => item.name).toSet();
    final activeSprints = <String, int>{};
    for (final row in value.sprints) {
      if (!projectIds.contains(row.projectId) ||
          !sprintStatuses.contains(row.status)) {
        throw const BackupException('Relasi putaran pada backup tidak valid.');
      }
      if (row.status == SprintStatus.active.name) {
        activeSprints.update(
          row.projectId,
          (count) => count + 1,
          ifAbsent: () => 1,
        );
      }
    }
    if (activeSprints.values.any((count) => count > 1)) {
      throw const BackupException(
        'Satu proyek memiliki lebih dari satu putaran aktif.',
      );
    }

    final planIds = value.dailyPlans.map((row) => row.id).toSet();
    if (value.dailyPlans.any((row) => !sprintIds.contains(row.sprintId))) {
      throw const BackupException('Relasi rencana harian tidak valid.');
    }
    final actionCounts = <String, int>{};
    for (final row in value.dailyActions) {
      if (!planIds.contains(row.dailyPlanId) ||
          row.position < 0 ||
          row.position > 2) {
        throw const BackupException('Tindakan harian pada backup tidak valid.');
      }
      actionCounts.update(
        row.dailyPlanId,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    if (actionCounts.values.any((count) => count > 3) ||
        value.shipRecords.any((row) => !planIds.contains(row.dailyPlanId))) {
      throw const BackupException(
        'Batas tindakan atau relasi Ship pada backup tidak valid.',
      );
    }

    final guideIds = value.guideDocuments.map((row) => row.id).toSet();
    final paths = <String>{};
    for (final row in value.guideDocuments) {
      if ((row.projectId != null && !projectIds.contains(row.projectId)) ||
          !RegExp(
            r'^pdfs/[a-zA-Z0-9-]+\.pdf$',
          ).hasMatch(row.storedRelativePath) ||
          !paths.add(row.storedRelativePath) ||
          row.fileSizeBytes < 5 ||
          row.pageCount < 1 ||
          row.lastReadPage < 1 ||
          row.lastReadPage > row.pageCount) {
        throw const BackupException(
          'Metadata panduan pada backup tidak valid.',
        );
      }
    }
    if (value.pdfBookmarks.any(
          (row) => !guideIds.contains(row.documentId) || row.pageNumber < 1,
        ) ||
        value.pdfNotes.any(
          (row) => !guideIds.contains(row.documentId) || row.pageNumber < 1,
        )) {
      throw const BackupException('Relasi catatan PDF tidak valid.');
    }

    for (final row in value.metricEntries) {
      final optionalValues = [
        row.views,
        row.clicks,
        row.orders,
        row.revenueMinor,
        row.workMinutes,
      ];
      if (!projectIds.contains(row.projectId) ||
          row.outputsCount < 0 ||
          optionalValues.whereType<int>().any((number) => number < 0)) {
        throw const BackupException('Metrik pada backup tidak valid.');
      }
    }

    final reviewDecisions = ReviewDecision.values
        .map((item) => item.name)
        .toSet();
    if (value.weeklyReviews.any(
      (row) =>
          !projectIds.contains(row.projectId) ||
          (row.sprintId != null && !sprintIds.contains(row.sprintId)) ||
          !reviewDecisions.contains(row.decision),
    )) {
      throw const BackupException('Review mingguan pada backup tidak valid.');
    }

    if (value.notificationPreferences.length > 1 ||
        value.notificationPreferences.any(
          (row) =>
              row.id != 1 ||
              row.morningMinutes < 0 ||
              row.morningMinutes >= 1440 ||
              row.afterWorkMinutes < 0 ||
              row.afterWorkMinutes >= 1440 ||
              row.eveningMinutes < 0 ||
              row.eveningMinutes >= 1440 ||
              row.timeZoneId.trim().isEmpty,
        )) {
      throw const BackupException(
        'Preferensi pengingat pada backup tidak valid.',
      );
    }

    _validateClosures(value, sprintIds, projectIds);
  }

  void _validateClosures(
    ParsedBackupTables value,
    Set<String> sprintIds,
    Set<String> projectIds,
  ) {
    final decisions = CycleDecision.values.map((item) => item.name).toSet();
    final closedSprints = <String>{};
    final nextSprints = <String>{};
    for (final row in value.sprintClosures) {
      final isPark = row.decision == CycleDecision.park.name;
      final isPivot = row.decision == CycleDecision.pivot.name;
      if (!decisions.contains(row.decision) ||
          !sprintIds.contains(row.sprintId) ||
          !closedSprints.add(row.sprintId) ||
          (row.nextSprintId != null &&
              (!sprintIds.contains(row.nextSprintId) ||
                  !nextSprints.add(row.nextSprintId!))) ||
          (row.replacementProjectId != null &&
              !projectIds.contains(row.replacementProjectId)) ||
          (isPark && row.nextSprintId != null) ||
          (!isPark && row.nextSprintId == null) ||
          (isPivot && (row.nextApproach?.trim().isEmpty ?? true)) ||
          (!isPivot && row.nextApproach != null)) {
        throw const BackupException(
          'Keputusan penutupan putaran pada backup tidak valid.',
        );
      }
    }
  }

  void _requireUnique(Iterable<String> values, String label) {
    final seen = <String>{};
    if (values.any((value) => value.isEmpty || !seen.add(value))) {
      throw BackupException('Identifier $label pada backup tidak valid.');
    }
  }
}

class ParsedBackupTables {
  const ParsedBackupTables({
    required this.projects,
    required this.ideas,
    required this.restartCapsules,
    required this.dailyCheckIns,
    required this.sprints,
    required this.dailyPlans,
    required this.dailyActions,
    required this.shipRecords,
    required this.guideDocuments,
    required this.pdfBookmarks,
    required this.pdfNotes,
    required this.metricEntries,
    required this.weeklyReviews,
    required this.notificationPreferences,
    required this.sprintClosures,
  });

  final List<ProjectRow> projects;
  final List<IdeaRow> ideas;
  final List<RestartCapsuleRow> restartCapsules;
  final List<DailyCheckInRow> dailyCheckIns;
  final List<SprintRow> sprints;
  final List<DailyPlanRow> dailyPlans;
  final List<DailyActionRow> dailyActions;
  final List<ShipRecordRow> shipRecords;
  final List<GuideDocumentRow> guideDocuments;
  final List<PdfBookmarkRow> pdfBookmarks;
  final List<PdfNoteRow> pdfNotes;
  final List<MetricEntryRow> metricEntries;
  final List<WeeklyReviewRow> weeklyReviews;
  final List<NotificationPreferenceRow> notificationPreferences;
  final List<SprintClosureRow> sprintClosures;
}
