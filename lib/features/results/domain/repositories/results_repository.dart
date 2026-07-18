import 'package:satu_dulu/features/results/domain/entities/result_models.dart';

abstract interface class ResultsRepository {
  /// Watches project metrics within optional inclusive calendar-date bounds.
  ///
  /// Omitting both bounds preserves the all-time summary behavior.
  Stream<ResultsSummary> watchSummary(
    String projectId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<MetricEntry?> getMetric(String projectId, DateTime localDate);

  Future<void> saveMetric(MetricInput input);

  Stream<List<WeeklyReview>> watchWeeklyReviews(String projectId);

  Future<void> saveWeeklyReview(WeeklyReviewInput input);

  Future<void> saveAndApplyWeeklyReview(WeeklyReviewInput input);
}
