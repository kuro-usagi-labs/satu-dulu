import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';
import 'package:satu_dulu/features/settings/presentation/controllers/settings_providers.dart';
import 'package:satu_dulu/features/settings/presentation/widgets/local_backup_section.dart';

class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({required this.preferences, super.key});

  final NotificationPreferences preferences;

  @override
  ConsumerState<NotificationSettings> createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<NotificationSettings> {
  late NotificationPreferences _value;
  bool _saving = false;
  String? _saveError;

  @override
  void initState() {
    super.initState();
    _value = widget.preferences;
  }

  @override
  void didUpdateWidget(covariant NotificationSettings oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_saving) _value = widget.preferences;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.generous,
            AppSpacing.section,
            AppSpacing.generous,
            AppSpacing.screen,
          ),
          children: [
            const AppEyebrow('Ritme, bukan tekanan'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Pengingat yang mengikuti harimu.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Pilih momen yang membantu kamu kembali. Semua pengingat tetap opsional.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            const AppNotice(
              icon: Icons.phonelink_lock_outlined,
              title: 'Tetap di perangkat ini',
              description:
                  'Jadwal dibuat lokal. Isi proyek, hasil, dan PDF tidak dikirim ke server.',
              background: AppColors.guideSoft,
              foreground: AppColors.guide,
            ),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Pengingat harian',
              description:
                  'Aktifkan hanya momen yang benar-benar berguna untuk ritmemu.',
            ),
            const SizedBox(height: AppSpacing.standard),
            Card(
              child: Column(
                children: [
                  _reminderTile(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Fokus pagi',
                    subtitle: 'Lihat satu hasil wajib sebelum hari ramai.',
                    enabled: _value.morningEnabled,
                    minutes: _value.morningMinutes,
                    onToggle: (enabled) => _toggle('morning', enabled),
                    onTime: () => _pickTime('morning'),
                  ),
                  const Divider(height: 1, indent: 64),
                  _reminderTile(
                    icon: Icons.work_outline_rounded,
                    title: 'Kembali setelah kerja',
                    subtitle: 'Ingat tindakan terkecil yang masih mungkin.',
                    enabled: _value.afterWorkEnabled,
                    minutes: _value.afterWorkMinutes,
                    onToggle: (enabled) => _toggle('afterWork', enabled),
                    onTime: () => _pickTime('afterWork'),
                  ),
                  const Divider(height: 1, indent: 64),
                  _reminderTile(
                    icon: Icons.nights_stay_outlined,
                    title: 'Cek Ship malam',
                    subtitle:
                        'Tutup hari dengan mencatat hasil penuh atau kecil.',
                    enabled: _value.eveningEnabled,
                    minutes: _value.eveningMinutes,
                    onToggle: (enabled) => _toggle('evening', enabled),
                    onTime: () => _pickTime('evening'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.major),
            const AppSectionHeader(
              title: 'Waktu lokal',
              description: 'Digunakan agar pengingat tidak bergeser jam.',
            ),
            const SizedBox(height: AppSpacing.standard),
            DropdownButtonFormField<String>(
              initialValue: _value.timeZoneId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Zona waktu',
                prefixIcon: Icon(Icons.public_rounded),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Asia/Jakarta',
                  child: Text('WIB · Jakarta'),
                ),
                DropdownMenuItem(
                  value: 'Asia/Makassar',
                  child: Text('WITA · Makassar'),
                ),
                DropdownMenuItem(
                  value: 'Asia/Jayapura',
                  child: Text('WIT · Jayapura'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _value = _value.copyWith(timeZoneId: value);
                    _saveError = null;
                  });
                }
              },
            ),
            const SizedBox(height: AppSpacing.screen),
            const AppSectionHeader(title: 'Data dan privasi'),
            const SizedBox(height: AppSpacing.standard),
            const _InformationRow(
              icon: Icons.storage_outlined,
              title: 'Penyimpanan lokal',
              description:
                  'Data proyek, hasil, dan PDF berada di perangkat ini.',
            ),
            const SizedBox(height: AppSpacing.standard),
            const _InformationRow(
              icon: Icons.visibility_off_outlined,
              title: 'Tanpa pelacakan pihak ketiga',
              description:
                  'Tidak ada akun, iklan, cloud sync, atau analytics eksternal.',
            ),
            const SizedBox(height: AppSpacing.major),
            const LocalBackupSection(),
            const SizedBox(height: AppSpacing.screen),
            const AppSectionHeader(title: 'Tentang Satu Dulu'),
            const SizedBox(height: AppSpacing.standard),
            const _InformationRow(
              icon: Icons.info_outline_rounded,
              title: 'Versi 1.0.1',
              description: 'com.kurogi.satudulu',
            ),
            if (_saveError case final error?) ...[
              const SizedBox(height: AppSpacing.section),
              AppNotice(
                icon: Icons.error_outline_rounded,
                title: 'Pengaturan belum tersimpan',
                description: error,
                background: AppColors.dangerSoft,
                foreground: AppColors.danger,
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: AppBottomActionBar(
        child: FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Menyimpan…' : 'Simpan pengaturan'),
        ),
      ),
    );
  }

  Widget _reminderTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool enabled,
    required int minutes,
    required ValueChanged<bool> onToggle,
    required VoidCallback onTime,
  }) {
    final time = TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.compact),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile.adaptive(
            value: enabled,
            onChanged: onToggle,
            secondary: Icon(
              icon,
              color: enabled ? AppColors.accentDeep : AppColors.textSecondary,
            ),
            title: Text(title),
            subtitle: Text(subtitle),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.standard,
            ),
          ),
          AnimatedSize(
            duration: reduceMotion ? Duration.zero : AppDuration.stateChange,
            alignment: Alignment.topLeft,
            child: enabled
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(
                      56,
                      0,
                      AppSpacing.standard,
                      AppSpacing.compact,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: onTime,
                        icon: const Icon(Icons.schedule_rounded),
                        label: Text('Pukul ${time.format(context)}'),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Future<void> _toggle(String kind, bool enabled) async {
    if (enabled && !_value.anyEnabled) {
      final explain = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.notifications_active_outlined),
          title: const Text('Izinkan pengingat lokal?'),
          content: const Text(
            'Satu Dulu akan meminta izin sistem. Jadwal dibuat di perangkat dan dapat dimatikan kapan saja.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Belum sekarang'),
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
            content: Text('Izin belum diberikan. Pengingat tetap nonaktif.'),
          ),
        );
        return;
      }
    }
    if (!mounted) return;
    setState(() {
      _value = switch (kind) {
        'morning' => _value.copyWith(morningEnabled: enabled),
        'afterWork' => _value.copyWith(afterWorkEnabled: enabled),
        _ => _value.copyWith(eveningEnabled: enabled),
      };
      _saveError = null;
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
      helpText: 'Pilih waktu pengingat',
    );
    if (time == null || !mounted) return;
    final minutes = time.hour * 60 + time.minute;
    setState(() {
      _value = switch (kind) {
        'morning' => _value.copyWith(morningMinutes: minutes),
        'afterWork' => _value.copyWith(afterWorkMinutes: minutes),
        _ => _value.copyWith(eveningMinutes: minutes),
      };
      _saveError = null;
    });
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      await ref.read(notificationPreferencesRepositoryProvider).save(_value);
      await ref.read(localNotificationServiceProvider).reschedule(_value);
      if (mounted) context.pop();
    } catch (_) {
      if (mounted) {
        setState(
          () => _saveError =
              'Perubahan belum dapat disimpan. Pilihanmu tetap ada di layar ini.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _InformationRow extends StatelessWidget {
  const _InformationRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIconBadge(
          icon: icon,
          foreground: AppColors.guide,
          background: AppColors.guideSoft,
          size: 44,
        ),
        const SizedBox(width: AppSpacing.innerCompact),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.micro),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
