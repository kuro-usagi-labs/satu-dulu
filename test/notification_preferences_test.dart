import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart'
    hide NotificationPreferences;
import 'package:satu_dulu/features/settings/data/notification_preferences_repository.dart';
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';

void main() {
  late AppDatabase database;
  late NotificationPreferencesRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = NotificationPreferencesRepository(database);
  });

  tearDown(() => database.close());

  test('defaults keep every reminder opt-in', () async {
    final preferences = await repository.load();
    expect(preferences.anyEnabled, isFalse);
    expect(preferences.timeZoneId, 'Asia/Jakarta');
  });

  test('preferences persist times and timezone in one settings row', () async {
    const preferences = NotificationPreferences(
      morningEnabled: true,
      afterWorkEnabled: false,
      eveningEnabled: true,
      morningMinutes: 450,
      afterWorkMinutes: 1020,
      eveningMinutes: 1290,
      timeZoneId: 'Asia/Makassar',
    );
    await repository.save(preferences);

    final restored = await repository.load();
    expect(restored.morningEnabled, isTrue);
    expect(restored.eveningMinutes, 1290);
    expect(restored.timeZoneId, 'Asia/Makassar');
  });
}
