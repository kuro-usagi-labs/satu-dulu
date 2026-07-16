import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

import 'fakes/fake_tracker_repository.dart';

void main() {
  testWidgets('navigates between all four shell branches', (tester) async {
    final now = DateTime.now().toUtc();
    final project = Project(
      id: 'project-1',
      name: 'Focus test',
      shortGoal: 'Uji navigasi',
      status: ProjectStatus.focus,
      startDate: now,
      reviewDate: now.add(const Duration(days: 29)),
      createdAt: now,
      updatedAt: now,
    );
    final today = TodayOverview(
      project: project,
      sprint: Sprint(
        id: 'sprint-1',
        projectId: project.id,
        name: 'Eksperimen 30 hari',
        startDate: now,
        endDate: now.add(const Duration(days: 29)),
        status: SprintStatus.active,
      ),
      dailyPlanId: 'plan-1',
      planDate: now,
      requiredOutcome: 'Jalankan test',
      actions: const [
        DailyAction(
          id: 'action-1',
          position: 0,
          label: 'Buka aplikasi',
          isCompleted: false,
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          guideDocumentsProvider.overrideWith((ref) => Stream.value(const [])),
          resultsSummaryProvider.overrideWith(
            (ref, projectId) => Stream.value(_emptySummary),
          ),
          weeklyReviewsProvider.overrideWith(
            (ref, projectId) => Stream.value(const []),
          ),
          trackerRepositoryProvider.overrideWithValue(
            FakeTrackerRepository(projects: [project], today: today),
          ),
        ],
        child: const SatuDuluApp(),
      ),
    );
    await _pumpUntilFound(tester, find.text('Hari Ini'));

    await tester.tap(find.text('Proyek').last);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Focus test'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await _pumpUntilFound(tester, find.text('Belum ada panduan'));
    expect(find.text('Belum ada panduan'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.insights_outlined));
    await _pumpUntilFound(tester, find.text('Belum ada hasil tercatat'));
    expect(find.text('Belum ada hasil tercatat'), findsOneWidget);

    await tester.tap(find.text('Hari Ini').last);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Jalankan test'), findsOneWidget);
  });
}

const _emptySummary = ResultsSummary(
  entries: [],
  outputs: 0,
  views: 0,
  clicks: 0,
  orders: 0,
  revenueMinor: 0,
  workMinutes: 0,
  ordersPerThousandViews: null,
  revenuePerThousandViewsMinor: null,
  revenuePerHourMinor: null,
  outputsPerWeek: 0,
  shipConsistency: 0,
);

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
