import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/one_focus_sticker.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/widgets/project_overview_widgets.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/presentation/widgets/evidence_sparkline.dart';
import 'package:satu_dulu/features/results/presentation/widgets/results_decision_section.dart';
import 'package:satu_dulu/features/results/presentation/widgets/results_story.dart';

void main() {
  setUpAll(() => initializeDateFormatting('id_ID'));

  test('semantic palette keeps text contrast at WCAG AA', () {
    final textPairs = <(Color, Color)>[
      (AppColors.onAction, AppColors.action),
      (AppColors.textPrimary, AppColors.canvas),
      (AppColors.textSecondary, AppColors.canvas),
      (AppColors.guide, AppColors.surface),
      (AppColors.success, AppColors.successSoft),
      (AppColors.parking, AppColors.parkingSoft),
      (AppColors.onEvidence, AppColors.evidence),
      (AppColors.actionDeep, AppColors.surface),
      (AppColors.actionDeep, AppColors.actionSoft),
      (AppColors.action, AppColors.evidence),
      (AppColors.evidenceMuted, AppColors.evidence),
    ];

    for (final (foreground, background) in textPairs) {
      expect(
        _contrast(foreground, background),
        greaterThanOrEqualTo(4.5),
        reason:
            '${foreground.toARGB32().toRadixString(16)} on '
            '${background.toARGB32().toRadixString(16)} must remain readable.',
      );
    }
    expect(
      _contrast(AppColors.controlBorder, AppColors.surface),
      greaterThanOrEqualTo(3),
    );
    expect(
      _contrast(AppColors.actionDeep, AppColors.actionSoft),
      greaterThanOrEqualTo(3),
      reason: 'Selected focus borders must remain visibly distinct.',
    );
  });

  test('motion and core controls stay inside product guardrails', () {
    expect(AppDuration.tap.inMilliseconds, inInclusiveRange(120, 200));
    expect(AppDuration.card.inMilliseconds, inInclusiveRange(200, 300));

    final theme = AppTheme.light();
    final filledMinimum = theme.filledButtonTheme.style?.minimumSize?.resolve(
      const <WidgetState>{},
    );
    final iconMinimum = theme.iconButtonTheme.style?.minimumSize?.resolve(
      const <WidgetState>{},
    );
    expect(filledMinimum?.height, greaterThanOrEqualTo(44));
    expect(iconMinimum?.height, greaterThanOrEqualTo(44));
    expect(iconMinimum?.width, greaterThanOrEqualTo(44));
  });

  testWidgets('Hasil keeps one dark evidence card at compact Dynamic Type', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final now = DateTime.utc(2026, 7, 17);
    final project = Project(
      id: 'project-1',
      name: 'Membangun TikTok Shop',
      shortGoal: 'Validasi satu produk',
      status: ProjectStatus.focus,
      createdAt: now,
      updatedAt: now,
    );
    final entries = List.generate(
      7,
      (index) => MetricEntry(
        id: 'metric-$index',
        projectId: project.id,
        entryDate: now.subtract(Duration(days: index)),
        outputsCount: index.isEven ? 1 : 2,
        views: 30 + index,
        clicks: 5 + index,
        orders: index % 2,
        revenueMinor: 5000000,
        workMinutes: 20,
        note: index == 0 ? 'Video demo mendapat klik paling banyak.' : null,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final summary = ResultsSummary(
      entries: entries,
      outputs: 10,
      views: 231,
      clicks: 56,
      orders: 3,
      revenueMinor: 35000000,
      workMinutes: 140,
      ordersPerThousandViews: 12.9,
      revenuePerThousandViewsMinor: 151515,
      revenuePerHourMinor: 15000000,
      outputsPerWeek: 5,
      shipConsistency: 0.71,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.generous),
              child: ResultsStory(
                projectId: project.id,
                summary: summary,
                reviews: const AsyncData<List<WeeklyReview>>([]),
                projects: [project],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AppEvidenceCard), findsOneWidget);
    expect(find.byType(EvidenceSparkline), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty state stays compact at small iPhone width', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    tester.platformDispatcher.textScaleFactorTestValue = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppSpacing.generous),
            child: Align(
              alignment: Alignment.topCenter,
              child: EmptyStateCard(
                icon: Icons.fact_check_outlined,
                title: 'Belum ada hasil tercatat',
                description:
                    'Catat angka yang kamu tahu. Tidak perlu menunggu hasil besar.',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final emptyState = find.byType(EmptyStateCard);
    final normalHeight = tester.getSize(emptyState).height;
    expect(normalHeight, lessThan(200));

    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    await tester.pumpAndSettle();
    final largerTextHeight = tester.getSize(emptyState).height;
    expect(largerTextHeight, greaterThan(normalHeight));
    expect(largerTextHeight, lessThan(360));
    expect(tester.takeException(), isNull);
  });

  testWidgets('vector sticker settles immediately with Reduce Motion', (
    tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: Center(child: OneFocusSticker())),
      ),
    );
    await tester.pump();

    expect(find.byType(OneFocusSticker), findsOneWidget);
    final animation = tester.widget<TweenAnimationBuilder<double>>(
      find.byType(TweenAnimationBuilder<double>),
    );
    expect(animation.duration, Duration.zero);
    expect(tester.takeException(), isNull);
  });

  testWidgets('project status hierarchy survives compact Dynamic Type', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final now = DateTime.utc(2026, 7, 17);
    Project project(String id, String name, ProjectStatus status) => Project(
      id: id,
      name: name,
      shortGoal: 'Tujuan panjang yang tetap harus terbaca dengan nyaman',
      status: status,
      startDate: now,
      reviewDate: now.add(const Duration(days: 29)),
      createdAt: now,
      updatedAt: now,
    );
    final focus = project(
      'focus',
      'Membangun TikTok Shop',
      ProjectStatus.focus,
    );
    final maintenance = project(
      'maintenance',
      'Membangun YouTube Channel',
      ProjectStatus.maintenance,
    );
    final parked = project(
      'parking',
      'Berjualan PDF Digital',
      ProjectStatus.parkingLot,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.generous),
            child: Column(
              children: [
                FocusProjectCard(project: focus),
                const SizedBox(height: AppSpacing.standard),
                ProjectOverviewRow(project: maintenance),
                const SizedBox(height: AppSpacing.standard),
                ProjectOverviewRow(project: parked, quiet: true),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Fokus utama'), findsOneWidget);
    expect(find.text('Tetap dijaga'), findsOneWidget);
    expect(find.text('Disimpan dulu'), findsOneWidget);
    expect(
      tester
          .widgetList<AppStatusPill>(find.byType(AppStatusPill))
          .map((pill) => pill.tone),
      containsAll(<AppStatusTone>[
        AppStatusTone.focus,
        AppStatusTone.maintenance,
        AppStatusTone.parking,
      ]),
    );
    final rowColors = tester
        .widgetList<Ink>(find.byType(Ink))
        .map((ink) => ink.decoration)
        .whereType<BoxDecoration>()
        .map((decoration) => decoration.color);
    expect(rowColors, contains(AppColors.maintenanceSoft));
    expect(rowColors, contains(AppColors.parkingSoft));
    expect(tester.takeException(), isNull);
  });

  testWidgets('saved review uses the near-black decision surface', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 7, 17);
    final review = WeeklyReview(
      id: 'review-1',
      projectId: 'project-1',
      weekStart: now.subtract(const Duration(days: 7)),
      weekEnd: now,
      decision: ReviewDecision.continueFocus,
      importantResult: 'Video pertama menghasilkan percakapan nyata.',
      nextWeekFocus: 'Uji tiga pembuka video.',
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: ResultsDecisionSection(
            projectId: 'project-1',
            reviews: AsyncValue.data([review]),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AppEvidenceCard), findsOneWidget);
    expect(find.text('Lanjutkan arah ini'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

double _contrast(Color first, Color second) {
  final high = math.max(_luminance(first), _luminance(second));
  final low = math.min(_luminance(first), _luminance(second));
  return (high + 0.05) / (low + 0.05);
}

double _luminance(Color color) {
  final value = color.toARGB32();
  final red = (value >> 16) & 0xff;
  final green = (value >> 8) & 0xff;
  final blue = value & 0xff;

  double linear(int component) {
    final channel = component / 255;
    return channel <= 0.04045
        ? channel / 12.92
        : math.pow((channel + 0.055) / 1.055, 2.4).toDouble();
  }

  return 0.2126 * linear(red) + 0.7152 * linear(green) + 0.0722 * linear(blue);
}
