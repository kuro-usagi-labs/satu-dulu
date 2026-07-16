import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
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
      (rows) => List.unmodifiable(rows.map(_projectFromRow)),
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
    return row == null ? null : _projectFromRow(row);
  }

  Future<Project?> _getProjectWithStatus(ProjectStatus status) async {
    final row =
        await (_database.select(_database.projects)
              ..where((table) => table.status.equals(status.name))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _projectFromRow(row);
  }

  @override
  Future<String> createProject(CreateProjectInput input) async {
    _validateCreateInput(input);
    final now = DateTime.now().toUtc();
    final startDate = _utcDay(input.startDate);
    final projectId = _uuid.v4();
    final sprintId = _uuid.v4();
    final dailyPlanId = _uuid.v4();

    try {
      await _database.transaction(() async {
        if (input.status == ProjectStatus.focus ||
            input.status == ProjectStatus.maintenance) {
          await (_database.update(
            _database.projects,
          )..where((table) => table.status.equals(input.status.name))).write(
            ProjectsCompanion(
              status: Value(ProjectStatus.parkingLot.name),
              updatedAt: Value(now),
            ),
          );
        }

        await _database
            .into(_database.projects)
            .insert(
              ProjectsCompanion.insert(
                id: projectId,
                name: input.name.trim(),
                shortGoal: input.shortGoal.trim(),
                whyChosen: Value(_nullableTrim(input.whyChosen)),
                successDefinition: Value(
                  _nullableTrim(input.successDefinition),
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
                successCriteria: Value(_nullableTrim(input.successDefinition)),
                status: SprintStatus.active.name,
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
                lowEnergyAction: Value(_nullableTrim(input.lowEnergyAction)),
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
        if (input.status == ProjectStatus.focus ||
            input.status == ProjectStatus.maintenance) {
          await (_database.update(_database.projects)..where(
                (table) =>
                    table.status.equals(input.status.name) &
                    table.id.equals(projectId).not(),
              ))
              .write(
                ProjectsCompanion(
                  status: Value(ProjectStatus.parkingLot.name),
                  updatedAt: Value(now),
                ),
              );
        }
        await (_database.update(
          _database.projects,
        )..where((table) => table.id.equals(projectId))).write(
          ProjectsCompanion(
            name: Value(input.name.trim()),
            shortGoal: Value(input.shortGoal.trim()),
            whyChosen: Value(_nullableTrim(input.whyChosen)),
            successDefinition: Value(_nullableTrim(input.successDefinition)),
            targetRevenueMinor: Value(input.targetRevenueMinor),
            status: Value(input.status.name),
            archivedAt: const Value(null),
            updatedAt: Value(now),
          ),
        );
      });
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Perubahan proyek tidak dapat disimpan.', error);
    }
  }

  @override
  Future<String> createDailyPlan(CreateDailyPlanInput input) async {
    _validateDailyPlan(input.requiredOutcome, input.actions);
    final day = _utcDay(input.planDate);
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
                lowEnergyAction: Value(_nullableTrim(input.lowEnergyAction)),
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
    final day = _utcDay(localDate);
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
      project: _projectFromRow(projectRow),
      sprint: _sprintFromRow(sprintRow),
      dailyPlanId: planRow.id,
      planDate: planRow.planDate.toUtc(),
      requiredOutcome: planRow.requiredOutcome,
      lowEnergyAction: planRow.lowEnergyAction,
      linkedGuideDocumentId: planRow.linkedGuideDocumentId,
      linkedGuidePage: planRow.linkedGuidePage,
      actions: List.unmodifiable(actionRows.map(_actionFromRow)),
      shipRecord: shipRow == null ? null : _shipFromRow(shipRow),
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
  }) async {
    if (outputTitle.trim().isEmpty) {
      throw const ValidationException('Judul hasil wajib diisi.');
    }
    final existing =
        await (_database.select(_database.shipRecords)
              ..where((table) => table.dailyPlanId.equals(dailyPlanId)))
            .getSingleOrNull();
    if (existing != null) {
      throw const ValidationException('Hari ini sudah pernah di-ship.');
    }

    try {
      await _database
          .into(_database.shipRecords)
          .insert(
            ShipRecordsCompanion.insert(
              id: _uuid.v4(),
              dailyPlanId: dailyPlanId,
              outputType: outputType,
              outputTitle: outputTitle.trim(),
              externalUrl: Value(_nullableTrim(externalUrl)),
              evidenceNote: Value(_nullableTrim(evidenceNote)),
              isPartial: Value(isPartial),
              shippedAt: DateTime.now().toUtc(),
            ),
          );
    } catch (error) {
      throw DatabaseException('Hasil hari ini tidak dapat disimpan.', error);
    }
  }

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
  }

  void _validateCreateInput(CreateProjectInput input) {
    if (input.name.trim().isEmpty) {
      throw const ValidationException('Nama proyek wajib diisi.');
    }
    if (input.shortGoal.trim().isEmpty) {
      throw const ValidationException('Tujuan proyek wajib diisi.');
    }
    _validateDailyPlan(input.requiredOutcome, input.actions);
    if (input.sprintDays < 1) {
      throw const ValidationException('Durasi sprint harus lebih dari nol.');
    }
  }

  void _validateDailyPlan(String requiredOutcome, List<String> inputActions) {
    if (requiredOutcome.trim().isEmpty) {
      throw const ValidationException('Hasil wajib hari ini harus diisi.');
    }
    final actions = inputActions
        .where((item) => item.trim().isNotEmpty)
        .toList();
    if (actions.length != inputActions.length) {
      throw const ValidationException('Tindakan harian tidak boleh kosong.');
    }
    if (actions.length > 3) {
      throw const ValidationException('Maksimal tiga tindakan per hari.');
    }
  }

  Project _projectFromRow(ProjectRow row) => Project(
    id: row.id,
    name: row.name,
    shortGoal: row.shortGoal,
    whyChosen: row.whyChosen,
    successDefinition: row.successDefinition,
    targetRevenueMinor: row.targetRevenueMinor,
    status: ProjectStatus.values.byName(row.status),
    startDate: row.startDate?.toUtc(),
    reviewDate: row.reviewDate?.toUtc(),
    primaryGuideDocumentId: row.primaryGuideDocumentId,
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
    archivedAt: row.archivedAt?.toUtc(),
  );

  Sprint _sprintFromRow(SprintRow row) => Sprint(
    id: row.id,
    projectId: row.projectId,
    name: row.name,
    hypothesis: row.hypothesis,
    startDate: row.startDate.toUtc(),
    endDate: row.endDate.toUtc(),
    targetOutputs: row.targetOutputs,
    successCriteria: row.successCriteria,
    status: SprintStatus.values.byName(row.status),
  );

  DailyAction _actionFromRow(DailyActionRow row) => DailyAction(
    id: row.id,
    position: row.position,
    label: row.label,
    isCompleted: row.isCompleted,
    completedAt: row.completedAt?.toUtc(),
  );

  ShipRecord _shipFromRow(ShipRecordRow row) => ShipRecord(
    id: row.id,
    outputType: row.outputType,
    outputTitle: row.outputTitle,
    externalUrl: row.externalUrl,
    evidenceNote: row.evidenceNote,
    isPartial: row.isPartial,
    shippedAt: row.shippedAt.toUtc(),
  );

  DateTime _utcDay(DateTime value) =>
      DateTime.utc(value.year, value.month, value.day);

  String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
