import 'package:satu_dulu/features/results/domain/entities/result_models.dart';

abstract interface class ResultsRepository {
  Stream<ResultsSummary> watchSummary(String projectId);

  Future<MetricEntry?> getMetric(String projectId, DateTime localDate);

  Future<void> saveMetric(MetricInput input);

  Stream<List<WeeklyReview>> watchWeeklyReviews(String projectId);

  Future<void> saveWeeklyReview(WeeklyReviewInput input);

  Future<void> saveAndApplyWeeklyReview(WeeklyReviewInput input);
}
