import 'dart:async';

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
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
import 'package:satu_dulu/features/anti_forget/presentation/widgets/anti_forget_widgets.dart';
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

class _TodayScreenState extends ConsumerState<TodayScreen>
    with WidgetsBindingObserver {
  final _actionsKey = GlobalKey();
  late DateTime _today;
  Timer? _midnightTimer;
  bool _lowEnergy = false;
  bool _mutating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _today = _localDay(DateTime.now());
    _scheduleMidnightRefresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshCurrentDay();
  }

  @override
  Widget build(BuildContext context) {
    final overview = ref.watch(todayProvider(_today));
    final projects = ref.watch(projectsProvider);
    final support = ref.watch(antiForgetTodaySupportProvider(_today));
    final dateLabel = DateFormat('EEEE, d MMMM', 'id_ID').format(_today);

    return ScreenFrame(
      eyebrow: dateLabel,
      title: 'Hari Ini',
      subtitle: 'Satu hasil, satu langkah berikutnya.',
      trailing: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: AppColors.surfaceSecondary,
          foregroundColor: AppColors.textPrimary,
        ),
        onPressed: () => context.push('/settings'),
        tooltip: 'Pengaturan',
        icon: const Icon(Icons.tune_rounded),
      ),
      child: overview.when(
        loading: () => const TodayLoading(),
        error: (error, stackTrace) => TodayErrorCard(
          onRetry: () {
            ref.invalidate(todayProvider(_today));
            ref.invalidate(antiForgetTodaySupportProvider(_today));
          },
        ),
        data: (today) => today == null
            ? _buildEmptyState(projects, support.value)
            : _buildToday(context, today, support.value),
      ),
    );
  }

  Widget _buildEmptyState(
    AsyncValue<List<Project>> projects,
    AntiForgetTodaySupport? support,
  ) {
    return projects.when(
      loading: () => const AppLoadingBlock(height: 260),
      error: (error, stackTrace) =>
          TodayErrorCard(onRetry: () => ref.invalidate(projectsProvider)),
      data: (items) {
        final focus = items
            .where((project) => project.status == ProjectStatus.focus)
            .firstOrNull;
        Widget content;
        if (focus == null) {
          final hasProjects = items.isNotEmpty;
          content = EmptyStateCard(
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
        } else {
          final query = (projectId: focus.id, localDate: _today);
          final cycle = ref.watch(cycleReviewTargetProvider(query));
          content = cycle.when(
            loading: () => const AppLoadingBlock(height: 168),
            error: (error, stackTrace) => TodayErrorCard(
              onRetry: () => ref.invalidate(cycleReviewTargetProvider(query)),
            ),
            data: (target) {
              if (target?.availability == CycleReviewAvailability.due) {
                return EmptyStateCard(
                  icon: Icons.flag_outlined,
                  title: 'Putaran 30 harimu selesai',
                  description:
                      'Lihat bukti putaran ini sebelum memilih untuk lanjut, mengubah pendekatan, atau menyimpannya dulu.',
                  actionLabel: 'Tutup putaran ini',
                  onAction: () =>
                      context.push('/projects/${focus.id}/cycle-review'),
                );
              }
              if (target == null ||
                  target.availability == CycleReviewAvailability.closed ||
                  target.availability == CycleReviewAvailability.unavailable) {
                return EmptyStateCard(
                  icon: Icons.route_outlined,
                  title: 'Fokus ini belum punya putaran aktif',
                  description:
                      'Buka detail proyek untuk memeriksa arahnya atau pilih fokus lain yang siap dijalankan.',
                  actionLabel: 'Lihat proyek',
                  onAction: () => context.push('/projects/${focus.id}'),
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DailyCheckInCard(
              checkIn: support?.checkIn,
              onTap: () => context.push('/check-in'),
            ),
            if (focus != null && support?.recovery.isActive == true) ...[
              const SizedBox(height: AppSpacing.compact),
              RecoveryModeCard(
                brief: support!.recovery,
                onPrimary: () =>
                    _handleRecoveryPrimary(support.recovery, focus, null),
                onSecondary: () => _handleRecoverySecondary(support, focus),
              ),
            ],
            const SizedBox(height: AppSpacing.major),
            content,
          ],
        );
      },
    );
  }

  Widget _buildToday(
    BuildContext context,
    TodayOverview today,
    AntiForgetTodaySupport? support,
  ) {
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
        DailyCheckInCard(
          checkIn: support?.checkIn,
          onTap: () => context.push('/check-in'),
        ),
        if (support?.recovery.isActive == true) ...[
          const SizedBox(height: AppSpacing.compact),
          RecoveryModeCard(
            brief: support!.recovery,
            onPrimary: () =>
                _handleRecoveryPrimary(support.recovery, today.project, today),
            onSecondary: () => _handleRecoverySecondary(support, today.project),
          ),
        ],
        if (support?.capsule?.hasContext == true) ...[
          const SizedBox(height: AppSpacing.compact),
          RestartContextCard(
            capsule: support!.capsule!,
            onTap: () => context.push('/projects/${today.project.id}/restart'),
          ),
        ],
        const SizedBox(height: AppSpacing.major),
        AppEntrance(
          child: TodayFocusHero(
            projectName: today.project.name,
            sprintDay: today.sprintDay,
            sprintLength: today.sprintLength,
            requiredOutcome: today.requiredOutcome,
            nextAction: nextAction?.label,
            isShipped: isShipped,
            isBusy: _mutating,
            onShip: () => _ship(today),
          ),
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
            style: TextButton.styleFrom(foregroundColor: AppColors.guide),
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

  void _handleRecoveryPrimary(
    RecoveryBrief brief,
    Project project,
    TodayOverview? today,
  ) {
    switch (brief.reason) {
      case RecoveryReason.missingSprint:
        context.push('/projects/${project.id}');
      case RecoveryReason.reviewDue:
        context.push('/projects/${project.id}/cycle-review');
      case RecoveryReason.noPlanAfterNoon:
        context.push('/today/plan');
      case RecoveryReason.noShipTwoDays:
        if (today == null) {
          context.push('/today/plan');
        } else {
          _scrollToActions();
        }
      case RecoveryReason.lowEnergyOversizedPlan:
        setState(() => _lowEnergy = true);
        _scrollToActions();
      case RecoveryReason.none:
        break;
    }
  }

  void _handleRecoverySecondary(
    AntiForgetTodaySupport support,
    Project project,
  ) {
    if (support.capsule?.hasContext == true) {
      context.push('/projects/${project.id}/restart');
      return;
    }
    if (briefNeedsResults(support.recovery.reason)) {
      context.go('/results');
    } else {
      context.go('/guides');
    }
  }

  bool briefNeedsResults(RecoveryReason reason) =>
      reason == RecoveryReason.reviewDue;

  Future<void> _scrollToActions() async {
    final actionContext = _actionsKey.currentContext;
    if (actionContext == null || !actionContext.mounted) return;
    await Scrollable.ensureVisible(
      actionContext,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : AppDuration.card,
      curve: Curves.easeOutCubic,
      alignment: 0.16,
    );
  }

  Future<void> _setAction(DailyAction action, bool completed) async {
    setState(() => _mutating = true);
    try {
      await ref
          .read(trackerRepositoryProvider)
          .setActionCompleted(action.id, completed: completed);
      _invalidateToday();
    } on AppException catch (error) {
      _showError(error.message);
    } finally {
      if (mounted) setState(() => _mutating = false);
    }
  }

  Future<void> _ship(TodayOverview today) async {
    final draft = await showModalBottomSheet<ShipDraft>(
      context: context,
      sheetAnimationStyle: AppMotion.sheet(context),
      useRootNavigator: true,
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
      _invalidateToday();
      if (!mounted) return;
      if (!MediaQuery.disableAnimationsOf(context)) {
        await HapticFeedback.mediumImpact();
      }
      if (!mounted) return;
      final addEvidence = await showModalBottomSheet<bool>(
        context: context,
        sheetAnimationStyle: AppMotion.sheet(context),
        useRootNavigator: true,
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
    final choice = await showModalBottomSheet<RecoveryChoice>(
      context: context,
      sheetAnimationStyle: AppMotion.sheet(context),
      useRootNavigator: true,
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
    await _scrollToActions();
  }

  void _refreshCurrentDay() {
    if (!mounted) return;
    final nextDay = _localDay(DateTime.now());
    if (_sameDay(nextDay, _today)) {
      _invalidateToday();
      return;
    }
    setState(() {
      _today = nextDay;
      _lowEnergy = false;
      _mutating = false;
    });
    _scheduleMidnightRefresh();
  }

  void _invalidateToday() {
    ref.invalidate(todayProvider(_today));
    ref.invalidate(antiForgetTodaySupportProvider(_today));
  }

  void _scheduleMidnightRefresh() {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(
      tomorrow.difference(now) + const Duration(seconds: 1),
      _refreshCurrentDay,
    );
  }

  static DateTime _localDay(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
