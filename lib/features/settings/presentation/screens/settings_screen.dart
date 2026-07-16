import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';
import 'package:satu_dulu/features/settings/presentation/controllers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(notificationPreferencesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Pengaturan'),
      ),
      body: preferences.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) =>
            const Center(child: Text('Pengaturan belum dapat dimuat.')),
        data: (value) => _NotificationSettings(preferences: value),
      ),
    );
  }
}

class _NotificationSettings extends ConsumerStatefulWidget {
  const _NotificationSettings({required this.preferences});
  final NotificationPreferences preferences;

  @override
  ConsumerState<_NotificationSettings> createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<_NotificationSettings> {
  late NotificationPreferences _value;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _value = widget.preferences;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: [
        Card(
          color: AppColors.accentSoft,
          child: const Padding(
            padding: EdgeInsets.all(AppSpacing.standard),
            child: Text(
              'Reminder membantu kamu kembali ke satu fokus. Semuanya opsional, lokal, dan bisa dimatikan kapan saja.',
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        _reminderTile(
          title: 'Fokus pagi',
          subtitle: 'Lihat hasil wajib sebelum hari ramai.',
          enabled: _value.morningEnabled,
          minutes: _value.morningMinutes,
          onToggle: (enabled) => _toggle('morning', enabled),
          onTime: () => _pickTime('morning'),
        ),
        _reminderTile(
          title: 'Setelah kerja',
          subtitle: 'Kembali ke tindakan terkecil.',
          enabled: _value.afterWorkEnabled,
          minutes: _value.afterWorkMinutes,
          onToggle: (enabled) => _toggle('afterWork', enabled),
          onTime: () => _pickTime('afterWork'),
        ),
        _reminderTile(
          title: 'Cek Ship malam',
          subtitle: 'Catat hasil penuh atau parsial.',
          enabled: _value.eveningEnabled,
          minutes: _value.eveningMinutes,
          onToggle: (enabled) => _toggle('evening', enabled),
          onTime: () => _pickTime('evening'),
        ),
        const SizedBox(height: AppSpacing.standard),
        DropdownButtonFormField<String>(
          initialValue: _value.timeZoneId,
          decoration: const InputDecoration(labelText: 'Zona waktu'),
          items: const [
            DropdownMenuItem(value: 'Asia/Jakarta', child: Text('WIB')),
            DropdownMenuItem(value: 'Asia/Makassar', child: Text('WITA')),
            DropdownMenuItem(value: 'Asia/Jayapura', child: Text('WIT')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _value = _value.copyWith(timeZoneId: value));
            }
          },
        ),
        const SizedBox(height: AppSpacing.section),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Menyimpan…' : 'Simpan pengaturan'),
        ),
        const SizedBox(height: AppSpacing.section),
        const Divider(),
        const SizedBox(height: AppSpacing.standard),
        Text('Privasi', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.compact),
        const Text(
          'Data proyek, hasil, dan PDF tetap di perangkat. Tidak ada akun, cloud sync, iklan, atau analytics pihak ketiga.',
        ),
        const SizedBox(height: AppSpacing.section),
        Text('Tentang', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.compact),
        const Text('Satu Dulu 0.1.0 • com.kurogi.satudulu'),
      ],
    );
  }

  Widget _reminderTile({
    required String title,
    required String subtitle,
    required bool enabled,
    required int minutes,
    required ValueChanged<bool> onToggle,
    required VoidCallback onTime,
  }) {
    final time = TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.innerCompact),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.compact),
        child: Column(
          children: [
            SwitchListTile.adaptive(
              value: enabled,
              onChanged: onToggle,
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            if (enabled)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onTime,
                  icon: const Icon(Icons.schedule_rounded),
                  label: Text(time.format(context)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggle(String kind, bool enabled) async {
    if (enabled && !_value.anyEnabled) {
      final explain = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Aktifkan reminder?'),
          content: const Text(
            'Satu Dulu akan meminta izin sistem setelah ini. Isi reminder dibuat lokal dan tidak dikirim ke server.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Belum'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Lanjutkan'),
            ),
          ],
        ),
      );
      if (explain != true) return;
      final allowed = await ref
          .read(localNotificationServiceProvider)
          .requestPermission();
      if (!allowed && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Izin belum diberikan. Reminder tetap nonaktif.'),
          ),
        );
        return;
      }
    }
    setState(() {
      _value = switch (kind) {
        'morning' => _value.copyWith(morningEnabled: enabled),
        'afterWork' => _value.copyWith(afterWorkEnabled: enabled),
        _ => _value.copyWith(eveningEnabled: enabled),
      };
    });
  }

  Future<void> _pickTime(String kind) async {
    final current = switch (kind) {
      'morning' => _value.morningMinutes,
      'afterWork' => _value.afterWorkMinutes,
      _ => _value.eveningMinutes,
    };
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
    );
    if (time == null) return;
    final minutes = time.hour * 60 + time.minute;
    setState(() {
      _value = switch (kind) {
        'morning' => _value.copyWith(morningMinutes: minutes),
        'afterWork' => _value.copyWith(afterWorkMinutes: minutes),
        _ => _value.copyWith(eveningMinutes: minutes),
      };
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref.read(notificationPreferencesRepositoryProvider).save(_value);
    await ref.read(localNotificationServiceProvider).reschedule(_value);
    if (mounted) context.pop();
  }
}
