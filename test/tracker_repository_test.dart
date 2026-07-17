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
  );
}
