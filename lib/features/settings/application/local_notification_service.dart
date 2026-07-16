import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized || kIsWeb) return;
    tz_data.initializeTimeZones();
    const ios = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(settings: const InitializationSettings(iOS: ios));
    _initialized = true;
  }

  Future<bool> requestPermission() async {
    if (kIsWeb) return false;
    await initialize();
    return await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: false, sound: true) ??
        false;
  }

  Future<void> reschedule(NotificationPreferences preferences) async {
    if (kIsWeb) return;
    await initialize();
    await _plugin.cancelAll();
    tz.setLocalLocation(tz.getLocation(preferences.timeZoneId));
    if (preferences.morningEnabled) {
      await _schedule(
        101,
        preferences.morningMinutes,
        'Satu fokus pagi ini',
        'Buka hasil wajib hari ini sebelum hari menjadi ramai.',
      );
    }
    if (preferences.afterWorkEnabled) {
      await _schedule(
        102,
        preferences.afterWorkMinutes,
        'Kembali ke tindakan terkecil',
        'Satu langkah kecil masih cukup untuk menjaga arah.',
      );
    }
    if (preferences.eveningEnabled) {
      await _schedule(
        103,
        preferences.eveningMinutes,
        'Sudah Ship Hari Ini?',
        'Catat hasil penuh atau parsial tanpa menghakimi harimu.',
      );
    }
  }

  Future<void> _schedule(int id, int minutes, String title, String body) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      minutes ~/ 60,
      minutes % 60,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
