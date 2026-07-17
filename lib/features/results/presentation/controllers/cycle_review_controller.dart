import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/domain/repositories/tracker_repository.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

final cycleClosureControllerProvider = Provider<CycleClosureController>((ref) {
  return CycleClosureController(ref.watch(trackerRepositoryProvider), (
    input,
    result,
  ) {
    ref.invalidate(projectsProvider);
    ref.invalidate(todayProvider);
    ref.invalidate(projectProvider(input.projectId));
    ref.invalidate(latestSprintProvider(input.projectId));
    ref.invalidate(cycleReviewTargetProvider);
    ref.invalidate(resultsSummaryProvider(input.projectId));
    ref.invalidate(cycleResultsSummaryProvider);

    final replacementId = result.replacementProjectId;
    if (replacementId != null) {
      ref.invalidate(projectProvider(replacementId));
      ref.invalidate(latestSprintProvider(replacementId));
      ref.invalidate(resultsSummaryProvider(replacementId));
    }
  });
});

class CycleClosureController {
  const CycleClosureController(this._repository, this._onCompleted);

  final TrackerRepository _repository;
  final void Function(CloseCycleInput input, CloseCycleResult result)
  _onCompleted;

  Future<CloseCycleResult> submit(CloseCycleInput input) async {
    final result = await _repository.closeCycle(input);
    _onCompleted(input, result);
    return result;
  }
}
