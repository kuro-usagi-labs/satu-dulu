import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/domain/repositories/anti_forget_repository.dart';
import 'package:satu_dulu/features/anti_forget/domain/services/recovery_evaluator.dart';
import 'package:satu_dulu/features/projects/data/repositories/tracker_repository_support.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:uuid/uuid.dart';

class DriftAntiForgetRepository implements AntiForgetRepository {
  DriftAntiForgetRepository(this._database, [this._uuid = const Uuid()]);

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Stream<List<Idea>> watchIdeas({bool includeResolved = false}) {
    final query = _database.select(_database.ideas)
      ..orderBy([(table) => OrderingTerm.desc(table.capturedAt)]);
    if (!includeResolved) {
      query.where(
        (table) =>
            table.disposition.equals(IdeaDisposition.inbox.name) |
            table.disposition.equals(IdeaDisposition.parked.name),
      );
    }
    return query.watch().map(
      (rows) => List.unmodifiable(rows.map(_ideaFromRow)),
    );
  }

  @override
  Future<String> captureIdea(IdeaInput input) async {
    final title = input.title.trim();
    if (title.isEmpty) {
      throw const ValidationException('Judul ide wajib diisi.');
    }
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    try {
      await _database
          .into(_database.ideas)
          .insert(
            IdeasCompanion.insert(
              id: id,
              title: title,
              note: Value(_trim(input.note)),
              source: Value(_trim(input.source)),
              disposition: IdeaDisposition.inbox.name,
              capturedAt: now,
              updatedAt: now,
            ),
          );
      return id;
    } catch (error) {
      throw DatabaseException('Ide belum dapat disimpan.', error);
    }
  }

