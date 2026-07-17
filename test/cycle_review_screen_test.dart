import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

import 'fakes/fake_tracker_repository.dart';

void main() {
  testWidgets(
    'Today opens the dedicated compact cycle review with sprint evidence',
    (tester) async {
      _useCompactViewport(tester);
      final fixture = _CycleFixture.create();
      CycleResultsQuery? requestedRange;

      await _pumpApp(
        tester,
        fixture,
        summaryOverride: (query) {
          requestedRange = query;
          return fixture.summary;
        },
      );
      await _pumpUntilFound(tester, find.text('Putaran 30 harimu selesai'));

      final closeButton = find.widgetWithText(
        FilledButton,
        'Tutup putaran ini',
      );
      expect(closeButton, findsOneWidget);
      await tester.ensureVisible(closeButton);
      await tester.pumpAndSettle();
      await tester.tap(closeButton);
      await _pumpUntilFound(tester, find.text('BUKTI PUTARAN INI'));

      expect(find.text('BUKTI PUTARAN INI'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(requestedRange?.startDate, fixture.sprint.startDate);
      expect(requestedRange?.endDate, fixture.sprint.endDate);
      expect(tester.takeException(), isNull);

      await _scrollUntilFound(tester, find.text('Simpan dulu'));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Pivot validates, preserves input on error, and retries once', (
    tester,
  ) async {
    final fixture = _CycleFixture.create();
    fixture.repository.closeCycleError = const DatabaseException(
      'Penyimpanan sedang sibuk.',
    );

    await _pumpApp(tester, fixture);
    await _openCycleReview(tester);

    await _scrollUntilFound(tester, find.text('Ubah pendekatan'));
    await tester.tap(find.text('Ubah pendekatan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan pendekatan baru'));
    await _scrollUntilFound(tester, find.text('Pendekatan baru wajib diisi.'));

    expect(find.text('Pendekatan baru wajib diisi.'), findsOneWidget);
    const approach = 'Uji demo produk berdurasi tiga puluh detik';
    await tester.enterText(find.byType(TextField), approach);
    await tester.tap(find.text('Simpan pendekatan baru'));
    await tester.pumpAndSettle();

    expect(find.text('Penyimpanan sedang sibuk.'), findsOneWidget);
    expect(find.text(approach), findsOneWidget);
    expect(fixture.repository.closeCycleCallCount, 1);

    fixture.repository.closeCycleError = null;
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan pendekatan baru'));
    await tester.pumpAndSettle();

    expect(fixture.repository.closeCycleCallCount, 2);
    expect(
      fixture.repository.lastCloseCycleInput?.decision,
      CycleDecision.pivot,
    );
    expect(fixture.repository.lastCloseCycleInput?.nextApproach, approach);
  });

  testWidgets('Park filters candidates and sends the selected replacement', (
    tester,
  ) async {
    _useCompactViewport(tester);
    final fixture = _CycleFixture.create();

    await _pumpApp(tester, fixture);
    await _openCycleReview(tester);

    await _scrollUntilFound(tester, find.text('Simpan dulu'));
    await tester.tap(find.text('Simpan dulu'));
    await _scrollUntilFound(tester, find.text('Belum pilih sekarang'));

    expect(find.text('Belum pilih sekarang'), findsOneWidget);
    expect(find.text(fixture.replacement.name), findsOneWidget);
    expect(find.text(fixture.archived.name), findsNothing);

    await _scrollUntilFound(tester, find.text(fixture.replacement.name));
    await tester.tap(find.text(fixture.replacement.name));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan proyek dulu'));
    await tester.pumpAndSettle();

    expect(
      fixture.repository.lastCloseCycleInput?.replacementProjectId,
      fixture.replacement.id,
    );
    expect(
      fixture.repository.lastCloseCycleInput?.decision,
      CycleDecision.park,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('double tap cannot submit the same decision twice', (
    tester,
  ) async {
    final fixture = _CycleFixture.create();
    fixture.repository.closeCycleDelay = const Duration(milliseconds: 120);

    await _pumpApp(tester, fixture);
    await _openCycleReview(tester);

    await _scrollUntilFound(tester, find.text('Lanjutkan'));
    await tester.tap(find.text('Lanjutkan'));
    await tester.pump();
    final submit = find.text('Mulai putaran baru');
    await tester.tap(submit);
    await tester.tap(submit, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 20));

    expect(fixture.repository.closeCycleCallCount, 1);
    await tester.pumpAndSettle();
  });
}

Future<void> _pumpApp(
  WidgetTester tester,
  _CycleFixture fixture, {
  ResultsSummary Function(CycleResultsQuery query)? summaryOverride,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        trackerRepositoryProvider.overrideWithValue(fixture.repository),
        cycleResultsSummaryProvider.overrideWith((ref, query) {
          return Stream.value(summaryOverride?.call(query) ?? fixture.summary);
        }),
      ],
      child: const SatuDuluApp(),
    ),
  );
}

Future<void> _openCycleReview(WidgetTester tester) async {
  await _pumpUntilFound(tester, find.text('Putaran 30 harimu selesai'));
  final closeButton = find.widgetWithText(FilledButton, 'Tutup putaran ini');
  await tester.ensureVisible(closeButton);
  await tester.pumpAndSettle();
  await tester.tap(closeButton);
  await _pumpUntilFound(tester, find.text('BUKTI PUTARAN INI'));
}

Future<void> _scrollUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 12 && finder.evaluate().isEmpty; attempt++) {
    await tester.drag(find.byType(ListView).last, const Offset(0, -220));
    await tester.pumpAndSettle();
  }
  expect(finder, findsWidgets);
  await tester.ensureVisible(finder.first);
  await tester.pumpAndSettle();
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 50 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  expect(finder, findsWidgets);
}

