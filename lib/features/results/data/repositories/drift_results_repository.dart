import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/repositories/results_repository.dart';
import 'package:uuid/uuid.dart';

class DriftResultsRepository implements ResultsRepository {
  DriftResultsRepository(this._database, [this._uuid = const Uuid()]);

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Stream<ResultsSummary> watchSummary(String projectId) {
    final query = _database.select(_database.metricEntries)
      ..where((table) => table.projectId.equals(projectId))
      ..orderBy([(table) => OrderingTerm.desc(table.entryDate)]);
    return query.watch().map((rows) => _summarize(rows.map(_metric).toList()));
  }

  @override
  Future<MetricEntry?> getMetric(String projectId, DateTime localDate) async {
    final date = _dateOnlyUtc(localDate);
    final row =
        await (_database.select(_database.metricEntries)..where(
              (table) =>
                  table.projectId.equals(projectId) &
                  table.entryDate.equals(date),
            ))
            .getSingleOrNull();
    return row == null ? null : _metric(row);
  }

  @override
  Future<void> saveMetric(MetricInput input) async {
    _validateMetric(input);
    final date = _dateOnlyUtc(input.entryDate);
    final existing =
        await (_database.select(_database.metricEntries)..where(
              (table) =>
                  table.projectId.equals(input.projectId) &
                  table.entryDate.equals(date),
            ))
            .getSingleOrNull();
    final now = DateTime.now().toUtc();
    final companion = MetricEntriesCompanion.insert(
      id: existing?.id ?? _uuid.v4(),
      projectId: input.projectId,
      entryDate: date,
      outputsCount: Value(input.outputsCount),
      views: Value(input.views),
      clicks: Value(input.clicks),
      orders: Value(input.orders),
      revenueMinor: Value(input.revenueMinor),
      workMinutes: Value(input.workMinutes),
      note: Value(_trim(input.note)),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    await _database
        .into(_database.metricEntries)
        .insertOnConflictUpdate(companion);
  }

  @override
  Stream<List<WeeklyReview>> watchWeeklyReviews(String projectId) {
    final query = _database.select(_database.weeklyReviews)
      ..where((table) => table.projectId.equals(projectId))
      ..orderBy([(table) => OrderingTerm.desc(table.weekStart)]);
    return query.watch().map((rows) => List.unmodifiable(rows.map(_review)));
  }

  @override
  Future<void> saveWeeklyReview(WeeklyReviewInput input) async {
    _validateReview(input, requireNextAction: false);
    await _saveReview(input, decisionAppliedAt: null);
  }

  @override
  Future<void> saveAndApplyWeeklyReview(WeeklyReviewInput input) async {
    _validateReview(
      input,
      requireNextAction: input.decision == ReviewDecision.park,
    );
    final now = DateTime.now().toUtc();
    final today = _dateOnlyUtc(DateTime.now());

    try {
      await _database.transaction(() async {
        final project =
            await (_database.select(_database.projects)
                  ..where((table) => table.id.equals(input.projectId))
                  ..limit(1))
                .getSingleOrNull();
        if (project == null) {
          throw const DatabaseException('Proyek tidak ditemukan.');
        }

        final weekStart = _dateOnlyUtc(input.weekStart);
        final existing =
            await (_database.select(_database.weeklyReviews)..where(
                  (table) =>
                      table.projectId.equals(input.projectId) &
                      table.weekStart.equals(weekStart),
                ))
                .getSingleOrNull();
        if (existing?.decisionAppliedAt != null) {
          throw const ValidationException(
            'Keputusan review minggu ini sudah diterapkan.',
          );
        }

        final activeSprint =
            await (_database.select(_database.sprints)
                  ..where(
                    (table) =>
                        table.projectId.equals(input.projectId) &
                        table.status.equals(SprintStatus.active.name),
                  )
                  ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
                  ..limit(1))
                .getSingleOrNull();

        await _database.into(_database.weeklyReviews).insertOnConflictUpdate(
              _reviewCompanion(
                input,
                existing: existing,
                sprintId: input.sprintId ?? activeSprint?.id,
                decisionAppliedAt: now,
              ),
            );

        switch (input.decision) {
          case ReviewDecision.continueFocus:
            await _ensureFocus(input.projectId, now);
            await _upsertCapsule(
              input,
              now,
              lastKnownState: input.importantResult,
              parkedReason: null,
            );
            final shouldRenew = activeSprint == null ||
                !activeSprint.endDate.isAfter(
                  today.add(const Duration(days: 7)),
                );
            if (shouldRenew) {
              await _finishSprint(activeSprint, now, completed: true);
              await _createSprintWithPlan(
                projectId: input.projectId,
                startDate: today,
                hypothesis: input.nextWeekFocus,
                outcome: _trim(input.nextWeekFocus) ?? project.shortGoal,
                now: now,
              );
            }
          case ReviewDecision.pivot:
            final nextFocus = _trim(input.nextWeekFocus);
            if (nextFocus == null) {
              throw const ValidationException(
                'Tulis pendekatan baru yang akan diuji.',
              );
            }
            await _ensureFocus(input.projectId, now);
            await _finishSprint(activeSprint, now, completed: true);
            await _upsertCapsule(
              input,
              now,
              lastKnownState:
                  _trim(input.importantResult) ?? 'Pendekatan sebelumnya ditutup.',
              parkedReason: null,
            );
            await _createSprintWithPlan(
              projectId: input.projectId,
              startDate: today,
              hypothesis: nextFocus,
              outcome: nextFocus,
              now: now,
            );
          case ReviewDecision.park:
            final nextAction = _trim(input.nextWeekFocus);
            if (nextAction == null) {
              throw const ValidationException(
                'Simpan satu tindakan pertama untuk saat proyek dilanjutkan.',
              );
            }
            await _finishSprint(activeSprint, now, completed: false);
            await (_database.update(_database.projects)..where(
                  (table) => table.id.equals(input.projectId),
                ))
                .write(
                  ProjectsCompanion(
                    status: Value(ProjectStatus.parkingLot.name),
                    updatedAt: Value(now),
                  ),
                );
            await _upsertCapsule(
              input,
              now,
              lastKnownState:
                  _trim(input.importantResult) ?? project.shortGoal,
              parkedReason: _trim(input.wasteOrBlocker) ??
                  'Diparkir melalui review mingguan.',
            );
        }
      });
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException(
        'Review tersimpan, tetapi keputusan belum dapat diterapkan.',
        error,
      );
    }
  }

  Future<void> _saveReview(
    WeeklyReviewInput input, {
    required DateTime? decisionAppliedAt,
  }) async {
    final weekStart = _dateOnlyUtc(input.weekStart);
    final existing =
        await (_database.select(_database.weeklyReviews)..where(
              (table) =>
                  table.projectId.equals(input.projectId) &
                  table.weekStart.equals(weekStart),
            ))
            .getSingleOrNull();
    await _database.into(_database.weeklyReviews).insertOnConflictUpdate(
          _reviewCompanion(
            input,
            existing: existing,
            sprintId: input.sprintId,
            decisionAppliedAt: decisionAppliedAt,
          ),
        );
  }

  WeeklyReviewsCompanion _reviewCompanion(
    WeeklyReviewInput input, {
    required WeeklyReviewRow? existing,
    required String? sprintId,
    required DateTime? decisionAppliedAt,
  }) {
    final now = DateTime.now().toUtc();
    return WeeklyReviewsCompanion.insert(
      id: existing?.id ?? _uuid.v4(),
      projectId: input.projectId,
      sprintId: Value(sprintId),
      weekStart: _dateOnlyUtc(input.weekStart),
      weekEnd: _dateOnlyUtc(input.weekEnd),
      shippedSummary: Value(_trim(input.shippedSummary)),
      importantResult: Value(_trim(input.importantResult)),
      workedWell: Value(_trim(input.workedWell)),
      wasteOrBlocker: Value(_trim(input.wasteOrBlocker)),
      decision: input.decision.name,
      nextWeekFocus: Value(_trim(input.nextWeekFocus)),
      decisionAppliedAt: Value(decisionAppliedAt),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
  }

  Future<void> _ensureFocus(String projectId, DateTime now) async {
    final displaced =
        await (_database.select(_database.projects)..where(
              (table) =>
                  table.status.equals(ProjectStatus.focus.name) &
                  table.id.equals(projectId).not(),
            ))
            .get();
    for (final project in displaced) {
      await (_database.update(_database.projects)..where(
            (table) => table.id.equals(project.id),
          ))
          .write(
            ProjectsCompanion(
              status: Value(ProjectStatus.parkingLot.name),
              updatedAt: Value(now),
            ),
          );
      await (_database.update(_database.sprints)..where(
            (table) =>
                table.projectId.equals(project.id) &
                table.status.equals(SprintStatus.active.name),
          ))
          .write(
            SprintsCompanion(
              status: Value(SprintStatus.cancelled.name),
              updatedAt: Value(now),
            ),
          );
    }
    await (_database.update(_database.projects)..where(
          (table) => table.id.equals(projectId),
        ))
        .write(
          ProjectsCompanion(
            status: Value(ProjectStatus.focus.name),
            archivedAt: const Value(null),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> _finishSprint(
    SprintRow? sprint,
    DateTime now, {
    required bool completed,
  }) async {
    if (sprint == null) return;
    await (_database.update(_database.sprints)..where(
          (table) => table.id.equals(sprint.id),
        ))
        .write(
          SprintsCompanion(
            status: Value(
              completed ? SprintStatus.completed.name : SprintStatus.cancelled.name,
            ),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> _createSprintWithPlan({
    required String projectId,
    required DateTime startDate,
    required String? hypothesis,
    required String outcome,
    required DateTime now,
  }) async {
    final sprintId = _uuid.v4();
    final planId = _uuid.v4();
    final nextAction = _trim(hypothesis) ?? 'Mulai langkah pertama';
    await _database.into(_database.sprints).insert(
          SprintsCompanion.insert(
            id: sprintId,
            projectId: projectId,
            name: 'Eksperimen 30 hari',
            hypothesis: Value(_trim(hypothesis)),
            startDate: startDate,
            endDate: startDate.add(const Duration(days: 29)),
            targetOutputs: const Value(30),
            status: SprintStatus.active.name,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await (_database.update(_database.projects)..where(
          (table) => table.id.equals(projectId),
        ))
        .write(
          ProjectsCompanion(
            startDate: Value(startDate),
            reviewDate: Value(startDate.add(const Duration(days: 29))),
            updatedAt: Value(now),
          ),
        );
    await _database.into(_database.dailyPlans).insert(
          DailyPlansCompanion.insert(
            id: planId,
            sprintId: sprintId,
            planDate: startDate,
            requiredOutcome: outcome,
            lowEnergyAction: Value(nextAction),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await _database.into(_database.dailyActions).insert(
          DailyActionsCompanion.insert(
            id: _uuid.v4(),
            dailyPlanId: planId,
            position: 0,
            label: nextAction,
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<void> _upsertCapsule(
    WeeklyReviewInput input,
    DateTime now, {
    required String? lastKnownState,
    required String? parkedReason,
  }) async {
    final existing =
        await (_database.select(_database.restartCapsules)
              ..where((table) => table.projectId.equals(input.projectId))
              ..limit(1))
            .getSingleOrNull();
    await _database.into(_database.restartCapsules).insertOnConflictUpdate(
          RestartCapsulesCompanion.insert(
            id: existing?.id ?? _uuid.v4(),
            projectId: input.projectId,
            lastKnownState: Value(_trim(lastKnownState)),
            lastOutput: Value(_trim(input.shippedSummary)),
            whatWorked: Value(_trim(input.workedWell)),
            blocker: Value(_trim(input.wasteOrBlocker)),
            nextAction: Value(_trim(input.nextWeekFocus)),
            parkedReason: Value(_trim(parkedReason)),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  ResultsSummary _summarize(List<MetricEntry> entries) {
    final outputs = entries.fold(0, (sum, row) => sum + row.outputsCount);
    final views = entries.fold(0, (sum, row) => sum + (row.views ?? 0));
    final clicks = entries.fold(0, (sum, row) => sum + (row.clicks ?? 0));
    final orders = entries.fold(0, (sum, row) => sum + (row.orders ?? 0));
    final revenue = entries.fold(
      0,
      (sum, row) => sum + (row.revenueMinor ?? 0),
    );
    final minutes = entries.fold(0, (sum, row) => sum + (row.workMinutes ?? 0));
    final spanDays = entries.length < 2
        ? 1
        : entries.first.entryDate
                  .difference(entries.last.entryDate)
                  .inDays
                  .abs() +
              1;
    final weeks = (spanDays / 7).clamp(1.0, double.infinity);
    return ResultsSummary(
      entries: List.unmodifiable(entries),
      outputs: outputs,
      views: views,
      clicks: clicks,
      orders: orders,
      revenueMinor: revenue,
      workMinutes: minutes,
      ordersPerThousandViews: views == 0 ? null : orders * 1000 / views,
      revenuePerThousandViewsMinor: views == 0 ? null : revenue * 1000 / views,
      revenuePerHourMinor: minutes == 0 ? null : revenue * 60 / minutes,
      outputsPerWeek: outputs / weeks,
      shipConsistency: entries.isEmpty
          ? 0
          : entries.where((entry) => entry.outputsCount > 0).length /
                entries.length,
    );
  }

  void _validateMetric(MetricInput input) {
    final values = [
      input.outputsCount,
      input.views,
      input.clicks,
      input.orders,
      input.revenueMinor,
      input.workMinutes,
    ];
    if (values.whereType<int>().any((value) => value < 0)) {
      throw const ValidationException('Metrik tidak boleh bernilai negatif.');
    }
  }

  void _validateReview(
    WeeklyReviewInput input, {
    required bool requireNextAction,
  }) {
    if (input.weekEnd.isBefore(input.weekStart)) {
      throw const ValidationException('Rentang minggu tidak valid.');
    }
    if (requireNextAction && _trim(input.nextWeekFocus) == null) {
      throw const ValidationException(
        'Simpan satu tindakan pertama sebelum memarkir proyek.',
      );
    }
  }

  MetricEntry _metric(MetricEntryRow row) => MetricEntry(
    id: row.id,
    projectId: row.projectId,
    entryDate: row.entryDate.toUtc(),
    outputsCount: row.outputsCount,
    views: row.views,
    clicks: row.clicks,
    orders: row.orders,
    revenueMinor: row.revenueMinor,
    workMinutes: row.workMinutes,
    note: row.note,
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  WeeklyReview _review(WeeklyReviewRow row) => WeeklyReview(
    id: row.id,
    projectId: row.projectId,
    sprintId: row.sprintId,
    weekStart: row.weekStart.toUtc(),
    weekEnd: row.weekEnd.toUtc(),
    shippedSummary: row.shippedSummary,
    importantResult: row.importantResult,
    workedWell: row.workedWell,
    wasteOrBlocker: row.wasteOrBlocker,
    decision: ReviewDecision.values.byName(row.decision),
    nextWeekFocus: row.nextWeekFocus,
    decisionAppliedAt: row.decisionAppliedAt?.toUtc(),
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  DateTime _dateOnlyUtc(DateTime value) {
    final local = value.toLocal();
    return DateTime.utc(local.year, local.month, local.day);
  }

  String? _trim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
