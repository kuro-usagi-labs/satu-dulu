import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/data/repositories/cycle_queries.dart';
import 'package:satu_dulu/features/projects/data/repositories/tracker_repository_support.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:uuid/uuid.dart';

class CyclePersistence {
  CyclePersistence(this._database, this._uuid);

  final AppDatabase _database;
  final Uuid _uuid;

  Future<CloseCycleResult> close(CloseCycleInput input) async {
    TrackerRepositorySupport.validateCloseCycle(input);
    final decisionDay = TrackerRepositorySupport.utcDay(input.decidedAt);
    final now = DateTime.now().toUtc();
    final closureId = _uuid.v4();

    try {
      return await _database.transaction(() async {
        final project =
            await (_database.select(_database.projects)
                  ..where((table) => table.id.equals(input.projectId))
                  ..limit(1))
                .getSingleOrNull();
        if (project == null) {
          throw const DatabaseException('Proyek tidak ditemukan.');
        }
        if (project.status != ProjectStatus.focus.name) {
          throw const ValidationException(
            'Hanya fokus utama yang dapat menutup putaran.',
          );
        }

        final sprint =
            await (_database.select(_database.sprints)
                  ..where((table) => table.id.equals(input.sprintId))
                  ..limit(1))
                .getSingleOrNull();
        if (sprint == null || sprint.projectId != project.id) {
          throw const ValidationException(
            'Putaran ini tidak terhubung ke fokus yang dipilih.',
          );
        }
        if (sprint.status != SprintStatus.active.name) {
          throw const ValidationException('Putaran ini sudah ditutup.');
        }
        final sprintEnd = TrackerRepositorySupport.utcDay(sprint.endDate);
        if (!decisionDay.isAfter(sprintEnd)) {
          throw const ValidationException(
            'Putaran dapat ditutup setelah hari terakhir selesai.',
          );
        }

        final existingClosure =
            await (_database.select(_database.sprintClosures)
                  ..where((table) => table.sprintId.equals(sprint.id))
                  ..limit(1))
                .getSingleOrNull();
        if (existingClosure != null) {
          throw const ValidationException('Putaran ini sudah ditutup.');
        }

        final activeForProject =
            await (_database.select(_database.sprints)..where(
                  (table) =>
                      table.projectId.equals(project.id) &
                      table.status.equals(SprintStatus.active.name),
                ))
                .get();
        if (activeForProject.length != 1 ||
            activeForProject.single.id != sprint.id) {
          throw const DatabaseException(
            'Data putaran aktif tidak konsisten. Tidak ada perubahan yang disimpan.',
          );
        }

        await (_database.update(
          _database.sprints,
        )..where((table) => table.id.equals(sprint.id))).write(
          SprintsCompanion(
            status: Value(SprintStatus.completed.name),
            updatedAt: Value(now),
          ),
        );

        String? nextSprintId;
        String? closureNextSprintId;
        String? focusProjectId;
        final replacementId = TrackerRepositorySupport.nullableTrim(
          input.replacementProjectId,
        );

        if (input.decision == CycleDecision.park) {
          await (_database.update(_database.sprints)..where(
                (table) =>
                    table.projectId.equals(project.id) &
                    table.status.equals(SprintStatus.active.name),
              ))
              .write(
                SprintsCompanion(
                  status: Value(SprintStatus.cancelled.name),
                  updatedAt: Value(now),
                ),
              );
          await (_database.update(
            _database.projects,
          )..where((table) => table.id.equals(project.id))).write(
            ProjectsCompanion(
              status: Value(ProjectStatus.parkingLot.name),
              updatedAt: Value(now),
            ),
          );

          if (replacementId != null) {
            final replacement =
                await (_database.select(_database.projects)
                      ..where((table) => table.id.equals(replacementId))
                      ..limit(1))
                    .getSingleOrNull();
            if (replacement == null ||
                replacement.status == ProjectStatus.archived.name) {
              throw const ValidationException(
                'Fokus pengganti tidak tersedia.',
              );
            }

            final replacementPreviousSprint = await latestSprintRow(
              _database,
              replacement.id,
            );
            await (_database.update(_database.sprints)..where(
                  (table) =>
                      table.projectId.equals(replacement.id) &
                      table.status.equals(SprintStatus.active.name),
                ))
                .write(
                  SprintsCompanion(
                    status: Value(SprintStatus.cancelled.name),
                    updatedAt: Value(now),
                  ),
                );
            await (_database.update(_database.projects)..where(
                  (table) =>
                      table.status.equals(ProjectStatus.focus.name) &
                      table.id.equals(replacement.id).not(),
                ))
                .write(
                  ProjectsCompanion(
                    status: Value(ProjectStatus.parkingLot.name),
                    updatedAt: Value(now),
                  ),
                );

            nextSprintId = await _insertSprint(
              project: replacement,
              previousSprint: replacementPreviousSprint,
              startDate: decisionDay,
              durationDays: input.durationDays,
              hypothesis: replacementPreviousSprint?.hypothesis,
              now: now,
            );
            final reviewDate = decisionDay.add(
              Duration(days: input.durationDays - 1),
            );
            await (_database.update(
              _database.projects,
            )..where((table) => table.id.equals(replacement.id))).write(
              ProjectsCompanion(
                status: Value(ProjectStatus.focus.name),
                reviewDate: Value(reviewDate),
                archivedAt: const Value(null),
                updatedAt: Value(now),
              ),
            );
            focusProjectId = replacement.id;
          }
        } else {
          final hypothesis = input.decision == CycleDecision.pivot
              ? TrackerRepositorySupport.nullableTrim(input.nextApproach)
              : sprint.hypothesis;
          nextSprintId = await _insertSprint(
            project: project,
            previousSprint: sprint,
            startDate: decisionDay,
            durationDays: input.durationDays,
            hypothesis: hypothesis,
            now: now,
          );
          closureNextSprintId = nextSprintId;
          focusProjectId = project.id;
          await (_database.update(
            _database.projects,
          )..where((table) => table.id.equals(project.id))).write(
            ProjectsCompanion(
              reviewDate: Value(
                decisionDay.add(Duration(days: input.durationDays - 1)),
              ),
              updatedAt: Value(now),
            ),
          );
        }

        await _database
            .into(_database.sprintClosures)
            .insert(
              SprintClosuresCompanion.insert(
                id: closureId,
                sprintId: sprint.id,
                decision: input.decision.name,
                evidenceSummary: Value(
                  TrackerRepositorySupport.nullableTrim(input.evidenceSummary),
                ),
                nextApproach: Value(
                  input.decision == CycleDecision.pivot
                      ? TrackerRepositorySupport.nullableTrim(
                          input.nextApproach,
                        )
                      : null,
                ),
                nextSprintId: Value(closureNextSprintId),
                replacementProjectId: Value(replacementId),
                closedAt: now,
                createdAt: now,
                updatedAt: now,
              ),
            );

        await _verifyFinalState(
          decision: input.decision,
          closedProjectId: project.id,
          expectedFocusProjectId: focusProjectId,
          decisionDay: decisionDay,
        );

        return CloseCycleResult(
          closureId: closureId,
          closedSprintId: sprint.id,
          decision: input.decision,
          nextSprintId: nextSprintId,
          focusProjectId: focusProjectId,
          replacementProjectId: replacementId,
        );
      });
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Putaran belum dapat ditutup.', error);
    }
  }

