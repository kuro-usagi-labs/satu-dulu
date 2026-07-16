import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/results/data/repositories/drift_results_repository.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';

void main() {
  late AppDatabase database;
  late DriftResultsRepository repository;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftResultsRepository(database);
    final now = DateTime.utc(2026, 7, 16);
    await database
        .into(database.projects)
        .insert(
          ProjectsCompanion.insert(
            id: 'project-1',
            name: 'Focus',
            shortGoal: 'Validasi',
            status: 'focus',
            createdAt: now,
            updatedAt: now,
            startDate: Value(now),
          ),
        );
  });

  tearDown(() => database.close());

  test('rupiah conversion uses integer minor units', () {
    expect(MoneyUnits.rupiahTextToMinor('Rp 12.500'), 1250000);
    expect(MoneyUnits.rupiahTextToMinor(''), isNull);
    expect(MoneyUnits.formatMinor(1250000), contains('12.500'));
  });

  test(
    'daily entries upsert and weekly totals safely handle optionals',
    () async {
      await repository.saveMetric(
        MetricInput(
          projectId: 'project-1',
          entryDate: DateTime(2026, 7, 14),
          outputsCount: 1,
          views: 1000,
          orders: 2,
          revenueMinor: 5000000,
          workMinutes: 120,
        ),
      );
      await repository.saveMetric(
        MetricInput(
          projectId: 'project-1',
          entryDate: DateTime(2026, 7, 15),
          outputsCount: 2,
        ),
      );

      final summary = await repository.watchSummary('project-1').first;
      expect(summary.outputs, 3);
      expect(summary.views, 1000);
      expect(summary.ordersPerThousandViews, 2);
      expect(summary.revenuePerHourMinor, 2500000);
    },
  );

  test('derived divisions return null when denominator is zero', () async {
    await repository.saveMetric(
      MetricInput(
        projectId: 'project-1',
        entryDate: DateTime(2026, 7, 16),
        outputsCount: 0,
        revenueMinor: 10000,
        workMinutes: 0,
      ),
    );

    final summary = await repository.watchSummary('project-1').first;
    expect(summary.ordersPerThousandViews, isNull);
    expect(summary.revenuePerThousandViewsMinor, isNull);
    expect(summary.revenuePerHourMinor, isNull);
  });

  test('weekly review upserts one decision per project and week', () async {
    final input = WeeklyReviewInput(
      projectId: 'project-1',
      weekStart: DateTime(2026, 7, 13),
      weekEnd: DateTime(2026, 7, 19),
      decision: ReviewDecision.continueFocus,
      nextWeekFocus: 'Ulangi penawaran',
    );
    await repository.saveWeeklyReview(input);
    await repository.saveWeeklyReview(
      WeeklyReviewInput(
        projectId: input.projectId,
        weekStart: input.weekStart,
        weekEnd: input.weekEnd,
        decision: ReviewDecision.pivot,
        nextWeekFocus: 'Ganti kanal',
      ),
    );

    final reviews = await repository.watchWeeklyReviews('project-1').first;
    expect(reviews, hasLength(1));
    expect(reviews.single.decision, ReviewDecision.pivot);
  });
}
