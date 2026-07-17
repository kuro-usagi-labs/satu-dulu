import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/anti_forget/data/repositories/drift_anti_forget_repository.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

void main() {
  late AppDatabase database;
  late DriftAntiForgetRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftAntiForgetRepository(database);
  });

  tearDown(() => database.close());

  test('capturing an idea does not create a project or sprint', () async {
    await repository.captureIdea(
      const IdeaInput(title: 'Seri video baru', note: 'Tes format 15 detik'),
    );

    expect(await database.select(database.projects).get(), isEmpty);
    expect(await database.select(database.sprints).get(), isEmpty);
    final ideas = await repository.watchIdeas().first;
    expect(ideas, hasLength(1));
    expect(ideas.single.disposition, IdeaDisposition.inbox);
  });

  test('converting an idea creates a parked project and restart capsule', () async {
    final ideaId = await repository.captureIdea(
      const IdeaInput(
        title: 'Jual PDF',
        note: 'Validasi satu produk digital',
        source: 'Catatan malam',
      ),
    );

    final projectId = await repository.convertIdeaToProject(ideaId);
    final project = await (database.select(database.projects)
          ..where((table) => table.id.equals(projectId)))
        .getSingle();
    final capsule = await repository.getRestartCapsule(projectId);

    expect(project.status, ProjectStatus.parkingLot.name);
    expect(project.shortGoal, 'Validasi satu produk digital');
    expect(await database.select(database.sprints).get(), isEmpty);
    expect(capsule, isNotNull);
    expect(capsule!.nextAction, contains('Tentukan tujuan'));
    expect(await repository.watchIdeas().first, isEmpty);
  });

  test('daily check-in is upserted for one local day', () async {
    final day = DateTime(2026, 7, 17, 8);
    await repository.saveDailyCheckIn(
      DailyCheckInInput(
        checkInDate: day,
        energyLevel: EnergyLevel.low,
        availableMinutes: 10,
      ),
    );
    await repository.saveDailyCheckIn(
      DailyCheckInInput(
        checkInDate: day.add(const Duration(hours: 4)),
        energyLevel: EnergyLevel.normal,
        availableMinutes: 30,
        note: 'Sudah lebih enak',
      ),
    );

    final rows = await database.select(database.dailyCheckIns).get();
    final saved = await repository.getDailyCheckIn(day);
    expect(rows, hasLength(1));
    expect(saved!.energyLevel, EnergyLevel.normal);
    expect(saved.availableMinutes, 30);
  });
}
