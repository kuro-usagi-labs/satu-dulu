import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

import 'fakes/fake_tracker_repository.dart';

void main() {
  testWidgets(
    'four main spaces stay usable on a small iPhone with larger text',
    (tester) async {
      _useCompactViewport(tester);
      final fixture = _NavigationFixture.create();

      await _pumpApp(tester, fixture);
      await _pumpUntilFound(tester, find.text(fixture.today.requiredOutcome));

      expect(find.text(fixture.today.requiredOutcome), findsOneWidget);
      _expectNoLayoutException(tester, 'Hari Ini');

      await _openTab(tester, 'Proyek', find.text(fixture.maintenance.name));
      expect(find.text(fixture.focus.name), findsOneWidget);
      expect(find.text(fixture.maintenance.name), findsOneWidget);
      expect(find.text(fixture.parked.name), findsOneWidget);
      _expectNoLayoutException(tester, 'Proyek');

      await _openTab(tester, 'Panduan', find.text(fixture.guide.displayTitle));
      expect(find.text(fixture.guide.displayTitle), findsOneWidget);
      expect(find.text('Impor PDF panduan'), findsOneWidget);
      _expectNoLayoutException(tester, 'Panduan');

      await _openTab(tester, 'Hasil', find.text(fixture.metric.note!));
      expect(find.text('Bukti yang terkumpul'), findsOneWidget);
      expect(find.text(fixture.metric.note!), findsOneWidget);
      _expectNoLayoutException(tester, 'Hasil');

      await _openTab(
        tester,
        'Hari Ini',
        find.text(fixture.today.requiredOutcome),
      );
      expect(find.text(fixture.today.requiredOutcome), findsOneWidget);
      _expectNoLayoutException(tester, 'Hari Ini setelah kembali');
    },
  );

  testWidgets('unknown route offers a graceful return to Hari Ini', (
    tester,
  ) async {
    _useCompactViewport(tester);
    final fixture = _NavigationFixture.create();

    await _pumpApp(tester, fixture);
    await _pumpUntilFound(tester, find.text(fixture.today.requiredOutcome));

    final shellContext = tester.element(find.byType(NavigationBar));
    GoRouter.of(shellContext).go('/tautan-yang-tidak-ada');
    await _pumpUntilFound(tester, find.text('Halaman tidak ditemukan'));

    expect(find.text('Halaman tidak ditemukan'), findsOneWidget);
    expect(
      find.widgetWithText(FilledButton, 'Kembali ke Hari Ini'),
      findsOneWidget,
    );
    _expectNoLayoutException(tester, 'route error');

    await tester.tap(find.widgetWithText(FilledButton, 'Kembali ke Hari Ini'));
    await _pumpUntilFound(tester, find.text(fixture.today.requiredOutcome));

    expect(find.text(fixture.today.requiredOutcome), findsOneWidget);
    _expectNoLayoutException(tester, 'route recovery');
  });

  testWidgets('result routes reject blank project identifiers', (tester) async {
    _useCompactViewport(tester);
    final fixture = _NavigationFixture.create();

    await _pumpApp(tester, fixture);
    await _pumpUntilFound(tester, find.text(fixture.today.requiredOutcome));

    final router = GoRouter.of(tester.element(find.byType(NavigationBar)));
    router.go('/results/metric?project=%20%20');
    await _pumpUntilFound(tester, find.text('Proyek belum dipilih'));
    await tester.pumpAndSettle();
    expect(
      find.text('Buka Hasil lalu pilih proyek yang ingin diberi bukti.'),
      findsOneWidget,
    );
    _expectNoLayoutException(tester, 'blank metric project');

    router.go('/results/review?project=');
    await _pumpUntilFound(
      tester,
      find.text('Buka Hasil lalu pilih proyek yang ingin direview.'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Proyek belum dipilih'), findsOneWidget);
    _expectNoLayoutException(tester, 'blank review project');
  });
}

Future<void> _pumpApp(WidgetTester tester, _NavigationFixture fixture) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        trackerRepositoryProvider.overrideWithValue(
          FakeTrackerRepository(
            projects: fixture.projects,
            today: fixture.today,
          ),
        ),
        guideDocumentsProvider.overrideWith(
          (ref) => Stream.value([fixture.guide]),
        ),
        resultsSummaryProvider.overrideWith(
          (ref, projectId) => Stream.value(
            projectId == fixture.focus.id ? fixture.summary : _emptySummary,
          ),
        ),
        weeklyReviewsProvider.overrideWith(
          (ref, projectId) => Stream.value(
            projectId == fixture.focus.id ? [fixture.review] : const [],
          ),
        ),
      ],
      child: const SatuDuluApp(),
    ),
  );
}

Future<void> _openTab(
  WidgetTester tester,
  String label,
  Finder destinationContent,
) async {
  final destination = find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text(label),
  );
  expect(destination, findsOneWidget);

  await tester.tap(destination);
  await _pumpUntilFound(tester, destinationContent);
  await tester.pump(const Duration(milliseconds: 400));
}

void _useCompactViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 640);
  tester.platformDispatcher.textScaleFactorTestValue = 1.3;

  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

void _expectNoLayoutException(WidgetTester tester, String screen) {
  final exception = tester.takeException();
  expect(
    exception,
    isNull,
    reason: '$screen harus bebas overflow pada viewport 320x640 dan teks 1.3x.',
  );
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 40 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  expect(finder, findsWidgets);
}

class _NavigationFixture {
  const _NavigationFixture({
    required this.focus,
    required this.maintenance,
    required this.parked,
    required this.today,
    required this.guide,
    required this.metric,
    required this.summary,
    required this.review,
  });

