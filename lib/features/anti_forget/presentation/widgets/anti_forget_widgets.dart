import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';

class DailyCheckInCard extends StatelessWidget {
  const DailyCheckInCard({
    required this.checkIn,
    required this.onTap,
    super.key,
  });

  final DailyCheckIn? checkIn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final value = checkIn;
    return Material(
      color: value == null ? AppColors.surfaceSecondary : AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Row(
            children: [
              AppIconBadge(
                icon: value == null
                    ? Icons.battery_unknown_rounded
                    : _energyIcon(value.energyLevel),
                foreground: value?.energyLevel == EnergyLevel.low
                    ? AppColors.warning
                    : AppColors.accentDeep,
                background: value?.energyLevel == EnergyLevel.low
                    ? AppColors.warningSoft
                    : AppColors.accentSoft,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value == null
                          ? 'Berapa kapasitasmu hari ini?'
                          : '${_energyLabel(value.energyLevel)} · ${value.capacityLabel}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      value == null
                          ? 'Check-in singkat membantu mengecilkan rencana secara realistis.'
                          : value.note?.trim().isNotEmpty == true
                          ? value.note!
                          : 'Ketuk untuk menyesuaikan energi atau waktu.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                value == null
                    ? Icons.arrow_forward_rounded
                    : Icons.edit_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _energyIcon(EnergyLevel level) => switch (level) {
    EnergyLevel.low => Icons.battery_1_bar_rounded,
    EnergyLevel.normal => Icons.battery_4_bar_rounded,
    EnergyLevel.high => Icons.battery_full_rounded,
  };

  static String _energyLabel(EnergyLevel level) => switch (level) {
    EnergyLevel.low => 'Energi rendah',
    EnergyLevel.normal => 'Energi normal',
    EnergyLevel.high => 'Energi tinggi',
  };
}

class RecoveryModeCard extends StatelessWidget {
  const RecoveryModeCard({
    required this.brief,
    required this.onPrimary,
    required this.onSecondary,
    super.key,
  });

  final RecoveryBrief brief;
  final VoidCallback onPrimary;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final urgent = brief.severity == RecoverySeverity.urgent;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: urgent ? AppColors.warningSoft : AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIconBadge(
                  icon: urgent ? Icons.route_outlined : Icons.explore_outlined,
                  foreground: urgent ? AppColors.warning : AppColors.accentDeep,
                  background: AppColors.surface,
                ),
                const SizedBox(width: AppSpacing.innerCompact),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppEyebrow('Recovery Mode'),
                      const SizedBox(height: AppSpacing.micro),
                      Text(
                        brief.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            Text(
              brief.message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            if (brief.suggestedAction?.trim().isNotEmpty == true) ...[
              const SizedBox(height: AppSpacing.innerCompact),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.innerCompact),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                      const SizedBox(width: AppSpacing.compact),
                      Expanded(child: Text(brief.suggestedAction!)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.innerCompact),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onPrimary,
                    child: Text(brief.primaryActionLabel),
                  ),
                ),
                if (brief.secondaryActionLabel case final label?) ...[
                  const SizedBox(width: AppSpacing.compact),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onSecondary,
                      child: Text(label),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestartContextCard extends StatelessWidget {
  const RestartContextCard({
    required this.capsule,
    required this.onTap,
    super.key,
  });

  final RestartCapsule capsule;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!capsule.hasContext) return const SizedBox.shrink();
    return Material(
      color: AppColors.guideSoft,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppIconBadge(
                icon: Icons.inventory_2_outlined,
                foreground: AppColors.guide,
                background: AppColors.surface,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Konteks terakhir proyek',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      capsule.nextAction?.trim().isNotEmpty == true
                          ? 'Mulai dari: ${capsule.nextAction}'
                          : capsule.lastKnownState ??
                                'Buka capsule untuk mengingat posisi terakhir.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
