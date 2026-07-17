import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

class TodayFocusHero extends StatelessWidget {
  const TodayFocusHero({
    required this.projectName,
    required this.sprintDay,
    required this.sprintLength,
    required this.requiredOutcome,
    required this.isShipped,
    required this.isBusy,
    required this.onShip,
    this.nextAction,
    super.key,
  });

  final String projectName;
  final int sprintDay;
  final int sprintLength;
  final String requiredOutcome;
  final String? nextAction;
  final bool isShipped;
  final bool isBusy;
  final VoidCallback onShip;

  @override
  Widget build(BuildContext context) {
    final progress = (sprintDay / sprintLength).clamp(0.0, 1.0);
    return AppFocusCard(
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppEyebrow('Fokus utama'),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      projectName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              AppStatusPill(
                label: 'Hari $sprintDay/$sprintLength',
                tone: AppStatusTone.neutral,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.standard),
          Semantics(
            container: true,
            label:
                'Progres eksperimen 30 hari, hari $sprintDay dari $sprintLength',
            child: ExcludeSemantics(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: AppColors.surface.withValues(alpha: 0.68),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Text(
            isShipped ? 'Yang kamu kirim hari ini' : 'Hasil wajib hari ini',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.actionDeep,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.compact),
          Text(
            requiredOutcome,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (!isShipped && nextAction?.isNotEmpty == true) ...[
            const SizedBox(height: AppSpacing.section),
            const Divider(color: AppColors.actionPressed),
            const SizedBox(height: AppSpacing.innerCompact),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppIconBadge(
                  icon: Icons.arrow_forward_rounded,
                  foreground: AppColors.onAction,
                  background: AppColors.action,
                  size: 44,
                ),
                const SizedBox(width: AppSpacing.innerCompact),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Langkah berikutnya',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: AppColors.actionDeep),
                      ),
                      const SizedBox(height: AppSpacing.micro),
                      Text(
                        nextAction!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.section),
          if (isShipped)
            const Align(
              alignment: Alignment.centerLeft,
              child: AppStatusPill(
                label: 'Sudah di-Ship',
                tone: AppStatusTone.success,
                icon: Icons.check_circle_rounded,
              ),
            )
          else
            AppActionButton(
              onPressed: isBusy ? null : onShip,
              icon: Icons.arrow_outward_rounded,
              label: 'Ship Hari Ini',
            ),
        ],
      ),
    );
  }
}

class TodayActionTile extends StatelessWidget {
  const TodayActionTile({
    required this.action,
    required this.enabled,
    required this.onChanged,
    this.isNext = false,
    super.key,
  });

  final DailyAction action;
  final bool enabled;
  final bool isNext;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final completed = action.isCompleted;
    return AnimatedContainer(
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : AppDuration.stateChange,
      margin: const EdgeInsets.only(bottom: AppSpacing.compact),
      decoration: BoxDecoration(
        color: completed
            ? AppColors.surfaceSecondary
            : isNext
            ? AppColors.surface
            : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: isNext && !completed ? AppColors.action : AppColors.divider,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: CheckboxListTile(
          value: completed,
          onChanged: enabled ? (value) => onChanged(value ?? false) : null,
          contentPadding: const EdgeInsets.fromLTRB(
            AppSpacing.innerCompact,
            AppSpacing.compact,
            AppSpacing.standard,
            AppSpacing.compact,
          ),
          title: Text(
            action.label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              decoration: completed ? TextDecoration.lineThrough : null,
              color: completed ? AppColors.textTertiary : AppColors.textPrimary,
            ),
          ),
          subtitle: isNext && !completed
              ? Text(
                  'Langkah berikutnya',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.actionDeep,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null,
          controlAffinity: ListTileControlAffinity.leading,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
        ),
      ),
    );
  }
}

class LowEnergyCard extends StatelessWidget {
  const LowEnergyCard({required this.action, super.key});

  final String? action;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.guideSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppIconBadge(
                  icon: Icons.battery_2_bar_rounded,
                  foreground: AppColors.guide,
                  background: AppColors.surface,
                  size: 42,
                ),
                const SizedBox(width: AppSpacing.innerCompact),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kecilkan langkahnya, bukan arahnya.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.micro),
                      Text(
                        'Versi paling kecil yang tetap membuatmu bergerak:',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.standard),
            Text(
              action?.isNotEmpty == true
                  ? action!
                  : 'Pilih satu tindakan yang masih mungkin kamu selesaikan.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Saat selesai, Ship Hari Ini akan otomatis ditandai sebagai versi kecil.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class RecoveryItem extends StatelessWidget {
  const RecoveryItem({
    required this.label,
    required this.value,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasized ? AppColors.guideSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Padding(
        padding: EdgeInsets.all(emphasized ? AppSpacing.standard : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: emphasized ? AppColors.guide : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.micro),
            Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class TodayErrorCard extends StatelessWidget {
  const TodayErrorCard({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppNotice(
          icon: Icons.sync_problem_rounded,
          title: 'Rencana belum dapat dimuat',
          description: 'Data lokal tetap aman. Coba buka rencana sekali lagi.',
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
          key: ValueKey('today-error'),
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Muat lagi'),
        ),
      ],
    );
  }
}