  factory _NavigationFixture.create() {
    final now = DateTime.now().toUtc();
    final focus = Project(
      id: 'focus-project',
      name: 'Studio Konten Flutter',
      shortGoal: 'Menguji seri tutorial singkat untuk pemula',
      whyChosen: 'Paling dekat dengan calon pengguna yang sudah menunggu',
      successDefinition: 'Terbitkan 12 video dan ukur respons nyata',
      status: ProjectStatus.focus,
      startDate: now.subtract(const Duration(days: 8)),
      reviewDate: now.add(const Duration(days: 21)),
      primaryGuideDocumentId: 'guide-launch',
      createdAt: now.subtract(const Duration(days: 14)),
      updatedAt: now,
    );
    final maintenance = Project(
      id: 'maintenance-project',
      name: 'Newsletter Mingguan',
      shortGoal: 'Tetap menyapa pembaca lama setiap Jumat',
      status: ProjectStatus.maintenance,
      startDate: now.subtract(const Duration(days: 60)),
      reviewDate: now.add(const Duration(days: 7)),
      createdAt: now.subtract(const Duration(days: 80)),
      updatedAt: now,
    );
    final parked = Project(
      id: 'parked-project',
      name: 'Kelas Dart Lanjutan',
      shortGoal: 'Simpan riset kelas sampai eksperimen utama selesai',
      status: ProjectStatus.parkingLot,
      createdAt: now.subtract(const Duration(days: 5)),
      updatedAt: now,
    );
    final today = TodayOverview(
      project: focus,
      sprint: Sprint(
        id: 'sprint-focus',
        projectId: focus.id,
        name: 'Validasi seri tutorial',
        hypothesis: 'Tutorial singkat membantu pemula mulai lebih cepat',
        startDate: now.subtract(const Duration(days: 8)),
        endDate: now.add(const Duration(days: 21)),
        targetOutputs: 12,
        successCriteria: 'Tiga percakapan bermakna dari calon pengguna',
        status: SprintStatus.active,
      ),
      dailyPlanId: 'plan-today',
      planDate: now,
      requiredOutcome: 'Terbitkan tutorial navigasi pertama',
      lowEnergyAction: 'Tulis pembuka dan satu contoh kode',
      linkedGuideDocumentId: 'guide-launch',
      linkedGuidePage: 7,
      actions: const [
        DailyAction(
          id: 'action-script',
          position: 0,
          label: 'Rapikan skrip satu menit',
          isCompleted: true,
        ),
        DailyAction(
          id: 'action-record',
          position: 1,
          label: 'Rekam contoh navigasi',
          isCompleted: false,
        ),
        DailyAction(
          id: 'action-publish',
          position: 2,
          label: 'Terbitkan dan simpan tautan',
          isCompleted: false,
        ),
      ],
    );
    final guide = GuideDocument(
      id: 'guide-launch',
      originalFileName: 'launch-checklist.pdf',
      displayTitle: 'Checklist sebelum menerbitkan tutorial',
      storedRelativePath: 'guides/guide-launch.pdf',
      fileSizeBytes: 824000,
      projectId: focus.id,
      projectName: focus.name,
      category: 'Produksi',
      description: 'Urutan singkat untuk mengecek materi sebelum terbit.',
      whenToRead: 'Saat bingung apakah video sudah cukup jelas.',
      isPinned: true,
      pageCount: 24,
      lastReadPage: 7,
      lastOpenedAt: now.subtract(const Duration(days: 1)),
      importedAt: now.subtract(const Duration(days: 10)),
      updatedAt: now.subtract(const Duration(days: 1)),
    );
    final metric = MetricEntry(
      id: 'metric-today',
      projectId: focus.id,
      entryDate: now.subtract(const Duration(days: 1)),
      outputsCount: 1,
      views: 248,
      clicks: 31,
      orders: 2,
      revenueMinor: 350000,
      workMinutes: 95,
      note: 'Contoh konkret paling banyak memancing pertanyaan.',
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now.subtract(const Duration(days: 1)),
    );
    final summary = ResultsSummary(
      entries: [metric],
      outputs: 5,
      views: 940,
      clicks: 86,
      orders: 6,
      revenueMinor: 875000,
      workMinutes: 420,
      ordersPerThousandViews: 6.38,
      revenuePerThousandViewsMinor: 930851.06,
      revenuePerHourMinor: 125000,
      outputsPerWeek: 3.5,
      shipConsistency: 0.71,
    );
    final review = WeeklyReview(
      id: 'review-week-one',
      projectId: focus.id,
      sprintId: 'sprint-focus',
      weekStart: now.subtract(const Duration(days: 7)),
      weekEnd: now.subtract(const Duration(days: 1)),
      shippedSummary: 'Lima tutorial singkat berhasil diterbitkan.',
      importantResult: 'Contoh navigasi menghasilkan pertanyaan paling tajam.',
      workedWell: 'Menulis contoh sebelum merekam.',
      wasteOrBlocker: 'Terlalu lama memilih ilustrasi sampul.',
      decision: ReviewDecision.continueFocus,
      nextWeekFocus: 'Terbitkan tiga contoh navigasi berbasis kasus nyata.',
      createdAt: now.subtract(const Duration(days: 1)),
      updatedAt: now.subtract(const Duration(days: 1)),
    );

    return _NavigationFixture(
      focus: focus,
      maintenance: maintenance,
      parked: parked,
      today: today,
      guide: guide,
      metric: metric,
      summary: summary,
      review: review,
    );
  }

  final Project focus;
  final Project maintenance;
  final Project parked;
  final TodayOverview today;
  final GuideDocument guide;
  final MetricEntry metric;
  final ResultsSummary summary;
  final WeeklyReview review;

  List<Project> get projects => [focus, maintenance, parked];
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
