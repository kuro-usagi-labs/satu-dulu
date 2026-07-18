import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/data/repositories/cycle_persistence.dart';
import 'package:satu_dulu/features/projects/data/repositories/cycle_queries.dart';
import 'package:satu_dulu/features/projects/data/repositories/ship_persistence.dart';
import 'package:satu_dulu/features/projects/data/repositories/tracker_repository_support.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/domain/repositories/tracker_repository.dart';
import 'package:uuid/uuid.dart';

class DriftTrackerRepository implements TrackerRepository {
  DriftTrackerRepository(this._database, [this._uuid = const Uuid()]);

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Stream<List<Project>> watchProjects() {
    final query = _database.select(_database.projects)
      ..where((table) => table.status.isNotValue(ProjectStatus.archived.name))
      ..orderBy([
        (table) => OrderingTerm.asc(table.status),
        (table) => OrderingTerm.desc(table.updatedAt),
      ]);
    return query.watch().map(
      (rows) =>
          List.unmodifiable(rows.map(TrackerRepositorySupport.projectFromRow)),
    );
  }

  @override
  Future<Project?> getFocusProject() =>
      _getProjectWithStatus(ProjectStatus.focus);

  @override
  Future<Project?> getMaintenanceProject() =>
      _getProjectWithStatus(ProjectStatus.maintenance);