  Future<String> _insertSprint({
    required ProjectRow project,
    required SprintRow? previousSprint,
    required DateTime startDate,
    required int durationDays,
    required String? hypothesis,
    required DateTime now,
  }) async {
    final existingCount = await (_database.select(
      _database.sprints,
    )..where((table) => table.projectId.equals(project.id))).get();
    final sprintId = _uuid.v4();
    await _database
        .into(_database.sprints)
        .insert(
          SprintsCompanion.insert(
            id: sprintId,
            projectId: project.id,
            name: 'Putaran ${existingCount.length + 1} • $durationDays hari',
            hypothesis: Value(
              TrackerRepositorySupport.nullableTrim(hypothesis),
            ),
            startDate: startDate,
            endDate: startDate.add(Duration(days: durationDays - 1)),
            targetOutputs: Value(previousSprint?.targetOutputs ?? durationDays),
            successCriteria: Value(
              TrackerRepositorySupport.nullableTrim(
                previousSprint?.successCriteria ?? project.successDefinition,
              ),
            ),
            status: SprintStatus.active.name,
            createdAt: now,
            updatedAt: now,
          ),
        );
    return sprintId;
  }

  Future<void> _verifyFinalState({
    required CycleDecision decision,
    required String closedProjectId,
    required String? expectedFocusProjectId,
    required DateTime decisionDay,
  }) async {
    final focuses = await (_database.select(
      _database.projects,
    )..where((table) => table.status.equals(ProjectStatus.focus.name))).get();
    final expectedFocusCount = expectedFocusProjectId == null ? 0 : 1;
    if (focuses.length != expectedFocusCount ||
        (expectedFocusProjectId != null &&
            focuses.single.id != expectedFocusProjectId)) {
      throw const DatabaseException(
        'Perubahan fokus tidak konsisten. Tidak ada perubahan yang disimpan.',
      );
    }

    if (decision == CycleDecision.park) {
      final oldActive =
          await (_database.select(_database.sprints)..where(
                (table) =>
                    table.projectId.equals(closedProjectId) &
                    table.status.equals(SprintStatus.active.name),
              ))
              .get();
      if (oldActive.isNotEmpty) {
        throw const DatabaseException(
          'Putaran proyek yang disimpan masih aktif.',
        );
      }
    }

    if (expectedFocusProjectId == null) return;
    final active =
        await (_database.select(_database.sprints)..where(
              (table) =>
                  table.projectId.equals(expectedFocusProjectId) &
                  table.status.equals(SprintStatus.active.name),
            ))
            .get();
    if (active.length != 1 ||
        active.single.startDate.isAfter(decisionDay) ||
        active.single.endDate.isBefore(decisionDay)) {
      throw const DatabaseException(
        'Fokus baru tidak memiliki putaran aktif yang valid.',
      );
    }
  }
}