  @override
  Future<void> updateIdea(String ideaId, IdeaInput input) async {
    final title = input.title.trim();
    if (title.isEmpty) {
      throw const ValidationException('Judul ide wajib diisi.');
    }
    final affected =
        await (_database.update(
          _database.ideas,
        )..where((table) => table.id.equals(ideaId))).write(
          IdeasCompanion(
            title: Value(title),
            note: Value(_trim(input.note)),
            source: Value(_trim(input.source)),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    if (affected != 1) {
      throw const DatabaseException('Ide tidak ditemukan.');
    }
  }

  @override
  Future<void> setIdeaDisposition(
    String ideaId,
    IdeaDisposition disposition,
  ) async {
    final affected =
        await (_database.update(
          _database.ideas,
        )..where((table) => table.id.equals(ideaId))).write(
          IdeasCompanion(
            disposition: Value(disposition.name),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    if (affected != 1) {
      throw const DatabaseException('Ide tidak ditemukan.');
    }
  }

  @override
  Future<String> convertIdeaToProject(String ideaId) async {
    final now = DateTime.now().toUtc();
    try {
      return await _database.transaction(() async {
        final idea =
            await (_database.select(_database.ideas)
                  ..where((table) => table.id.equals(ideaId))
                  ..limit(1))
                .getSingleOrNull();
        if (idea == null) {
          throw const DatabaseException('Ide tidak ditemukan.');
        }
        if (idea.convertedProjectId case final existingId?) {
          return existingId;
        }
        if (idea.disposition == IdeaDisposition.discarded.name) {
          throw const ValidationException(
            'Pulihkan ide ini sebelum mengubahnya menjadi proyek.',
          );
        }

        final projectId = _uuid.v4();
        await _database
            .into(_database.projects)
            .insert(
              ProjectsCompanion.insert(
                id: projectId,
                name: idea.title.trim(),
                shortGoal:
                    _trim(idea.note) ?? 'Uji apakah ide ini layak dijalankan.',
                whyChosen: Value(_trim(idea.source)),
                status: ProjectStatus.parkingLot.name,
                createdAt: now,
                updatedAt: now,
              ),
            );

        await _database
            .into(_database.restartCapsules)
            .insert(
              RestartCapsulesCompanion.insert(
                id: _uuid.v4(),
                projectId: projectId,
                lastKnownState: const Value(
                  'Ide sudah ditangkap, tetapi belum menjadi fokus aktif.',
                ),
                nextAction: const Value(
                  'Tentukan tujuan 30 hari dan bukti pertama.',
                ),
                createdAt: now,
                updatedAt: now,
              ),
            );

        await (_database.update(
          _database.ideas,
        )..where((table) => table.id.equals(ideaId))).write(
          IdeasCompanion(
            disposition: Value(IdeaDisposition.converted.name),
            convertedProjectId: Value(projectId),
            updatedAt: Value(now),
          ),
        );
        return projectId;
      });
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Ide belum dapat diubah menjadi proyek.', error);
    }
  }

  @override
  Future<RestartCapsule?> getRestartCapsule(String projectId) async {
    final row =
        await (_database.select(_database.restartCapsules)
              ..where((table) => table.projectId.equals(projectId))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _capsuleFromRow(row);
  }

  @override
  Future<void> saveRestartCapsule(RestartCapsuleInput input) async {
    final project =
        await (_database.select(_database.projects)
              ..where((table) => table.id.equals(input.projectId))
              ..limit(1))
            .getSingleOrNull();
    if (project == null) {
      throw const DatabaseException('Proyek tidak ditemukan.');
    }
    final existing =
        await (_database.select(_database.restartCapsules)
              ..where((table) => table.projectId.equals(input.projectId))
              ..limit(1))
            .getSingleOrNull();
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.restartCapsules)
        .insertOnConflictUpdate(
          RestartCapsulesCompanion.insert(
            id: existing?.id ?? _uuid.v4(),
            projectId: input.projectId,
            lastKnownState: Value(_trim(input.lastKnownState)),
            lastOutput: Value(_trim(input.lastOutput)),
            whatWorked: Value(_trim(input.whatWorked)),
            blocker: Value(_trim(input.blocker)),
            nextAction: Value(_trim(input.nextAction)),
            parkedReason: Value(_trim(input.parkedReason)),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<DailyCheckIn?> getDailyCheckIn(DateTime localDate) async {
    final day = _dateOnlyUtc(localDate);
    final row =
        await (_database.select(_database.dailyCheckIns)
              ..where((table) => table.checkInDate.equals(day))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _checkInFromRow(row);
  }

  @override
  Future<void> saveDailyCheckIn(DailyCheckInInput input) async {
    if (input.availableMinutes < 5 || input.availableMinutes > 12 * 60) {
      throw const ValidationException('Waktu tersedia tidak masuk akal.');
    }
    final day = _dateOnlyUtc(input.checkInDate);
    final existing =
        await (_database.select(_database.dailyCheckIns)
              ..where((table) => table.checkInDate.equals(day))
              ..limit(1))
            .getSingleOrNull();
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.dailyCheckIns)
        .insertOnConflictUpdate(
          DailyCheckInsCompanion.insert(
            id: existing?.id ?? _uuid.v4(),
            checkInDate: day,
            energyLevel: input.energyLevel.name,
            availableMinutes: input.availableMinutes,
            note: Value(_trim(input.note)),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<AntiForgetTodaySupport> loadTodaySupport(DateTime localDate) async {
    final now = localDate.toLocal();
    final day = _dateOnlyUtc(now);
    final checkIn = await getDailyCheckIn(now);
    final focus =
        await (_database.select(_database.projects)
              ..where((table) => table.status.equals(ProjectStatus.focus.name))
              ..limit(1))
            .getSingleOrNull();
    if (focus == null) {
      return AntiForgetTodaySupport(
        checkIn: checkIn,
        capsule: null,
        recovery: const RecoveryBrief.none(),
      );
    }

    final capsuleRow =
        await (_database.select(_database.restartCapsules)
              ..where((table) => table.projectId.equals(focus.id))
              ..limit(1))
            .getSingleOrNull();
    final capsule = capsuleRow == null ? null : _capsuleFromRow(capsuleRow);
    final activeSprint =
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

    DailyPlanRow? plan;
    var actionCount = 0;
    var shippedToday = false;
    if (activeSprint != null) {
      plan =
          await (_database.select(_database.dailyPlans)
                ..where(
                  (table) =>
                      table.sprintId.equals(activeSprint.id) &
                      table.planDate.equals(day),
                )
                ..limit(1))
              .getSingleOrNull();
      if (plan != null) {
        actionCount =
            await (_database.selectOnly(_database.dailyActions)
                  ..addColumns([_database.dailyActions.id.count()])
                  ..where(_database.dailyActions.dailyPlanId.equals(plan.id)))
                .map((row) => row.read(_database.dailyActions.id.count()) ?? 0)
                .getSingle();
        shippedToday =
            await (_database.select(_database.shipRecords)
                  ..where((table) => table.dailyPlanId.equals(plan!.id))
                  ..limit(1))
                .getSingleOrNull() !=
            null;
      }
    }

    final shipJoin =
        _database.select(_database.shipRecords).join([
            innerJoin(
              _database.dailyPlans,
              _database.dailyPlans.id.equalsExp(
                _database.shipRecords.dailyPlanId,
              ),
            ),
            innerJoin(
              _database.sprints,
              _database.sprints.id.equalsExp(_database.dailyPlans.sprintId),
            ),
          ])
          ..where(_database.sprints.projectId.equals(focus.id))
          ..orderBy([OrderingTerm.desc(_database.shipRecords.shippedAt)]);
    final shipRows = await shipJoin.get();
    final lastShippedAt = shipRows.isEmpty
        ? null
        : shipRows.first.readTable(_database.shipRecords).shippedAt;
    final sevenDaysAgo = day.subtract(const Duration(days: 6));
    final shipsLastSevenDays = shipRows.where((row) {
      final shippedAt = row.readTable(_database.shipRecords).shippedAt;
      return !shippedAt.isBefore(sevenDaysAgo);
    }).length;

    final snapshot = RecoverySnapshot(
      now: now,
      project: TrackerRepositorySupport.projectFromRow(focus),
      hasActiveSprint: activeSprint != null,
      hasTodayPlan: plan != null,
      todayActionCount: actionCount,
      shippedToday: shippedToday,
      shipsLastSevenDays: shipsLastSevenDays,
      checkIn: checkIn,
      capsule: capsule,
      lastShippedAt: lastShippedAt,
    );
    return AntiForgetTodaySupport(
      checkIn: checkIn,
      capsule: capsule,
      recovery: RecoveryEvaluator.evaluate(snapshot),
    );
  }

  Idea _ideaFromRow(IdeaRow row) => Idea(
    id: row.id,
    title: row.title,
    note: row.note,
    source: row.source,
    disposition: IdeaDisposition.values.byName(row.disposition),
    convertedProjectId: row.convertedProjectId,
    capturedAt: row.capturedAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  RestartCapsule _capsuleFromRow(RestartCapsuleRow row) => RestartCapsule(
    id: row.id,
    projectId: row.projectId,
    lastKnownState: row.lastKnownState,
    lastOutput: row.lastOutput,
    whatWorked: row.whatWorked,
    blocker: row.blocker,
    nextAction: row.nextAction,
    parkedReason: row.parkedReason,
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  DailyCheckIn _checkInFromRow(DailyCheckInRow row) => DailyCheckIn(
    id: row.id,
    checkInDate: row.checkInDate.toUtc(),
    energyLevel: EnergyLevel.values.byName(row.energyLevel),
    availableMinutes: row.availableMinutes,
    note: row.note,
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  DateTime _dateOnlyUtc(DateTime value) {
    final local = value.toLocal();
    return DateTime.utc(local.year, local.month, local.day);
  }

  String? _trim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
