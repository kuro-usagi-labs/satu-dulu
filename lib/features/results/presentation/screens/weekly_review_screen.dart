import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';

class WeeklyReviewScreen extends ConsumerStatefulWidget {
  const WeeklyReviewScreen({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends ConsumerState<WeeklyReviewScreen> {
  final _shipped = TextEditingController();
  final _important = TextEditingController();
  final _worked = TextEditingController();
  final _waste = TextEditingController();
  final _next = TextEditingController();
  ReviewDecision _decision = ReviewDecision.continueFocus;
  late final DateTime _weekStart;
  bool _saving = false;
  String? _saveError;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _weekStart = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
  }

  @override
  void dispose() {
    for (final controller in [_shipped, _important, _worked, _waste, _next]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectName = _projectName();
    final weekEnd = _weekStart.add(const Duration(days: 6));
    final dateLabel =
        '${DateFormat('d MMM', 'id_ID').format(_weekStart)} – '
        '${DateFormat('d MMM y', 'id_ID').format(weekEnd)}';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Tinjau minggu ini'),
      ),
      body: SafeArea(
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
            const AppEyebrow('Refleksi mingguan'),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Lihat bukti, lalu pilih arah.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              '$projectName · $dateLabel',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            const AppNotice(
              icon: Icons.balance_outlined,
              title: 'Keputusan ini akan benar-benar diterapkan',
              description:
                  'Kamu tetap melihat ringkasan efeknya sebelum sprint atau status proyek berubah.',
            ),
            const SizedBox(height: AppSpacing.major),
            _ReviewPrompt(
              number: 1,
              title: 'Apa yang benar-benar dikirim?',
              hint: 'Contoh: 3 video pendek dan 1 halaman penjualan.',
              controller: _shipped,
            ),
            _ReviewPrompt(
              number: 2,
              title: 'Hasil mana yang paling berarti?',
              hint:
                  'Angka, tanggapan, atau perubahan kecil yang layak dicatat.',
              controller: _important,
            ),
            _ReviewPrompt(
              number: 3,
              title: 'Apa yang layak diulang?',
              hint: 'Cara kerja, format, waktu, atau keputusan yang membantu.',
              controller: _worked,
            ),
            _ReviewPrompt(
              number: 4,
              title: 'Apa yang menghabiskan energi?',
              hint: 'Catat hambatan tanpa menyalahkan diri sendiri.',
              controller: _waste,
            ),
            const AppSectionHeader(
              title: 'Pilih arah berikutnya',
              description:
                  'Satu pilihan akan memperbarui sprint, status, dan Restart Capsule secara atomik.',
            ),
            const SizedBox(height: AppSpacing.standard),
            _DecisionOption(
              icon: Icons.arrow_forward_rounded,
              title: 'Lanjutkan arah ini',
              description:
                  'Jaga fokus. Sprint baru dibuat hanya bila putaran sekarang hampir selesai.',
              selected: _decision == ReviewDecision.continueFocus,
              onTap: () => _selectDecision(ReviewDecision.continueFocus),
            ),
            const SizedBox(height: AppSpacing.compact),
            _DecisionOption(
              icon: Icons.alt_route_rounded,
              title: 'Ubah pendekatan',
              description:
                  'Tutup sprint lama dan mulai eksperimen 30 hari dengan cara baru.',
              selected: _decision == ReviewDecision.pivot,
              onTap: () => _selectDecision(ReviewDecision.pivot),
            ),
            const SizedBox(height: AppSpacing.compact),
            _DecisionOption(
              icon: Icons.inventory_2_outlined,
              title: 'Simpan dulu',
              description:
                  'Pindahkan proyek ke Parking Lot dan simpan konteks untuk kembali.',
              selected: _decision == ReviewDecision.park,
              onTap: () => _selectDecision(ReviewDecision.park),
            ),
            const SizedBox(height: AppSpacing.major),
            AppSectionHeader(
              title: _decision == ReviewDecision.park
                  ? 'Tindakan pertama saat dilanjutkan'
                  : _decision == ReviewDecision.pivot
                  ? 'Pendekatan baru yang akan diuji'
                  : 'Satu fokus minggu depan',
              description: _nextDescription,
            ),
            const SizedBox(height: AppSpacing.standard),
            TextField(
              controller: _next,
              minLines: 3,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: _decision == ReviewDecision.park
                    ? 'Wajib agar proyek mudah dilanjutkan'
                    : 'Satu kalimat cukup',
                alignLabelWithHint: true,
              ),
            ),
            if (_saveError case final error?) ...[
              const SizedBox(height: AppSpacing.section),
              AppNotice(
                icon: Icons.error_outline_rounded,
                title: 'Review belum diterapkan',
                description: error,
                background: AppColors.dangerSoft,
                foreground: AppColors.danger,
              ),
            ],
          ],
        ),
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
          label: Text(_saving ? 'Menerapkan…' : 'Tinjau dan terapkan'),
        ),
      ),
    );
  }

  String _projectName() {
    final projects = ref.watch(projectsProvider).value;
    if (projects == null) return 'Proyek fokus';
    for (final project in projects) {
      if (project.id == widget.projectId) return project.name;
    }
    return 'Proyek fokus';
  }

  String get _nextDescription => switch (_decision) {
    ReviewDecision.continueFocus =>
      'Pilih satu hasil yang paling layak dikejar, bukan daftar baru.',
    ReviewDecision.pivot =>
      'Tujuan utama tetap, tetapi sprint lama ditutup dan cara baru dimulai.',
    ReviewDecision.park =>
      'Kalimat ini disimpan di Restart Capsule sebagai pintu masuk berikutnya.',
  };

  void _selectDecision(ReviewDecision decision) {
    setState(() {
      _decision = decision;
      _saveError = null;
    });
  }

  WeeklyReviewInput get _input => WeeklyReviewInput(
    projectId: widget.projectId,
    weekStart: _weekStart,
    weekEnd: _weekStart.add(const Duration(days: 6)),
    shippedSummary: _shipped.text,
    importantResult: _important.text,
    workedWell: _worked.text,
    wasteOrBlocker: _waste.text,
    decision: _decision,
    nextWeekFocus: _next.text,
  );

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (_decision == ReviewDecision.park && _next.text.trim().isEmpty) {
      setState(
        () => _saveError =
            'Tulis satu tindakan pertama sebelum proyek disimpan dulu.',
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(_decisionIcon),
        title: Text(_confirmationTitle),
        content: Text(_confirmationDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Periksa lagi'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Terapkan keputusan'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      await ref
          .read(resultsRepositoryProvider)
          .saveAndApplyWeeklyReview(_input);
      ref.invalidate(projectsProvider);
      ref.invalidate(projectProvider(widget.projectId));
      ref.invalidate(todayProvider);
      ref.invalidate(weeklyReviewsProvider(widget.projectId));
      ref.invalidate(restartCapsuleProvider(widget.projectId));
      ref.invalidate(antiForgetTodaySupportProvider);
      if (!mounted) return;
      if (_decision == ReviewDecision.park) {
        context.go('/projects');
      } else {
        context.go('/today');
      }
    } on AppException catch (error) {
      if (mounted) setState(() => _saveError = error.message);
    } catch (_) {
      if (mounted) {
        setState(
          () => _saveError =
              'Review belum dapat diterapkan. Jawabanmu tetap ada di layar ini.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  IconData get _decisionIcon => switch (_decision) {
    ReviewDecision.continueFocus => Icons.arrow_forward_rounded,
    ReviewDecision.pivot => Icons.alt_route_rounded,
    ReviewDecision.park => Icons.inventory_2_outlined,
  };

  String get _confirmationTitle => switch (_decision) {
    ReviewDecision.continueFocus => 'Lanjutkan fokus ini?',
    ReviewDecision.pivot => 'Mulai pendekatan baru?',
    ReviewDecision.park => 'Simpan proyek ini dulu?',
  };

  String get _confirmationDescription => switch (_decision) {
    ReviewDecision.continueFocus =>
      'Fokus tetap aktif. Bila sprint hampir selesai, Satu Dulu membuat putaran 30 hari baru dan memakai fokus minggu depan sebagai titik mulai.',
    ReviewDecision.pivot =>
      'Sprint aktif ditutup, pendekatan lama disimpan di Restart Capsule, lalu eksperimen 30 hari baru dimulai.',
    ReviewDecision.park =>
      'Sprint aktif dibatalkan, proyek dipindahkan ke Parking Lot, dan konteks terakhir disimpan agar mudah dilanjutkan.',
  };
}

class _ReviewPrompt extends StatelessWidget {
  const _ReviewPrompt({
    required this.number,
    required this.title,
    required this.hint,
    required this.controller,
  });

  final int number;
  final String title;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.major),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  '$number',
                  style: AppTextStyles.number.copyWith(
                    color: AppColors.accentDeep,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.innerCompact),
          TextField(
            controller: controller,
            minLines: 3,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: hint,
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _DecisionOption extends StatelessWidget {
  const _DecisionOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.accentSoft : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.standard),
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? AppColors.accent : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: selected
                      ? AppColors.accentDeep
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.innerCompact),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.micro),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.compact),
                Icon(
                  selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                  color: selected ? AppColors.accent : AppColors.border,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
