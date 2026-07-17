import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

abstract interface class TrackerRepository {
  Stream<List<Project>> watchProjects();

  Future<Project?> getFocusProject();

  Future<Project?> getMaintenanceProject();

  Future<Project?> getProject(String projectId);

  Future<Sprint?> getLatestSprint(String projectId);

  Future<CycleReviewTarget?> getCycleReviewTarget(
    String projectId,
    DateTime localDate,
  );

  Future<TodayOverview?> loadToday(DateTime localDate);

  Future<String> createProject(CreateProjectInput input);

  Future<void> updateProject(String projectId, UpdateProjectInput input);

  Future<String> createDailyPlan(CreateDailyPlanInput input);

  Future<void> setActionCompleted(String actionId, {required bool completed});

  Future<void> shipToday({
    required String dailyPlanId,
    required String outputTitle,
    required bool isPartial,
    String outputType = 'other',
    String? externalUrl,
    String? evidenceNote,
  });

  Future<CloseCycleResult> closeCycle(CloseCycleInput input);

  Future<void> archiveProject(String projectId);
}
