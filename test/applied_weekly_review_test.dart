import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/data/repositories/drift_tracker_repository.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/results/data/repositories/drift_results_repository.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';

void main() {
  late AppDatabase database;
  late DriftTrackerRepository tracker;
  late DriftResultsRepository results;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    tracker = DriftTrackerRepository(database);
    results = DriftResultsRepository(database);
  });

  tearDown(() => database.close());

  test(
    'park review updates status, sprint, capsule, and audit field',
    () async {
      final projectId = await tracker.createProject(_projectInput('TikTok'));
      final input = _reviewInput(
        projectId,
        decision: ReviewDecision.park,
        next: 'Tulis tiga hook saat proyek dilanjutkan',
      );

      await results.saveAndApplyWeeklyReview(input);

      final project = await (database.select(
        database.projects,
      )..where((table) => table.id.equals(projectId))).getSingle();
      final sprint = await (database.select(
        database.sprints,
      )..where((table) => table.projectId.equals(projectId))).getSingle();
      final capsule = await (database.select(
        database.restartCapsules,
      )..where((table) => table.projectId.equals(projectId))).getSingle();
      final review = await database.select(database.weeklyReviews).getSingle();

      expect(project.status, ProjectStatus.parkingLot.name);
      expect(sprint.status, SprintStatus.cancelled.name);
      expect(capsule.nextAction, 'Tulis tiga hook saat proyek dilanjutkan');
      expect(review.decisionAppliedAt, isNotNull);
    },
  );

  test(
    'pivot closes old sprint and creates a new active sprint with plan',
    () async {
      final projectId = await tracker.createProject(_projectInput('YouTube'));

      await results.saveAndApplyWeeklyReview(
        _reviewInput(
          projectId,
          decision: ReviewDecision.pivot,
          next: 'Uji video 30 detik dengan hook konflik',
        ),
      );

      final sprints = await (database.select(
        database.sprints,
      )..where((table) => table.projectId.equals(projectId))).get();
      final active = sprints.where(
        (sprint) => sprint.status == SprintStatus.active.name,
      );
      final completed = sprints.where(
        (sprint) => sprint.status == SprintStatus.completed.name,
      );

      expect(active, hasLength(1));
      expect(completed, hasLength(1));
      final activeSprint = active.single;
      expect(activeSprint.hypothesis, contains('hook konflik'));
      final plan = await (database.select(
        database.dailyPlans,
      )..where((table) => table.sprintId.equals(activeSprint.id))).getSingle();
      expect(plan.requiredOutcome, contains('hook konflik'));
    },
  );

  test('applied review cannot be applied twice', () async {
    final projectId = await tracker.createProject(_projectInput('PDF'));
    final input = _reviewInput(
      projectId,
      decision: ReviewDecision.continueFocus,
      next: 'Terbitkan satu halaman penjualan',
    );

    await results.saveAndApplyWeeklyReview(input);

    expect(
      () => results.saveAndApplyWeeklyReview(input),
      throwsA(isA<ValidationException>()),
    );
  });
}

CreateProjectInput _projectInput(String name) {
  return CreateProjectInput(
    name: name,
    shortGoal: 'Validasi satu arah',
    whyChosen: 'Paling dekat dengan hasil',
    successDefinition: 'Tujuh output',
    status: ProjectStatus.focus,
    startDate: DateTime.now(),
    requiredOutcome: 'Terbitkan output pertama',
    actions: const ['Mulai', 'Terbitkan'],
    lowEnergyAction: 'Tulis satu kalimat',
  );
}

WeeklyReviewInput _reviewInput(
  String projectId, {
  required ReviewDecision decision,
  required String next,
}) {
  final now = DateTime.now();
  final start = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: now.weekday - 1));
  return WeeklyReviewInput(
    projectId: projectId,
    weekStart: start,
    weekEnd: start.add(const Duration(days: 6)),
    shippedSummary: 'Dua output',
    importantResult: 'Hook pendek lebih kuat',
    workedWell: 'Produksi pagi',
    wasteOrBlocker: 'Terlalu lama memilih angle',
    decision: decision,
    nextWeekFocus: next,
  );
}
