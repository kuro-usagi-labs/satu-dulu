import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/domain/repositories/tracker_repository.dart';

class FakeTrackerRepository implements TrackerRepository {
  FakeTrackerRepository({
    this.projects = const [],
    this.today,
    this.latestSprint,
    this.cycleReviewTarget,
    this.closeCycleError,
    this.closeCycleDelay,
  });

  final List<Project> projects;
  TodayOverview? today;
  Sprint? latestSprint;
  CycleReviewTarget? cycleReviewTarget;
  Object? closeCycleError;
  Duration? closeCycleDelay;
  FakeShipCall? lastShipCall;
  CloseCycleInput? lastCloseCycleInput;
  int closeCycleCallCount = 0;

  @override
  Stream<List<Project>> watchProjects() => Stream.value(projects);

  @override
  Future<Project?> getFocusProject() async => projects
      .where((project) => project.status == ProjectStatus.focus)
      .firstOrNull;

  @override
  Future<Project?> getMaintenanceProject() async => projects
      .where((project) => project.status == ProjectStatus.maintenance)
      .firstOrNull;

  @override
  Future<Project?> getProject(String projectId) async =>
      projects.where((project) => project.id == projectId).firstOrNull;

  @override
  Future<Sprint?> getLatestSprint(String projectId) async => latestSprint;

  @override
  Future<CycleReviewTarget?> getCycleReviewTarget(
    String projectId,
    DateTime localDate,
  ) async => cycleReviewTarget;

  @override
  Future<TodayOverview?> loadToday(DateTime localDate) async => today;

  @override
  Future<String> createProject(CreateProjectInput input) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProject(String projectId, UpdateProjectInput input) {
    throw UnimplementedError();
  }

  @override
  Future<String> createDailyPlan(CreateDailyPlanInput input) {
    throw UnimplementedError();
  }

  @override
  Future<void> archiveProject(String projectId) {
    throw UnimplementedError();
  }

  @override
  Future<CloseCycleResult> closeCycle(CloseCycleInput input) async {
    closeCycleCallCount++;
    lastCloseCycleInput = input;
    final delay = closeCycleDelay;
    if (delay != null) await Future<void>.delayed(delay);
    final error = closeCycleError;
    if (error != null) throw error;
    return CloseCycleResult(
      closureId: 'closure-1',
      closedSprintId: input.sprintId,
      decision: input.decision,
      nextSprintId: input.decision == CycleDecision.park ? null : 'sprint-next',
      focusProjectId: input.decision == CycleDecision.park
          ? input.replacementProjectId
          : input.projectId,
      replacementProjectId: input.replacementProjectId,
    );
  }

  @override
  Future<void> setActionCompleted(
    String actionId, {
    required bool completed,
  }) async {}

  @override
  Future<void> shipToday({
    required String dailyPlanId,
    required String outputTitle,
    required bool isPartial,
    String outputType = 'other',
    String? externalUrl,
    String? evidenceNote,
  }) async {
    lastShipCall = FakeShipCall(
      dailyPlanId: dailyPlanId,
      outputTitle: outputTitle,
      isPartial: isPartial,
      outputType: outputType,
      externalUrl: externalUrl,
      evidenceNote: evidenceNote,
    );
  }
}

class FakeShipCall {
  const FakeShipCall({
    required this.dailyPlanId,
    required this.outputTitle,
    required this.isPartial,
    required this.outputType,
    this.externalUrl,
    this.evidenceNote,
  });

  final String dailyPlanId;
  final String outputTitle;
  final bool isPartial;
  final String outputType;
  final String? externalUrl;
  final String? evidenceNote;
}
