import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class DailyCheckInScreen extends ConsumerStatefulWidget {
  const DailyCheckInScreen({super.key});

  @override
  ConsumerState<DailyCheckInScreen> createState() => _DailyCheckInScreenState();
}

class _DailyCheckInScreenState extends ConsumerState<DailyCheckInScreen> {
  final _noteController = TextEditingController();
  EnergyLevel _energy = EnergyLevel.normal;
  int _minutes = 30;
  bool _loaded = false;
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final existing = ref.watch(dailyCheckInProvider(today));
    existing.whenData((value) {
      if (_loaded || value == null) return;
      _loaded = true;
      _energy = value.energyLevel;
      _minutes = value.availableMinutes;
      _noteController.text = value.note ?? '';
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Check-in hari ini'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.standard,
          AppSpacing.generous,
          AppSpacing.screen,
        ),
        children: [
          const AppEyebrow('Realistis sebelum produktif'),
          const SizedBox(height: AppSpacing.compact),
          Text(
            'Berapa kapasitasmu hari ini?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.compact),
          Text(
            'Jawaban ini tidak menilai harimu. Satu Dulu memakainya untuk mengecilkan rencana saat perlu.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.major),
          const AppSectionHeader(
            title: 'Energi',
            description: 'Pilih keadaan yang paling mendekati, bukan yang ideal.',
          ),
          const SizedBox(height: AppSpacing.standard),
          SegmentedButton<EnergyLevel>(
            segments: const [
              ButtonSegment(
                value: EnergyLevel.low,
                icon: Icon(Icons.battery_1_bar_rounded),
                label: Text('Rendah'),
              ),
              ButtonSegment(
                value: EnergyLevel.normal,
                icon: Icon(Icons.battery_4_bar_rounded),
                label: Text('Normal'),
              ),
              ButtonSegment(
                value: EnergyLevel.high,
                icon: Icon(Icons.battery_full_rounded),
                label: Text('Tinggi'),
              ),
            ],
            selected: {_energy},
            onSelectionChanged: (value) => setState(() => _energy = value.first),
          ),
          const SizedBox(height: AppSpacing.major),
          const AppSectionHeader(
            title: 'Waktu yang benar-benar tersedia',
            description: 'Pilih waktu fokus, bukan seluruh waktu luang.',
          ),
          const SizedBox(height: AppSpacing.standard),
          Wrap(
            spacing: AppSpacing.compact,
            runSpacing: AppSpacing.compact,
            children: [
              for (final option in const [10, 30, 60, 120])
                ChoiceChip(
                  selected: _minutes == option,
                  onSelected: (_) => setState(() => _minutes = option),
                  avatar: Icon(
                    option <= 30
                        ? Icons.timer_outlined
                        : Icons.schedule_rounded,
                    size: 18,
                  ),
                  label: Text(_timeLabel(option)),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.major),
          TextField(
            controller: _noteController,
            minLines: 2,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Konteks singkat (opsional)',
              hintText: 'Contoh: habis kerja dan kepala agak penuh',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          AppNotice(
            icon: _energy == EnergyLevel.low
                ? Icons.spa_outlined
                : Icons.adjust_rounded,
            title: _recommendationTitle,
            description: _recommendationDescription,
            background: _energy == EnergyLevel.low
                ? AppColors.warningSoft
                : AppColors.accentSoft,
            foreground: _energy == EnergyLevel.low
                ? AppColors.warning
                : AppColors.accentDeep,
          ),
        ],
      ),
      bottomNavigationBar: AppBottomActionBar(
        child: FilledButton.icon(
          onPressed: _saving ? null : _save,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.textInverse,
                  ),
                )
              : const Icon(Icons.check_rounded),
          label: Text(_saving ? 'Menyimpan…' : 'Gunakan kapasitas ini'),
        ),
      ),
    );
  }

  String _timeLabel(int minutes) => switch (minutes) {
    10 => '10 menit',
    30 => '30 menit',
    60 => '1 jam',
    _ => '2+ jam',
  };

  String get _recommendationTitle {
    if (_energy == EnergyLevel.low || _minutes <= 10) {
      return 'Hari ini cukup menjaga arah';
    }
    if (_energy == EnergyLevel.high && _minutes >= 60) {
      return 'Kapasitasmu cukup untuk outcome penuh';
    }
    return 'Satu output kecil masih realistis';
  }

  String get _recommendationDescription {
    if (_energy == EnergyLevel.low || _minutes <= 10) {
      return 'Gunakan satu tindakan terkecil. Tidak perlu membuat strategi baru atau mengejar semua yang tertunda.';
    }
    if (_energy == EnergyLevel.high && _minutes >= 60) {
      return 'Tetap batasi rencana menjadi maksimal tiga langkah agar hasil benar-benar dikirim.';
    }
    return 'Pilih hasil yang dapat selesai dalam satu sesi, lalu Ship sebelum menambah pekerjaan lain.';
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref.read(antiForgetRepositoryProvider).saveDailyCheckIn(
            DailyCheckInInput(
              checkInDate: DateTime.now(),
              energyLevel: _energy,
              availableMinutes: _minutes,
              note: _noteController.text,
            ),
          );
      ref.invalidate(dailyCheckInProvider);
      ref.invalidate(antiForgetTodaySupportProvider);
      ref.invalidate(todayProvider);
      if (mounted) context.pop();
    } on AppException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
