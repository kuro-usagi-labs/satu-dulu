import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/repositories/results_repository.dart';
import 'package:uuid/uuid.dart';

class DriftResultsRepository implements ResultsRepository {
  DriftResultsRepository(this._database, [this._uuid = const Uuid()]);

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Stream<ResultsSummary> watchSummary(
    String projectId, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final normalizedStart = startDate == null ? null : _dateOnlyUtc(startDate);
    final normalizedEnd = endDate == null ? null : _dateOnlyUtc(endDate);
    if (normalizedStart != null &&
        normalizedEnd != null &&
        normalizedEnd.isBefore(normalizedStart)) {
      throw const ValidationException('Rentang hasil tidak valid.');
    }

    final query = _database.select(_database.metricEntries)
      ..where((table) {
        var predicate = table.projectId.equals(projectId);
        if (normalizedStart != null) {
          predicate =
              predicate & table.entryDate.isBiggerOrEqualValue(normalizedStart);
        }
        if (normalizedEnd != null) {
          predicate =
              predicate & table.entryDate.isSmallerOrEqualValue(normalizedEnd);
        }
        return predicate;
      })
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
    if (input.weekEnd.isBefore(input.weekStart)) {
      throw const ValidationException('Rentang minggu tidak valid.');
    }
    final weekStart = _dateOnlyUtc(input.weekStart);
    final existing =
        await (_database.select(_database.weeklyReviews)..where(
              (table) =>
                  table.projectId.equals(input.projectId) &
                  table.weekStart.equals(weekStart),
            ))
            .getSingleOrNull();
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.weeklyReviews)
        .insertOnConflictUpdate(
          WeeklyReviewsCompanion.insert(
            id: existing?.id ?? _uuid.v4(),
            projectId: input.projectId,
            sprintId: Value(input.sprintId),
            weekStart: weekStart,
            weekEnd: _dateOnlyUtc(input.weekEnd),
            shippedSummary: Value(_trim(input.shippedSummary)),
            importantResult: Value(_trim(input.importantResult)),
            workedWell: Value(_trim(input.workedWell)),
            wasteOrBlocker: Value(_trim(input.wasteOrBlocker)),
            decision: input.decision.name,
            nextWeekFocus: Value(_trim(input.nextWeekFocus)),
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
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  DateTime _dateOnlyUtc(DateTime value) =>
      DateTime.utc(value.year, value.month, value.day);

  String? _trim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
