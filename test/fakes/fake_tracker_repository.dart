import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/domain/repositories/tracker_repository.dart';

class FakeTrackerRepository implements TrackerRepository {
  FakeTrackerRepository({this.projects = const [], this.today});

  final List<Project> projects;
  TodayOverview? today;

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
  }) async {}
}
