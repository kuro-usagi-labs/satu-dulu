import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/projects/data/repositories/tracker_repository_support.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

class CycleQueries {
  const CycleQueries(this._database);

  final AppDatabase _database;

  Future<Sprint?> getLatestSprint(String projectId) async {
    final row = await latestSprintRow(_database, projectId);
    return row == null ? null : TrackerRepositorySupport.sprintFromRow(row);
  }

  Future<CycleReviewTarget?> getReviewTarget(
    String projectId,
    DateTime localDate,
  ) async {
    final projectRow =
        await (_database.select(_database.projects)
              ..where((table) => table.id.equals(projectId))
              ..limit(1))
            .getSingleOrNull();
    if (projectRow == null) return null;

    final project = TrackerRepositorySupport.projectFromRow(projectRow);
    final sprintRow = await latestSprintRow(_database, projectId);
    if (sprintRow == null) {
      return CycleReviewTarget(
        project: project,
        availability: CycleReviewAvailability.unavailable,
      );
    }

    final sprint = TrackerRepositorySupport.sprintFromRow(sprintRow);
    final closure =
        await (_database.select(_database.sprintClosures)
              ..where((table) => table.sprintId.equals(sprintRow.id))
              ..limit(1))
            .getSingleOrNull();
    if (closure != null || sprint.status == SprintStatus.completed) {
      return CycleReviewTarget(
        project: project,
        sprint: sprint,
        availability: CycleReviewAvailability.closed,
      );
    }
    if (project.status != ProjectStatus.focus ||
        sprint.status != SprintStatus.active) {
      return CycleReviewTarget(
        project: project,
        sprint: sprint,
        availability: CycleReviewAvailability.unavailable,
      );
    }

    final day = TrackerRepositorySupport.utcDay(localDate);
    final endDay = TrackerRepositorySupport.utcDay(sprint.endDate);
    return CycleReviewTarget(
      project: project,
      sprint: sprint,
      availability: day.isAfter(endDay)
          ? CycleReviewAvailability.due
          : CycleReviewAvailability.notDue,
    );
  }
}

Future<SprintRow?> latestSprintRow(
  AppDatabase database,
  String projectId,
) async {
  final active =
      await (database.select(database.sprints)
            ..where(
              (table) =>
                  table.projectId.equals(projectId) &
                  table.status.equals(SprintStatus.active.name),
            )
            ..orderBy([(table) => OrderingTerm.desc(table.startDate)])
            ..limit(1))
          .getSingleOrNull();
  if (active != null) return active;
  return (database.select(database.sprints)
        ..where((table) => table.projectId.equals(projectId))
        ..orderBy([(table) => OrderingTerm.desc(table.startDate)])
        ..limit(1))
      .getSingleOrNull();
}
