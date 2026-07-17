import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/data/repositories/drift_tracker_repository.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

void main() {
  late AppDatabase database;
  late DriftTrackerRepository repository;
  final day = DateTime(2026, 7, 16);

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftTrackerRepository(database);
  });

  tearDown(() => database.close());

  test(
    'creating a second focus moves the previous focus to parking lot',
    () async {
      await repository.createProject(_input(name: 'Focus A', day: day));
      await repository.createProject(_input(name: 'Focus B', day: day));

      final projects = await repository.watchProjects().first;
      expect(
        projects.where((project) => project.status == ProjectStatus.focus),
        hasLength(1),
      );
      expect(
        projects.singleWhere((project) => project.name == 'Focus B').status,
        ProjectStatus.focus,
      );
      expect(
        projects.singleWhere((project) => project.name == 'Focus A').status,
        ProjectStatus.parkingLot,
      );
    },
  );

  test(
    'creating a second maintenance moves the previous one to parking lot',
    () async {
      await repository.createProject(
        _input(
          name: 'Maintenance A',
          day: day,
          status: ProjectStatus.maintenance,
        ),
      );
      await repository.createProject(
        _input(
          name: 'Maintenance B',
          day: day,
          status: ProjectStatus.maintenance,
        ),
      );

      final projects = await repository.watchProjects().first;
      expect(
        projects.where(
          (project) => project.status == ProjectStatus.maintenance,
        ),
        hasLength(1),
      );
    },
  );

  test('daily plan has at most three actions', () async {
    expect(
      () => repository.createProject(
        _input(
          name: 'Too many actions',
          day: day,
          actions: const ['A', 'B', 'C', 'D'],
        ),
      ),
      throwsA(isA<ValidationException>()),
    );
  });

  test(
    'today actions and ship persist and duplicate ship is rejected',
    () async {
      await repository.createProject(_input(name: 'Focus', day: day));
      final initial = await repository.loadToday(day);
      expect(initial, isNotNull);
      expect(initial!.actions, hasLength(2));

      await repository.setActionCompleted(
        initial.actions.first.id,
        completed: true,
      );
      await repository.shipToday(
        dailyPlanId: initial.dailyPlanId,
        outputTitle: 'Video pertama',
        isPartial: false,
      );

      final saved = await repository.loadToday(day);
      expect(saved!.actions.first.isCompleted, isTrue);
      expect(saved.shipRecord?.outputTitle, 'Video pertama');
      final metric = await database.select(database.metricEntries).getSingle();
      expect(metric.outputsCount, 1);
      expect(metric.note, 'Video pertama');
      expect(
        () => repository.shipToday(
          dailyPlanId: initial.dailyPlanId,
          outputTitle: 'Duplikat',
          isPartial: false,
        ),
        throwsA(isA<ValidationException>()),
      );
    },
  );

  test('unfinished actions do not roll over into the next day', () async {
    await repository.createProject(_input(name: 'Focus', day: day));

    expect(
      await repository.loadToday(day.add(const Duration(days: 1))),
      isNull,
    );
    await repository.createDailyPlan(
      CreateDailyPlanInput(
        planDate: day.add(const Duration(days: 1)),
        requiredOutcome: 'Hasil baru',
        actions: const ['Tindakan baru'],
      ),
    );
    final nextDay = await repository.loadToday(
      day.add(const Duration(days: 1)),
    );
    expect(nextDay!.requiredOutcome, 'Hasil baru');
    expect(nextDay.actions.map((action) => action.label), ['Tindakan baru']);
  });

  group('30-day cycle closure', () {
    test('review target becomes due only after the sprint end date', () async {
      final projectId = await repository.createProject(
        _input(name: 'Focus', day: day),
      );
      final sprint = await repository.getLatestSprint(projectId);

      final lastDayTarget = await repository.getCycleReviewTarget(
        projectId,
        day.add(const Duration(days: 29)),
      );
      final dueTarget = await repository.getCycleReviewTarget(
        projectId,
        day.add(const Duration(days: 30)),
      );

      expect(lastDayTarget?.availability, CycleReviewAvailability.notDue);
      expect(lastDayTarget?.canClose, isFalse);
      expect(dueTarget?.availability, CycleReviewAvailability.due);
      expect(dueTarget?.canClose, isTrue);
      expect(dueTarget?.sprint?.id, sprint?.id);
    });

    test(
      'Continue completes the old sprint and starts one new cycle',
      () async {
        final projectId = await repository.createProject(
          _input(name: 'Focus', day: day),
        );
        final oldSprint = (await repository.getLatestSprint(projectId))!;
        final decisionDay = day.add(const Duration(days: 30));

        final result = await repository.closeCycle(
          CloseCycleInput(
            projectId: projectId,
            sprintId: oldSprint.id,
            decision: CycleDecision.continueFocus,
            decidedAt: decisionDay,
            evidenceSummary: '  Format pendek mulai bekerja.  ',
          ),
        );

        final sprintRows = await database.select(database.sprints).get();
        final oldRow = sprintRows.singleWhere((row) => row.id == oldSprint.id);
        final nextRow = sprintRows.singleWhere(
          (row) => row.id == result.nextSprintId,
        );
        final project = await repository.getProject(projectId);
        final closure = await database
            .select(database.sprintClosures)
            .getSingle();

        expect(result.decision, CycleDecision.continueFocus);
        expect(result.focusProjectId, projectId);
        expect(result.replacementProjectId, isNull);
        expect(oldRow.status, SprintStatus.completed.name);
        expect(nextRow.status, SprintStatus.active.name);
        expect(nextRow.startDate.toUtc(), DateTime.utc(2026, 8, 15));
        expect(nextRow.endDate.toUtc(), DateTime.utc(2026, 9, 13));
        expect(project?.reviewDate, DateTime.utc(2026, 9, 13));
        expect(
          sprintRows.where((row) => row.status == SprintStatus.active.name),
          hasLength(1),
        );
        expect(closure.sprintId, oldSprint.id);
        expect(closure.nextSprintId, result.nextSprintId);
        expect(closure.evidenceSummary, 'Format pendek mulai bekerja.');
      },
    );

    test(
      'Pivot validates its approach and preserves the project goal',
      () async {
        final projectId = await repository.createProject(
          _input(name: 'Focus', day: day),
        );
        final oldSprint = (await repository.getLatestSprint(projectId))!;
        final decisionDay = day.add(const Duration(days: 30));

        await expectLater(
          repository.closeCycle(
            CloseCycleInput(
              projectId: projectId,
              sprintId: oldSprint.id,
              decision: CycleDecision.pivot,
              decidedAt: decisionDay,
              nextApproach: '   ',
            ),
          ),
          throwsA(isA<ValidationException>()),
        );
        expect(await database.select(database.sprintClosures).get(), isEmpty);
        expect(await database.select(database.sprints).get(), hasLength(1));
        expect(
          (await repository.getLatestSprint(projectId))?.status,
          SprintStatus.active,
        );

        final result = await repository.closeCycle(
          CloseCycleInput(
            projectId: projectId,
            sprintId: oldSprint.id,
            decision: CycleDecision.pivot,
            decidedAt: decisionDay,
            nextApproach: '  Uji format carousel  ',
          ),
        );

        final project = await repository.getProject(projectId);
        final nextSprint = await repository.getLatestSprint(projectId);
        final closure = await database
            .select(database.sprintClosures)
            .getSingle();
        expect(result.decision, CycleDecision.pivot);
        expect(project?.shortGoal, 'Menerbitkan satu hasil');
        expect(nextSprint?.id, result.nextSprintId);
        expect(nextSprint?.hypothesis, 'Uji format carousel');
        expect(closure.nextApproach, 'Uji format carousel');
      },
    );

    test('Park can skip choosing a replacement focus', () async {
      final projectId = await repository.createProject(
        _input(name: 'Focus', day: day),
      );
      final oldSprint = (await repository.getLatestSprint(projectId))!;

      final result = await repository.closeCycle(
        CloseCycleInput(
          projectId: projectId,
          sprintId: oldSprint.id,
          decision: CycleDecision.park,
          decidedAt: day.add(const Duration(days: 30)),
        ),
      );

      final project = await repository.getProject(projectId);
      final sprintRows = await database.select(database.sprints).get();
      final closure = await database
          .select(database.sprintClosures)
          .getSingle();
      expect(result.nextSprintId, isNull);
      expect(result.focusProjectId, isNull);
      expect(result.replacementProjectId, isNull);
      expect(project?.status, ProjectStatus.parkingLot);
      expect(await repository.getFocusProject(), isNull);
      expect(sprintRows.single.status, SprintStatus.completed.name);
      expect(closure.decision, CycleDecision.park.name);
      expect(closure.nextSprintId, isNull);
      expect(closure.replacementProjectId, isNull);
    });

    test(
      'Park replaces a stale sprint with a current replacement cycle',
      () async {
        final replacementDay = day.subtract(const Duration(days: 100));
        final replacementId = await repository.createProject(
          _input(
            name: 'Fokus pengganti',
            day: replacementDay,
            status: ProjectStatus.parkingLot,
          ),
        );
        final staleSprint = (await repository.getLatestSprint(replacementId))!;
        final projectId = await repository.createProject(
          _input(name: 'Focus', day: day),
        );
        final oldSprint = (await repository.getLatestSprint(projectId))!;
        final decisionDay = day.add(const Duration(days: 30));

        final result = await repository.closeCycle(
          CloseCycleInput(
            projectId: projectId,
            sprintId: oldSprint.id,
            decision: CycleDecision.park,
            decidedAt: decisionDay,
            replacementProjectId: replacementId,
          ),
        );

        final sprintRows = await database.select(database.sprints).get();
        final staleRow = sprintRows.singleWhere(
          (row) => row.id == staleSprint.id,
        );
        final replacementRow = sprintRows.singleWhere(
          (row) => row.id == result.nextSprintId,
        );
        final focus = await repository.getFocusProject();
        final closure = await database
            .select(database.sprintClosures)
            .getSingle();

        expect(staleRow.status, SprintStatus.cancelled.name);
        expect(replacementRow.projectId, replacementId);
        expect(replacementRow.status, SprintStatus.active.name);
        expect(replacementRow.startDate.toUtc(), DateTime.utc(2026, 8, 15));
        expect(replacementRow.endDate.toUtc(), DateTime.utc(2026, 9, 13));
        expect(focus?.id, replacementId);
        expect(result.focusProjectId, replacementId);
        expect(result.replacementProjectId, replacementId);
        expect(closure.replacementProjectId, replacementId);
        expect(closure.nextSprintId, isNull);
        expect(
          sprintRows.where(
            (row) =>
                row.projectId == replacementId &&
                row.status == SprintStatus.active.name,
          ),
          hasLength(1),
        );
      },
    );

    test(
      'duplicate retry is rejected without changing committed state',
      () async {
        final projectId = await repository.createProject(
          _input(name: 'Focus', day: day),
        );
        final oldSprint = (await repository.getLatestSprint(projectId))!;
        final input = CloseCycleInput(
          projectId: projectId,
          sprintId: oldSprint.id,
          decision: CycleDecision.continueFocus,
          decidedAt: day.add(const Duration(days: 30)),
        );
        final first = await repository.closeCycle(input);
        final committedReviewDate = (await repository.getProject(
          projectId,
        ))?.reviewDate;

        await expectLater(
          repository.closeCycle(input),
          throwsA(isA<ValidationException>()),
        );

        final sprintRows = await database.select(database.sprints).get();
        final closureRows = await database
            .select(database.sprintClosures)
            .get();
        expect(sprintRows, hasLength(2));
        expect(closureRows, hasLength(1));
        expect(closureRows.single.id, first.closureId);
        expect(closureRows.single.nextSprintId, first.nextSprintId);
        expect(
          sprintRows.where((row) => row.status == SprintStatus.active.name),
          hasLength(1),
        );
        expect(
          (await repository.getProject(projectId))?.reviewDate,
          committedReviewDate,
        );
      },
    );

    test('new cycle does not roll the previous daily plan forward', () async {
      final projectId = await repository.createProject(
        _input(name: 'Focus', day: day, actions: const ['Tulis', 'Terbitkan']),
      );
      final oldSprint = (await repository.getLatestSprint(projectId))!;
      final oldPlan = await repository.loadToday(day);
      final decisionDay = day.add(const Duration(days: 30));

      final result = await repository.closeCycle(
        CloseCycleInput(
          projectId: projectId,
          sprintId: oldSprint.id,
          decision: CycleDecision.continueFocus,
          decidedAt: decisionDay,
        ),
      );

      final plans = await database.select(database.dailyPlans).get();
      final actions = await database.select(database.dailyActions).get();
      expect(plans, hasLength(1));
      expect(plans.single.id, oldPlan?.dailyPlanId);
      expect(plans.single.sprintId, oldSprint.id);
      expect(actions.map((action) => action.label), ['Tulis', 'Terbitkan']);
      expect(
        plans.where((plan) => plan.sprintId == result.nextSprintId),
        isEmpty,
      );
      expect(await repository.loadToday(decisionDay), isNull);
    });
  });

  test(
    'editing a parking-lot project to focus replaces focus atomically',
    () async {
      await repository.createProject(_input(name: 'Focus A', day: day));
      final parkingId = await repository.createProject(
        _input(name: 'Project B', day: day, status: ProjectStatus.parkingLot),
      );
      await repository.updateProject(
        parkingId,
        const UpdateProjectInput(
          name: 'Project B edited',
          shortGoal: 'Tujuan baru',
          status: ProjectStatus.focus,
        ),
      );

      final projects = await repository.watchProjects().first;
      expect(
        projects.where((project) => project.status == ProjectStatus.focus),
        hasLength(1),
      );
      expect(
        projects.singleWhere((project) => project.id == parkingId).name,
        'Project B edited',
      );
      expect(
        projects.singleWhere((project) => project.name == 'Focus A').status,
        ProjectStatus.parkingLot,
      );
    },
  );

  test('archived project is removed from the main project stream', () async {
    final id = await repository.createProject(_input(name: 'Focus', day: day));
    await repository.archiveProject(id);

    expect(await repository.watchProjects().first, isEmpty);
  });
}

CreateProjectInput _input({
  required String name,
  required DateTime day,
  ProjectStatus status = ProjectStatus.focus,
  List<String> actions = const ['Tulis', 'Terbitkan'],
  int sprintDays = 30,
}) {
  return CreateProjectInput(
    name: name,
    shortGoal: 'Menerbitkan satu hasil',
    whyChosen: 'Paling dekat dengan pengguna',
    successDefinition: 'Tiga puluh output',
    status: status,
    startDate: day,
    requiredOutcome: 'Terbitkan hasil pertama',
    actions: actions,
    lowEnergyAction: 'Tulis satu paragraf',
    sprintDays: sprintDays,
  );
}