void _useCompactViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 640);
  tester.platformDispatcher.textScaleFactorTestValue = 1.3;

  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

class _CycleFixture {
  const _CycleFixture({
    required this.project,
    required this.replacement,
    required this.archived,
    required this.sprint,
    required this.summary,
    required this.repository,
  });

  factory _CycleFixture.create() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = today.subtract(const Duration(days: 30));
    final end = today.subtract(const Duration(days: 1));
    final project = Project(
      id: 'focus-cycle',
      name: 'Membangun TikTok Shop',
      shortGoal: 'Temukan format video yang menghasilkan respons',
      successDefinition: 'Terbitkan 30 video dan ukur respons',
      status: ProjectStatus.focus,
      startDate: start,
      reviewDate: end,
      createdAt: start,
      updatedAt: end,
    );
    final replacement = Project(
      id: 'replacement-project',
      name: 'Membangun YouTube Channel',
      shortGoal: 'Terbitkan seri tutorial pertama',
      status: ProjectStatus.parkingLot,
      createdAt: start,
      updatedAt: end,
    );
    final archived = Project(
      id: 'archived-project',
      name: 'Proyek Lama yang Diarsipkan',
      shortGoal: 'Tidak lagi aktif',
      status: ProjectStatus.archived,
      createdAt: start,
      updatedAt: end,
      archivedAt: end,
    );
    final sprint = Sprint(
      id: 'sprint-cycle',
      projectId: project.id,
      name: 'Putaran pertama',
      startDate: start,
      endDate: end,
      status: SprintStatus.active,
      targetOutputs: 30,
      successCriteria: project.successDefinition,
    );
    final metric = MetricEntry(
      id: 'metric-cycle',
      projectId: project.id,
      entryDate: end,
      outputsCount: 3,
      views: 1200,
      orders: 4,
      revenueMinor: 350000,
      workMinutes: 180,
      createdAt: end,
      updatedAt: end,
    );
    final summary = ResultsSummary(
      entries: [metric],
      outputs: 3,
      views: 1200,
      clicks: 42,
      orders: 4,
      revenueMinor: 350000,
      workMinutes: 180,
      ordersPerThousandViews: 3.33,
      revenuePerThousandViewsMinor: 291666.67,
      revenuePerHourMinor: 116666.67,
      outputsPerWeek: 3,
      shipConsistency: 1,
    );
    final target = CycleReviewTarget(
      project: project,
      sprint: sprint,
      availability: CycleReviewAvailability.due,
    );
    final repository = FakeTrackerRepository(
      projects: [project, replacement, archived],
      latestSprint: sprint,
      cycleReviewTarget: target,
    );

    return _CycleFixture(
      project: project,
      replacement: replacement,
      archived: archived,
      sprint: sprint,
      summary: summary,
      repository: repository,
    );
  }

  final Project project;
  final Project replacement;
  final Project archived;
  final Sprint sprint;
  final ResultsSummary summary;
  final FakeTrackerRepository repository;
}
