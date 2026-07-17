import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/repositories/results_repository.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

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

  testWidgets('Today has no overflow at 320px with larger text', (
    tester,
  ) async {
    _useCompactViewport(tester);
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
    expect(find.text('Tulis skrip'), findsWidgets);
    expect(find.text('Rekam video'), findsOneWidget);
    expect(find.text('Terbitkan'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(find.text('Aku Lupa Arah'));
    await tester.pumpAndSettle();

    expect(find.text('Aku Lupa Arah'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('recovery falls back to the outcome when actions are empty', (
    tester,
  ) async {
    final fixture = _fixture();
    final todayWithoutActions = TodayOverview(
      project: fixture.project,
      sprint: fixture.sprint,
      dailyPlanId: fixture.dailyPlanId,
      planDate: fixture.planDate,
      requiredOutcome: fixture.requiredOutcome,
      lowEnergyAction: fixture.lowEnergyAction,
      linkedGuideDocumentId: fixture.linkedGuideDocumentId,
      linkedGuidePage: fixture.linkedGuidePage,
      actions: const [],
      shipRecord: fixture.shipRecord,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackerRepositoryProvider.overrideWithValue(
            FakeTrackerRepository(
              projects: [fixture.project],
              today: todayWithoutActions,
            ),
          ),
        ],
        child: const SatuDuluApp(),
      ),
    );
    await _pumpUntilFound(tester, find.text('Aku Lupa Arah'));

    await tester.ensureVisible(find.text('Aku Lupa Arah'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Aku Lupa Arah'));
    await tester.pumpAndSettle();

    expect(find.text(fixture.requiredOutcome), findsWidgets);
    expect(find.text('Kerjakan sekarang'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Ship hands off to evidence entry', (tester) async {
    _disableAnimations(tester);
    final fixture = _fixture();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackerRepositoryProvider.overrideWithValue(
            FakeTrackerRepository(projects: [fixture.project], today: fixture),
          ),
          resultsRepositoryProvider.overrideWithValue(_FakeResultsRepository()),
        ],
        child: const SatuDuluApp(),
      ),
    );
    await _pumpUntilFound(tester, find.text('Ship Hari Ini'));

    await tester.tap(find.widgetWithText(FilledButton, 'Ship Hari Ini'));
    await tester.pumpAndSettle();

    expect(find.text('Apa yang benar-benar kamu kirim?'), findsOneWidget);
    expect(find.text('Terbitkan video pertama'), findsWidgets);

    final saveShipButton = find.widgetWithText(
      FilledButton,
      'Simpan Ship Hari Ini',
    );
    await tester.ensureVisible(saveShipButton);
    await tester.pumpAndSettle();
    await tester.tap(saveShipButton);
    await tester.pumpAndSettle();

    expect(find.text('Hari ini sudah punya bukti.'), findsOneWidget);
    expect(find.text('Catat angka hasil'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Catat angka hasil'));
    await tester.pumpAndSettle();

    expect(find.text('Catat bukti'), findsOneWidget);
    expect(find.text('Apa yang benar-benar terjadi?'), findsOneWidget);
    expect(
      find.text('Satu output sudah dibawa dari Ship Hari Ini'),
      findsOneWidget,
    );
    await tester.drag(find.byType(ListView), const Offset(0, -320));
    await tester.pumpAndSettle();
    final outputField = tester.widget<TextFormField>(
      find.byType(TextFormField).first,
    );
    expect(outputField.controller?.text, '1');
  });
}

void _useCompactViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 640);
  tester.platformDispatcher.textScaleFactorTestValue = 1.3;

  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

void _disableAnimations(WidgetTester tester) {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
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

class _FakeResultsRepository implements ResultsRepository {
  @override
  Future<MetricEntry?> getMetric(String projectId, DateTime localDate) async {
    return null;
  }

  @override
  Future<void> saveMetric(MetricInput input) async {}

  @override
  Future<void> saveWeeklyReview(WeeklyReviewInput input) async {}

  @override
  Future<void> saveAndApplyWeeklyReview(WeeklyReviewInput input) async {}

  @override
  Stream<ResultsSummary> watchSummary(String projectId) {
    return Stream.value(_emptySummary);
  }

  @override
  Stream<List<WeeklyReview>> watchWeeklyReviews(String projectId) {
    return Stream.value(const []);
  }
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
