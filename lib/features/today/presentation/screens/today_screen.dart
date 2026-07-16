import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/today/presentation/widgets/today_widgets.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  late final DateTime _today;
  bool _lowEnergy = false;
  bool _mutating = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final overview = ref.watch(todayProvider(_today));
    final projects = ref.watch(projectsProvider);

    return ScreenFrame(
      title: strings.todayTitle,
      subtitle: strings.todaySubtitle,
      trailing: IconButton(
        onPressed: () => context.push('/settings'),
        tooltip: 'Pengaturan',
        icon: const Icon(Icons.settings_outlined),
      ),
      child: overview.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => const TodayErrorCard(),
        data: (today) {
          if (today == null) {
            final hasFocus =
                projects.value?.any(
                  (project) => project.status == ProjectStatus.focus,
                ) ??
                false;
            return EmptyStateCard(
              icon: hasFocus
                  ? Icons.edit_calendar_outlined
                  : Icons.center_focus_strong_rounded,
              title: hasFocus
                  ? 'Belum ada rencana hari ini'
                  : strings.noFocusTitle,
              description: hasFocus
                  ? 'Mulai bersih tanpa membawa utang tugas dari kemarin.'
                  : strings.noFocusDescription,
              actionLabel: hasFocus
                  ? 'Buat rencana hari ini'
                  : strings.createFirstFocus,
              onAction: () =>
                  context.push(hasFocus ? '/today/plan' : '/projects/new'),
            );
          }
          return _buildToday(context, today);
        },
      ),
    );
  }

  Widget _buildToday(BuildContext context, TodayOverview today) {
    final completed = today.actions
        .where((action) => action.isCompleted)
        .length;
    final progress = (today.sprintDay / today.sprintLength).clamp(0.0, 1.0);
    final isShipped = today.shipRecord != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.hero),
            side: const BorderSide(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.section),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fokus 30 hari',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppColors.accent),
                ),
                const SizedBox(height: AppSpacing.compact),
                Text(
                  today.project.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.compact),
                Text(
                  'Hari ${today.sprintDay}/${today.sprintLength}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.compact),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(999),
                  backgroundColor: AppColors.surfaceSecondary,
                ),
                const SizedBox(height: AppSpacing.section),
                Text(
                  'Hasil wajib hari ini',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.micro),
                Text(
                  today.requiredOutcome,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.section),
                FilledButton.icon(
                  onPressed: isShipped || _mutating ? null : () => _ship(today),
                  icon: Icon(
                    isShipped
                        ? Icons.check_circle_rounded
                        : Icons.rocket_launch_rounded,
                  ),
                  label: Text(isShipped ? 'Sudah di-ship' : 'Ship Hari Ini'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        Row(
          children: [
            Expanded(
              child: Text(
                'Tindakan hari ini',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              '$completed/${today.actions.length}',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        AnimatedSwitcher(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : AppDuration.stateChange,
          child: _lowEnergy
              ? LowEnergyCard(
                  key: const ValueKey('low-energy'),
                  action: today.lowEnergyAction,
                )
              : Column(
                  key: const ValueKey('normal-actions'),
                  children: [
                    for (final action in today.actions)
                      TodayActionTile(
                        action: action,
                        enabled: !_mutating,
                        onChanged: (value) => _setAction(action, value),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        TextButton.icon(
          onPressed: () => setState(() => _lowEnergy = !_lowEnergy),
          icon: const Icon(Icons.battery_2_bar_rounded),
          label: Text(
            _lowEnergy ? 'Kembali ke rencana utama' : 'Energi lagi rendah',
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.card),
            onTap: () => _showLostTrack(today),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.standard),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.guideSoft,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.innerCompact),
                      child: Icon(
                        Icons.explore_outlined,
                        color: AppColors.guide,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.innerCompact),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aku Lupa Arah',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: AppSpacing.micro),
                        Text('Lihat tujuan dan tindakan terkecil berikutnya.'),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _setAction(DailyAction action, bool completed) async {
    setState(() => _mutating = true);
    try {
      await ref
          .read(trackerRepositoryProvider)
          .setActionCompleted(action.id, completed: completed);
      ref.invalidate(todayProvider(_today));
    } on AppException catch (error) {
      _showError(error.message);
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }

  Future<void> _ship(TodayOverview today) async {
    final result = await _showShipSheet(today);
    if (result == null) return;
    setState(() => _mutating = true);
    try {
      await ref
          .read(trackerRepositoryProvider)
          .shipToday(
            dailyPlanId: today.dailyPlanId,
            outputTitle: result.$1,
            isPartial: result.$2,
          );
      ref.invalidate(todayProvider(_today));
      if (mounted) {
        final reduceMotion = MediaQuery.disableAnimationsOf(context);
        if (!reduceMotion) {
          await HapticFeedback.mediumImpact();
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hasil hari ini sudah di-ship.')),
        );
      }
    } on AppException catch (error) {
      _showError(error.message);
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }

  Future<(String, bool)?> _showShipSheet(TodayOverview today) async {
    final controller = TextEditingController(text: today.requiredOutcome);
    var partial = _lowEnergy;
    final result = await showModalBottomSheet<(String, bool)>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.generous,
            AppSpacing.section,
            AppSpacing.generous,
            MediaQuery.viewInsetsOf(context).bottom + AppSpacing.section,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ship Hari Ini',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.compact),
              const Text(
                'Catat hasil yang benar-benar selesai atau diterbitkan.',
              ),
              const SizedBox(height: AppSpacing.standard),
              TextField(
                controller: controller,
                autofocus: true,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Judul hasil'),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: partial,
                onChanged: (value) =>
                    setSheetState(() => partial = value ?? false),
                title: const Text('Ini hasil sebagian'),
                subtitle: const Text('Tetap bergerak tanpa menyebutnya gagal.'),
              ),
              const SizedBox(height: AppSpacing.compact),
              FilledButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    Navigator.pop(context, (controller.text.trim(), partial));
                  }
                },
                child: const Text('Simpan hasil'),
              ),
            ],
          ),
        ),
      ),
    );
    controller.dispose();
    return result;
  }

  Future<void> _showLostTrack(TodayOverview today) {
    final smallestAction =
        _lowEnergy && today.lowEnergyAction?.isNotEmpty == true
        ? today.lowEnergyAction!
        : today.actions.firstOrNull?.label ?? today.requiredOutcome;
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.generous,
          AppSpacing.section,
          AppSpacing.generous,
          AppSpacing.screen,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Kamu sedang mengerjakan',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              today.project.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.section),
            RecoveryItem(label: 'Tujuan', value: today.project.shortGoal),
            if (today.project.whyChosen?.isNotEmpty == true) ...[
              const SizedBox(height: AppSpacing.standard),
              RecoveryItem(
                label: 'Kenapa dipilih',
                value: today.project.whyChosen!,
              ),
            ],
            const SizedBox(height: AppSpacing.standard),
            RecoveryItem(label: 'Hasil hari ini', value: today.requiredOutcome),
            const SizedBox(height: AppSpacing.standard),
            RecoveryItem(label: 'Tindakan terkecil', value: smallestAction),
            const SizedBox(height: AppSpacing.section),
            if ((today.linkedGuideDocumentId ??
                    today.project.primaryGuideDocumentId) !=
                null) ...[
              OutlinedButton.icon(
                onPressed: () {
                  final documentId =
                      today.linkedGuideDocumentId ??
                      today.project.primaryGuideDocumentId!;
                  final linkedPage = today.linkedGuideDocumentId == null
                      ? null
                      : today.linkedGuidePage;
                  Navigator.pop(context);
                  final pageQuery = linkedPage == null
                      ? ''
                      : '?page=$linkedPage';
                  this.context.push('/guides/$documentId/read$pageQuery');
                },
                icon: const Icon(Icons.menu_book_rounded),
                label: const Text('Buka panduan arah'),
              ),
              const SizedBox(height: AppSpacing.compact),
            ],
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kerjakan sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
