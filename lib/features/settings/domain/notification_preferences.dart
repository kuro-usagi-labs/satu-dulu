class NotificationPreferences {
  const NotificationPreferences({
    required this.morningEnabled,
    required this.afterWorkEnabled,
    required this.eveningEnabled,
    required this.morningMinutes,
    required this.afterWorkMinutes,
    required this.eveningMinutes,
    required this.timeZoneId,
  });

  final bool morningEnabled;
  final bool afterWorkEnabled;
  final bool eveningEnabled;
  final int morningMinutes;
  final int afterWorkMinutes;
  final int eveningMinutes;
  final String timeZoneId;

  static const defaults = NotificationPreferences(
    morningEnabled: false,
    afterWorkEnabled: false,
    eveningEnabled: false,
    morningMinutes: 8 * 60,
    afterWorkMinutes: 17 * 60,
    eveningMinutes: 21 * 60,
    timeZoneId: 'Asia/Jakarta',
  );

  bool get anyEnabled => morningEnabled || afterWorkEnabled || eveningEnabled;

  NotificationPreferences copyWith({
    bool? morningEnabled,
    bool? afterWorkEnabled,
    bool? eveningEnabled,
    int? morningMinutes,
    int? afterWorkMinutes,
    int? eveningMinutes,
    String? timeZoneId,
  }) => NotificationPreferences(
    morningEnabled: morningEnabled ?? this.morningEnabled,
    afterWorkEnabled: afterWorkEnabled ?? this.afterWorkEnabled,
    eveningEnabled: eveningEnabled ?? this.eveningEnabled,
    morningMinutes: morningMinutes ?? this.morningMinutes,
    afterWorkMinutes: afterWorkMinutes ?? this.afterWorkMinutes,
    eveningMinutes: eveningMinutes ?? this.eveningMinutes,
    timeZoneId: timeZoneId ?? this.timeZoneId,
  );
}
