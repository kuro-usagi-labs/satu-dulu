import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart'
    hide NotificationPreferences;
import 'package:satu_dulu/features/settings/application/local_notification_service.dart';
import 'package:satu_dulu/features/settings/data/notification_preferences_repository.dart';
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';

final notificationPreferencesRepositoryProvider =
    Provider<NotificationPreferencesRepository>((ref) {
      return NotificationPreferencesRepository(ref.watch(appDatabaseProvider));
    });

final localNotificationServiceProvider = Provider<LocalNotificationService>((
  ref,
) {
  return LocalNotificationService();
});

final notificationPreferencesProvider = StreamProvider<NotificationPreferences>(
  (ref) {
    return ref.watch(notificationPreferencesRepositoryProvider).watch();
  },
);
