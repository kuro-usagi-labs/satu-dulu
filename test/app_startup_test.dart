import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

import 'fakes/fake_tracker_repository.dart';

void main() {
  testWidgets('first launch explains the workflow and all four spaces', (
    tester,
  ) async {
    await _pumpApp(tester, FakeTrackerRepository());
    await _pumpUntilFound(
      tester,
      find.text('Banyak ide boleh.\nHari ini tetap satu dulu.'),
    );

    expect(find.text('1 dari 3'), findsOneWidget);
    expect(
      find.text('Banyak ide boleh.\nHari ini tetap satu dulu.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('2 dari 3'), findsOneWidget);
    expect(find.text('Pilih satu fokus'), findsOneWidget);
    expect(find.text('Kerjakan langkah berikutnya'), findsOneWidget);
    expect(find.text('Ship dan lihat bukti'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('3 dari 3'), findsOneWidget);
    expect(find.text('Hari Ini'), findsOneWidget);
    expect(find.text('Proyek'), findsOneWidget);
    expect(find.text('Panduan'), findsOneWidget);
    expect(find.text('Hasil'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Pilih fokus'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Pilih fokus'));
    await tester.pumpAndSettle();

    expect(find.text('Siapkan fokusmu'), findsOneWidget);
  });

  testWidgets('existing user bypasses onboarding and opens Today', (
    tester,
  ) async {
    final now = DateTime.now().toUtc();
    final project = Project(
      id: 'project-existing',
      name: 'Fokus berjalan',
      shortGoal: 'Selesaikan eksperimen',
      status: ProjectStatus.focus,
      startDate: now,
      reviewDate: now.add(const Duration(days: 29)),
      createdAt: now,
      updatedAt: now,
    );

    await _pumpApp(tester, FakeTrackerRepository(projects: [project]));
    await _pumpUntilFound(tester, find.text('Hari ini belum punya hasil'));

    expect(find.text('Hari ini belum punya hasil'), findsOneWidget);
    expect(find.text('1 dari 3'), findsNothing);
  });

  testWidgets('onboarding has no overflow at 320px with larger text', (
    tester,
  ) async {
    _useCompactViewport(tester);
    await _pumpApp(tester, FakeTrackerRepository());
    await _pumpUntilFound(tester, find.text('1 dari 3'));

    expect(tester.takeException(), isNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Lanjut'));
    await tester.pumpAndSettle();
    expect(find.text('2 dari 3'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Lanjut'));
    await tester.pumpAndSettle();
    expect(find.text('3 dari 3'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Pilih fokus'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('three-step focus setup stays usable on a compact iPhone', (
    tester,
  ) async {
    _useCompactViewport(tester);
    await _pumpApp(tester, FakeTrackerRepository());
    await _pumpUntilFound(tester, find.text('Langsung pilih fokus'));

    await tester.tap(find.text('Langsung pilih fokus'));
    await tester.pumpAndSettle();

    expect(find.text('Langkah 1 dari 3'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.enterText(find.byType(TextFormField).at(0), 'Studio Flutter');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Menguji tutorial singkat',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('Langkah 2 dari 3'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Terbitkan tutorial pertama',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Lanjut'));
    await tester.pumpAndSettle();

    expect(find.text('Langkah 3 dari 3'), findsOneWidget);
    expect(find.text('Mulai dari sini'), findsOneWidget);
    expect(find.text('Mulai 30 hari'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpApp(WidgetTester tester, FakeTrackerRepository repository) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [trackerRepositoryProvider.overrideWithValue(repository)],
      child: const SatuDuluApp(),
    ),
  );
}

void _useCompactViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 640);
  tester.platformDispatcher.textScaleFactorTestValue = 1.3;

  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
