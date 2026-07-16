import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart'
    hide NotificationPreferences;
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';

class NotificationPreferencesRepository {
  NotificationPreferencesRepository(this._database);

  final AppDatabase _database;

  Stream<NotificationPreferences> watch() {
    return (_database.select(
      _database.notificationPreferences,
    )..where((table) => table.id.equals(1))).watchSingleOrNull().map(
      (row) => row == null ? NotificationPreferences.defaults : _map(row),
    );
  }

  Future<NotificationPreferences> load() async {
    final row = await (_database.select(
      _database.notificationPreferences,
    )..where((table) => table.id.equals(1))).getSingleOrNull();
    return row == null ? NotificationPreferences.defaults : _map(row);
  }

  Future<void> save(NotificationPreferences value) {
    return _database
        .into(_database.notificationPreferences)
        .insertOnConflictUpdate(
          NotificationPreferencesCompanion.insert(
            id: const Value(1),
            morningEnabled: Value(value.morningEnabled),
            afterWorkEnabled: Value(value.afterWorkEnabled),
            eveningEnabled: Value(value.eveningEnabled),
            morningMinutes: Value(value.morningMinutes),
            afterWorkMinutes: Value(value.afterWorkMinutes),
            eveningMinutes: Value(value.eveningMinutes),
            timeZoneId: Value(value.timeZoneId),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  NotificationPreferences _map(NotificationPreferenceRow row) {
    return NotificationPreferences(
      morningEnabled: row.morningEnabled,
      afterWorkEnabled: row.afterWorkEnabled,
      eveningEnabled: row.eveningEnabled,
      morningMinutes: row.morningMinutes,
      afterWorkMinutes: row.afterWorkMinutes,
      eveningMinutes: row.eveningMinutes,
      timeZoneId: row.timeZoneId,
    );
  }
}
