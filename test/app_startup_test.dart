import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

import 'fakes/fake_tracker_repository.dart';

void main() {
  testWidgets('first launch explains the one-focus promise', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackerRepositoryProvider.overrideWithValue(FakeTrackerRepository()),
        ],
        child: const SatuDuluApp(),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.text('Banyak ide boleh.\nHari ini tetap satu dulu.'),
    );

    expect(
      find.text('Banyak ide boleh.\nHari ini tetap satu dulu.'),
      findsOneWidget,
    );
    expect(find.text('Pilih fokus'), findsOneWidget);
  });
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
