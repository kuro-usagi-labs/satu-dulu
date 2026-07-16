import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

import 'fakes/fake_tracker_repository.dart';

void main() {
  testWidgets('Today emphasizes one outcome and at most three actions', (
    tester,
  ) async {
    final fixture = _fixture();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackerRepositoryProvider.overrideWithValue(
            FakeTrackerRepository(projects: [fixture.project], today: fixture),
          ),
        ],
        child: const SatuDuluApp(),
      ),
    );
    await _pumpUntilFound(tester, find.text('Ship Hari Ini'));

    expect(find.text('Terbitkan video pertama'), findsOneWidget);
    expect(find.byType(CheckboxListTile), findsNWidgets(3));
    expect(find.text('Hari 1/30'), findsOneWidget);

    await tester.ensureVisible(find.text('Energi lagi rendah'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Energi lagi rendah'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Tulis satu paragraf'), findsOneWidget);

    await tester.ensureVisible(find.text('Aku Lupa Arah'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Aku Lupa Arah'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Menguji channel tutorial'), findsOneWidget);
    expect(find.text('Paling dekat dengan calon pengguna'), findsOneWidget);
    expect(find.text('Kerjakan sekarang'), findsOneWidget);
  });
}

TodayOverview _fixture() {
  final day = DateTime.utc(2026, 7, 16);
  final project = Project(
    id: 'project-1',
    name: 'Channel Flutter',
    shortGoal: 'Menguji channel tutorial',
    whyChosen: 'Paling dekat dengan calon pengguna',
    status: ProjectStatus.focus,
    startDate: day,
    reviewDate: day.add(const Duration(days: 29)),
    createdAt: day,
    updatedAt: day,
  );
  return TodayOverview(
    project: project,
    sprint: Sprint(
      id: 'sprint-1',
      projectId: project.id,
      name: 'Eksperimen 30 hari',
      startDate: day,
      endDate: day.add(const Duration(days: 29)),
      status: SprintStatus.active,
    ),
    dailyPlanId: 'plan-1',
    planDate: day,
    requiredOutcome: 'Terbitkan video pertama',
    lowEnergyAction: 'Tulis satu paragraf',
    actions: const [
      DailyAction(
        id: 'a1',
        position: 0,
        label: 'Tulis skrip',
        isCompleted: false,
      ),
      DailyAction(
        id: 'a2',
        position: 1,
        label: 'Rekam video',
        isCompleted: false,
      ),
      DailyAction(
        id: 'a3',
        position: 2,
        label: 'Terbitkan',
        isCompleted: false,
      ),
    ],
  );
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
