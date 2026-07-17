import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/results/data/repositories/drift_results_repository.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/repositories/results_repository.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

final resultsRepositoryProvider = Provider<ResultsRepository>((ref) {
  return DriftResultsRepository(ref.watch(appDatabaseProvider));
});

class SelectedResultsProject extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String projectId) => state = projectId;

  void clear() => state = null;
}

final selectedResultsProjectProvider =
    NotifierProvider<SelectedResultsProject, String?>(
      SelectedResultsProject.new,
    );

final resultsSummaryProvider = StreamProvider.autoDispose
    .family<ResultsSummary, String>((ref, projectId) {
      final repository = ref.watch(resultsRepositoryProvider);
      final tracker = ref.watch(trackerRepositoryProvider);
      return (() async* {
        final sprint = await tracker.getLatestSprint(projectId);
        yield* repository.watchSummary(
          projectId,
          startDate: sprint?.startDate,
          endDate: sprint?.endDate,
        );
      })();
    });

typedef CycleResultsQuery = ({
  String projectId,
  DateTime startDate,
  DateTime endDate,
});

final cycleResultsSummaryProvider = StreamProvider.autoDispose
    .family<ResultsSummary, CycleResultsQuery>((ref, query) {
      return ref
          .watch(resultsRepositoryProvider)
          .watchSummary(
            query.projectId,
            startDate: query.startDate,
            endDate: query.endDate,
          );
    });

final weeklyReviewsProvider = StreamProvider.autoDispose
    .family<List<WeeklyReview>, String>((ref, projectId) {
      return ref.watch(resultsRepositoryProvider).watchWeeklyReviews(projectId);
    });
