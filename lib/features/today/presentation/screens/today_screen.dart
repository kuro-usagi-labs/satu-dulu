import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/today/presentation/widgets/today_sheets.dart';
import 'package:satu_dulu/features/today/presentation/widgets/today_state_widgets.dart';
import 'package:satu_dulu/features/today/presentation/widgets/today_widgets.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  late final DateTime _today;
  final _actionsKey = GlobalKey();
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
    final overview = ref.watch(todayProvider(_today));
    final projects = ref.watch(projectsProvider);
    final dateLabel = DateFormat('EEEE, d MMMM', 'id_ID').format(_today);

    return ScreenFrame(
      eyebrow: dateLabel,
      title: 'Hari Ini',
      subtitle:
          'Satu hasil. Maksimal tiga langkah. Ship ketika benar-benar selesai.',
      trailing: IconButton.filledTonal(
        onPressed: () => context.push('/settings'),
        tooltip: 'Pengaturan',
        icon: const Icon(Icons.tune_rounded),
      ),
      child: overview.when(
        loading: () => const TodayLoading(),
        error: (error, stackTrace) => TodayErrorCard(
          onRetry: () => ref.invalidate(todayProvider(_today)),
        ),
        data: (today) => today == null
            ? _buildEmptyState(projects)
            : _buildToday(context, today),
      ),
    );
  }

  Widget _buildEmptyState(AsyncValue<List<Project>> projects) {
    return projects.when(
      loading: () => const AppLoadingBlock(height: 260),
      error: (error, stackTrace) =>
          TodayErrorCard(onRetry: () => ref.invalidate(projectsProvider)),
      data: (items) {
        final focus = items
            .where((project) => project.status == ProjectStatus.focus)
            .firstOrNull;
        if (focus == null) {
          final hasProjects = items.isNotEmpty;
          return EmptyStateCard(
            icon: hasProjects
                ? Icons.adjust_rounded
                : Icons.center_focus_strong_rounded,
            title: hasProjects
                ? 'Pilih satu fokus utama'
                : 'Mulai dari satu fokus',
            description: hasProjects
                ? 'Kamu sudah punya proyek. Pilih satu yang memimpin Hari Ini; yang lain tetap aman disimpan.'
                : 'Buat satu proyek untuk 30 hari. Kamu akan langsung menyiapkan hasil pertamamu.',
            footnote: 'Ide lain tidak akan dihapus atau dilupakan.',
            actionLabel: hasProjects
                ? 'Pilih dari proyek'
                : 'Buat fokus pertama',
            onAction: () =>
                context.push(hasProjects ? '/projects' : '/projects/new'),
          );
        }

        if (_reviewIsDue(focus)) {
          return EmptyStateCard(
            icon: Icons.flag_outlined,
            title: 'Putaran 30 harimu selesai',
            description:
                'Lihat bukti yang terkumpul sebelum memutuskan untuk lanjut, mengubah arah, atau menyimpan proyek ini dulu.',
            actionLabel: 'Review fokus ini',
            onAction: () => context.push('/results/review?project=${focus.id}'),
          );
        }

        return EmptyStateCard(
          icon: Icons.edit_calendar_outlined,
          title: 'Hari ini belum punya hasil',
          description:
              'Mulai bersih. Tentukan satu hasil yang benar-benar bisa kamu selesaikan atau terbitkan hari ini.',
          footnote: 'Tidak ada utang tugas yang dibawa dari kemarin.',
          actionLabel: 'Tentukan hasil hari ini',
          onAction: () => context.push('/today/plan'),
        );
      },
    );
  }

  bool _reviewIsDue(Project project) {
    final reviewDate = project.reviewDate?.toLocal();
    if (reviewDate == null) return false;
    final normalized = DateTime(
      reviewDate.year,
      reviewDate.month,
      reviewDate.day,
    );
    return normalized.isBefore(_today);
  }

  Widget _buildToday(BuildContext context, TodayOverview today) {
    final completed = today.actions
        .where((action) => action.isCompleted)
        .length;
    final nextAction = today.actions
        .where((action) => !action.isCompleted)
        .firstOrNull;
    final isShipped = today.shipRecord != null;
    final hasGuide =
        (today.linkedGuideDocumentId ?? today.project.primaryGuideDocumentId) !=
        null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TodayFocusHero(
          projectName: today.project.name,
          sprintDay: today.sprintDay,
          sprintLength: today.sprintLength,
          requiredOutcome: today.requiredOutcome,
          nextAction: nextAction?.label,
          isShipped: isShipped,
          isBusy: _mutating,
          onShip: () => _ship(today),
        ),
        if (isShipped) ...[
          const SizedBox(height: AppSpacing.standard),
          PostShipCard(
            onAddEvidence: () =>
                context.push('/results/metric?project=${today.project.id}'),
          ),
        ],
        const SizedBox(height: AppSpacing.major),
        AppSectionHeader(
          key: _actionsKey,
          title: isShipped ? 'Langkah yang kamu tempuh' : 'Kerjakan dari atas',
          description: isShipped
              ? '$completed dari ${today.actions.length} langkah selesai.'
              : 'Centang seperlunya. Ship tidak menunggu semuanya sempurna.',
          trailing: Text(
            '$completed/${today.actions.length}',
            style: AppTextStyles.number.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
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
                        isNext: action.id == nextAction?.id,
                        enabled: !_mutating && !isShipped,
                        onChanged: (value) => _setAction(action, value),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.micro),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: isShipped
                ? null
                : () => setState(() => _lowEnergy = !_lowEnergy),
            icon: Icon(
              _lowEnergy
                  ? Icons.arrow_back_rounded
                  : Icons.battery_2_bar_rounded,
            ),
            label: Text(
              _lowEnergy ? 'Kembali ke langkah utama' : 'Energi lagi rendah',
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        RecoveryShortcut(
          hasGuide: hasGuide,
          onTap: () => _showLostTrack(today),
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
    final draft = await showModalBottomSheet<ShipDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => ShipSheet(
        initialTitle: today.requiredOutcome,
        initiallyPartial: _lowEnergy,
      ),
    );
    if (draft == null) return;

    setState(() => _mutating = true);
    try {
      await ref
          .read(trackerRepositoryProvider)
          .shipToday(
            dailyPlanId: today.dailyPlanId,
            outputTitle: draft.title,
            isPartial: draft.isPartial,
            externalUrl: draft.externalUrl,
            evidenceNote: draft.evidenceNote,
          );
      ref.invalidate(todayProvider(_today));
      if (!mounted) return;
      if (!MediaQuery.disableAnimationsOf(context)) {
        await HapticFeedback.mediumImpact();
      }
      if (!mounted) return;
      final addEvidence = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        useSafeArea: true,
        builder: (context) => ShipSuccessSheet(outputTitle: draft.title),
      );
      if (addEvidence == true && mounted) {
        await context.push(
          '/results/metric?project=${today.project.id}&source=ship',
        );
      }
    } on AppException catch (error) {
      _showError(error.message);
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }

  Future<void> _showLostTrack(TodayOverview today) async {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final choice = await showModalBottomSheet<RecoveryChoice>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => RecoverySheet(today: today, lowEnergy: _lowEnergy),
    );
    if (!mounted || choice == null) return;

    if (choice == RecoveryChoice.guide) {
      final documentId =
          today.linkedGuideDocumentId ?? today.project.primaryGuideDocumentId!;
      final linkedPage = today.linkedGuideDocumentId == null
          ? null
          : today.linkedGuidePage;
      final pageQuery = linkedPage == null ? '' : '?page=$linkedPage';
      await context.push('/guides/$documentId/read$pageQuery');
      return;
    }

    final actionContext = _actionsKey.currentContext;
    if (actionContext != null && actionContext.mounted) {
      await Scrollable.ensureVisible(
        actionContext,
        duration: reduceMotion ? Duration.zero : AppDuration.card,
        curve: Curves.easeOutCubic,
        alignment: 0.16,
      );
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
