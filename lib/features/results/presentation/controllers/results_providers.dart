import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/results/data/repositories/drift_results_repository.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/repositories/results_repository.dart';

final resultsRepositoryProvider = Provider<ResultsRepository>((ref) {
  return DriftResultsRepository(ref.watch(appDatabaseProvider));
});

class SelectedResultsProject extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String projectId) => state = projectId;
}

final selectedResultsProjectProvider =
    NotifierProvider<SelectedResultsProject, String?>(
      SelectedResultsProject.new,
    );

final resultsSummaryProvider = StreamProvider.autoDispose
    .family<ResultsSummary, String>((ref, projectId) {
      return ref.watch(resultsRepositoryProvider).watchSummary(projectId);
    });

final weeklyReviewsProvider = StreamProvider.autoDispose
    .family<List<WeeklyReview>, String>((ref, projectId) {
      return ref.watch(resultsRepositoryProvider).watchWeeklyReviews(projectId);
    });