  @override
  Future<Project?> getProject(String projectId) async {
    final row =
        await (_database.select(_database.projects)
              ..where((table) => table.id.equals(projectId))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : TrackerRepositorySupport.projectFromRow(row);
  }

  @override
  Future<Sprint?> getLatestSprint(String projectId) =>
      CycleQueries(_database).getLatestSprint(projectId);

  @override
  Future<CycleReviewTarget?> getCycleReviewTarget(
    String projectId,
    DateTime localDate,
  ) => CycleQueries(_database).getReviewTarget(projectId, localDate);

  Future<Project?> _getProjectWithStatus(ProjectStatus status) async {
    final row =
        await (_database.select(_database.projects)
              ..where((table) => table.status.equals(status.name))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : TrackerRepositorySupport.projectFromRow(row);
  }

  @override
  Future<String> createProject(CreateProjectInput input) async {
    TrackerRepositorySupport.validateCreateInput(input);
    final now = DateTime.now().toUtc();
    final startDate = TrackerRepositorySupport.utcDay(input.startDate);
    final projectId = _uuid.v4();
    final sprintId = _uuid.v4();
    final dailyPlanId = _uuid.v4();

    try {
      await _database.transaction(() async {
        if (input.status == ProjectStatus.focus ||
            input.status == ProjectStatus.maintenance) {
          final displaced = await (_database.select(
            _database.projects,
          )..where((table) => table.status.equals(input.status.name))).get();
          await _parkProjects(displaced, now);
          if (input.status == ProjectStatus.focus) {
            await _cancelActiveSprints(
              displaced.map((project) => project.id),
              now,
            );
          }
        }

        await _database
            .into(_database.projects)
            .insert(
              ProjectsCompanion.insert(
                id: projectId,
                name: input.name.trim(),
                shortGoal: input.shortGoal.trim(),
                whyChosen: Value(
                  TrackerRepositorySupport.nullableTrim(input.whyChosen),
                ),
                successDefinition: Value(
                  TrackerRepositorySupport.nullableTrim(
                    input.successDefinition,
                  ),
                ),
                targetRevenueMinor: Value(input.targetRevenueMinor),
                status: input.status.name,
                startDate: Value(startDate),
                reviewDate: Value(
                  startDate.add(Duration(days: input.sprintDays - 1)),
                ),
                createdAt: now,
                updatedAt: now,
              ),
            );

        await _database
            .into(_database.sprints)
            .insert(
              SprintsCompanion.insert(
                id: sprintId,
                projectId: projectId,
                name: 'Eksperimen ${input.sprintDays} hari',
                startDate: startDate,
                endDate: startDate.add(Duration(days: input.sprintDays - 1)),
                targetOutputs: Value(input.sprintDays),
                successCriteria: Value(
                  TrackerRepositorySupport.nullableTrim(
                    input.successDefinition,
                  ),
                ),
                status: input.status == ProjectStatus.focus
                    ? SprintStatus.active.name
                    : SprintStatus.cancelled.name,
                createdAt: now,
                updatedAt: now,
              ),
            );

        await _database
            .into(_database.dailyPlans)
            .insert(
              DailyPlansCompanion.insert(
                id: dailyPlanId,
                sprintId: sprintId,
                planDate: startDate,
                requiredOutcome: input.requiredOutcome.trim(),
                lowEnergyAction: Value(
                  TrackerRepositorySupport.nullableTrim(input.lowEnergyAction),
                ),
                createdAt: now,
                updatedAt: now,
              ),
            );

        for (final (position, label) in input.actions.indexed) {
          await _database
              .into(_database.dailyActions)
              .insert(
                DailyActionsCompanion.insert(
                  id: _uuid.v4(),
                  dailyPlanId: dailyPlanId,
                  position: position,
                  label: label.trim(),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        }
      });
      return projectId;
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Proyek tidak dapat disimpan.', error);
    }
  }

  @override
  Future<void> updateProject(String projectId, UpdateProjectInput input) async {
    if (input.name.trim().isEmpty || input.shortGoal.trim().isEmpty) {
      throw const ValidationException('Nama dan tujuan proyek wajib diisi.');
    }
    final now = DateTime.now().toUtc();
    final activationDay = TrackerRepositorySupport.utcDay(DateTime.now());

    try {
      await _database.transaction(() async {
        final existing =
            await (_database.select(_database.projects)
                  ..where((table) => table.id.equals(projectId))
                  ..limit(1))
                .getSingleOrNull();
        if (existing == null) {
          throw const DatabaseException('Proyek tidak ditemukan.');
        }

        final becomingFocus =
            input.status == ProjectStatus.focus &&
            existing.status != ProjectStatus.focus.name;
        final leavingFocus =
            existing.status == ProjectStatus.focus.name &&
            input.status != ProjectStatus.focus;

        if (input.status == ProjectStatus.focus ||
            input.status == ProjectStatus.maintenance) {
          final displaced =
              await (_database.select(_database.projects)..where(
                    (table) =>
                        table.status.equals(input.status.name) &
                        table.id.equals(projectId).not(),
                  ))
                  .get();
          await _parkProjects(displaced, now);
          if (input.status == ProjectStatus.focus) {
            await _cancelActiveSprints(
              displaced.map((project) => project.id),
              now,
            );
          }
        }

        if (leavingFocus) {
          await _cancelActiveSprints([projectId], now);
        }

        await (_database.update(
          _database.projects,
        )..where((table) => table.id.equals(projectId))).write(
          ProjectsCompanion(
            name: Value(input.name.trim()),
            shortGoal: Value(input.shortGoal.trim()),
            whyChosen: Value(
              TrackerRepositorySupport.nullableTrim(input.whyChosen),
            ),
            successDefinition: Value(
              TrackerRepositorySupport.nullableTrim(input.successDefinition),
            ),
            targetRevenueMinor: Value(input.targetRevenueMinor),
            status: Value(input.status.name),
            startDate: becomingFocus
                ? Value(activationDay)
                : const Value.absent(),
            reviewDate: becomingFocus
                ? Value(activationDay.add(const Duration(days: 29)))
                : const Value.absent(),
            archivedAt: const Value(null),
            updatedAt: Value(now),
          ),
        );

        if (becomingFocus) {
          await _startFreshSprint(
            projectId: projectId,
            startDate: activationDay,
            now: now,
            successCriteria: input.successDefinition,
          );
        }
      });
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Perubahan proyek tidak dapat disimpan.', error);
    }
  }

  @override
  Future<String> createDailyPlan(CreateDailyPlanInput input) async {
    TrackerRepositorySupport.validateDailyPlan(
      input.requiredOutcome,
      input.actions,
    );
    final day = TrackerRepositorySupport.utcDay(input.planDate);
    final now = DateTime.now().toUtc();
    final planId = _uuid.v4();
    try {
      await _database.transaction(() async {
        final focus =
            await (_database.select(_database.projects)
                  ..where(
                    (table) => table.status.equals(ProjectStatus.focus.name),
                  )
                  ..limit(1))
                .getSingleOrNull();
        if (focus == null) {
          throw const ValidationException('Pilih satu fokus terlebih dahulu.');
        }
        final sprint =
            await (_database.select(_database.sprints)
                  ..where(
                    (table) =>
                        table.projectId.equals(focus.id) &
                        table.status.equals(SprintStatus.active.name) &
                        table.startDate.isSmallerOrEqualValue(day) &
                        table.endDate.isBiggerOrEqualValue(day),
                  )
                  ..limit(1))
                .getSingleOrNull();
        if (sprint == null) {
          throw const ValidationException(
            'Tanggal ini berada di luar sprint aktif.',
          );
        }
        final existing =
            await (_database.select(_database.dailyPlans)
                  ..where(
                    (table) =>
                        table.sprintId.equals(sprint.id) &
                        table.planDate.equals(day),
                  )
                  ..limit(1))
                .getSingleOrNull();
        if (existing != null) {
          throw const ValidationException(
            'Rencana untuk tanggal ini sudah tersedia.',
          );
        }
        await _database
            .into(_database.dailyPlans)
            .insert(
              DailyPlansCompanion.insert(
                id: planId,
                sprintId: sprint.id,
                planDate: day,
                requiredOutcome: input.requiredOutcome.trim(),
                lowEnergyAction: Value(
                  TrackerRepositorySupport.nullableTrim(input.lowEnergyAction),
                ),
                createdAt: now,
                updatedAt: now,
              ),
            );
        for (final (position, label) in input.actions.indexed) {
          await _database
              .into(_database.dailyActions)
              .insert(
                DailyActionsCompanion.insert(
                  id: _uuid.v4(),
                  dailyPlanId: planId,
                  position: position,
                  label: label.trim(),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        }
      });
      return planId;
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Rencana hari ini tidak dapat disimpan.', error);
    }
  }

  @override
  Future<TodayOverview?> loadToday(DateTime localDate) async {
    final day = TrackerRepositorySupport.utcDay(localDate);
    final projectRow =
        await (_database.select(_database.projects)
              ..where((table) => table.status.equals(ProjectStatus.focus.name))
              ..limit(1))
            .getSingleOrNull();
    if (projectRow == null) return null;

    final sprintRow =
        await (_database.select(_database.sprints)
              ..where(
                (table) =>
                    table.projectId.equals(projectRow.id) &
                    table.status.equals(SprintStatus.active.name) &
                    table.startDate.isSmallerOrEqualValue(day) &
                    table.endDate.isBiggerOrEqualValue(day),
              )
              ..limit(1))
            .getSingleOrNull();
    if (sprintRow == null) return null;

    final planRow =
        await (_database.select(_database.dailyPlans)
              ..where(
                (table) =>
                    table.sprintId.equals(sprintRow.id) &
                    table.planDate.equals(day),
              )
              ..limit(1))
            .getSingleOrNull();
    if (planRow == null) return null;

    final actionRows =
        await (_database.select(_database.dailyActions)
              ..where((table) => table.dailyPlanId.equals(planRow.id))
              ..orderBy([(table) => OrderingTerm.asc(table.position)]))
            .get();
    final shipRow =
        await (_database.select(_database.shipRecords)
              ..where((table) => table.dailyPlanId.equals(planRow.id))
              ..limit(1))
            .getSingleOrNull();

    return TodayOverview(
      project: TrackerRepositorySupport.projectFromRow(projectRow),
      sprint: TrackerRepositorySupport.sprintFromRow(sprintRow),
      dailyPlanId: planRow.id,
      planDate: planRow.planDate.toUtc(),
      requiredOutcome: planRow.requiredOutcome,
      lowEnergyAction: planRow.lowEnergyAction,
      linkedGuideDocumentId: planRow.linkedGuideDocumentId,
      linkedGuidePage: planRow.linkedGuidePage,
      actions: List.unmodifiable(
        actionRows.map(TrackerRepositorySupport.actionFromRow),
      ),
      shipRecord: shipRow == null
          ? null
          : TrackerRepositorySupport.shipFromRow(shipRow),
    );
  }

  @override
  Future<void> setActionCompleted(
    String actionId, {
    required bool completed,
  }) async {
    final now = DateTime.now().toUtc();
    final affected =
        await (_database.update(
          _database.dailyActions,
        )..where((table) => table.id.equals(actionId))).write(
          DailyActionsCompanion(
            isCompleted: Value(completed),
            completedAt: Value(completed ? now : null),
            updatedAt: Value(now),
          ),
        );
    if (affected != 1) {
      throw const DatabaseException('Tindakan tidak ditemukan.');
    }
  }

  @override
  Future<void> shipToday({
    required String dailyPlanId,
    required String outputTitle,
    required bool isPartial,
    String outputType = 'other',
    String? externalUrl,
    String? evidenceNote,
  }) => ShipPersistence(_database, _uuid).save(
    dailyPlanId: dailyPlanId,
    outputTitle: outputTitle,
    isPartial: isPartial,
    outputType: outputType,
    externalUrl: externalUrl,
    evidenceNote: evidenceNote,
  );

  @override
  Future<CloseCycleResult> closeCycle(CloseCycleInput input) =>
      CyclePersistence(_database, _uuid).close(input);

  @override
  Future<void> archiveProject(String projectId) async {
    final now = DateTime.now().toUtc();
    final affected =
        await (_database.update(
          _database.projects,
        )..where((table) => table.id.equals(projectId))).write(
          ProjectsCompanion(
            status: Value(ProjectStatus.archived.name),
            archivedAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    if (affected != 1) {
      throw const DatabaseException('Proyek tidak ditemukan.');
    }
    await _cancelActiveSprints([projectId], now);
  }

  Future<void> _parkProjects(
    Iterable<ProjectRow> projects,
    DateTime now,
  ) async {
    for (final project in projects) {
      await (_database.update(
        _database.projects,
      )..where((table) => table.id.equals(project.id))).write(
        ProjectsCompanion(
          status: Value(ProjectStatus.parkingLot.name),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<void> _cancelActiveSprints(
    Iterable<String> projectIds,
    DateTime now,
  ) async {
    for (final projectId in projectIds) {
      await (_database.update(_database.sprints)..where(
            (table) =>
                table.projectId.equals(projectId) &
                table.status.equals(SprintStatus.active.name),
          ))
          .write(
            SprintsCompanion(
              status: Value(SprintStatus.cancelled.name),
              updatedAt: Value(now),
            ),
          );
    }
  }

  Future<void> _startFreshSprint({
    required String projectId,
    required DateTime startDate,
    required DateTime now,
    required String? successCriteria,
  }) async {
    final latestSprint =
        await (_database.select(_database.sprints)
              ..where((table) => table.projectId.equals(projectId))
              ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
              ..limit(1))
            .getSingleOrNull();

    DailyPlanRow? templatePlan;
    List<DailyActionRow> templateActions = const [];
    if (latestSprint != null) {
      templatePlan =
          await (_database.select(_database.dailyPlans)
                ..where((table) => table.sprintId.equals(latestSprint.id))
                ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
                ..limit(1))
              .getSingleOrNull();
      if (templatePlan != null) {
        templateActions =
            await (_database.select(_database.dailyActions)
                  ..where((table) => table.dailyPlanId.equals(templatePlan!.id))
                  ..orderBy([(table) => OrderingTerm.asc(table.position)]))
                .get();
      }
    }

    await _cancelActiveSprints([projectId], now);

    final sprintId = _uuid.v4();
    await _database
        .into(_database.sprints)
        .insert(
          SprintsCompanion.insert(
            id: sprintId,
            projectId: projectId,
            name: 'Eksperimen 30 hari',
            startDate: startDate,
            endDate: startDate.add(const Duration(days: 29)),
            targetOutputs: const Value(30),
            successCriteria: Value(
              TrackerRepositorySupport.nullableTrim(successCriteria),
            ),
            status: SprintStatus.active.name,
            createdAt: now,
            updatedAt: now,
          ),
        );

    if (templatePlan == null) return;

    final planId = _uuid.v4();
    await _database
        .into(_database.dailyPlans)
        .insert(
          DailyPlansCompanion.insert(
            id: planId,
            sprintId: sprintId,
            planDate: startDate,
            requiredOutcome: templatePlan.requiredOutcome,
            lowEnergyAction: Value(templatePlan.lowEnergyAction),
            linkedGuideDocumentId: Value(templatePlan.linkedGuideDocumentId),
            linkedGuidePage: Value(templatePlan.linkedGuidePage),
            note: Value(templatePlan.note),
            createdAt: now,
            updatedAt: now,
          ),
        );

    for (final action in templateActions) {
      await _database
          .into(_database.dailyActions)
          .insert(
            DailyActionsCompanion.insert(
              id: _uuid.v4(),
              dailyPlanId: planId,
              position: action.position,
              label: action.label,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
  }
}
