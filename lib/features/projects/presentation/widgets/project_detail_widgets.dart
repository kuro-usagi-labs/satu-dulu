import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

class ProjectIdentityCard extends StatelessWidget {
  const ProjectIdentityCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final status = _statusPresentation(project.status);
    final start = project.startDate?.toLocal();
    final review = project.reviewDate?.toLocal();
    final totalDays = start == null || review == null
        ? null
        : review.difference(start).inDays + 1;
    final currentDay = start == null || totalDays == null
        ? null
        : DateTime.now().difference(start).inDays + 1;
    final progress = currentDay == null || totalDays == null
        ? null
        : (currentDay / totalDays).clamp(0.0, 1.0);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.hero),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                AppIconBadge(
                  icon: status.icon,
                  foreground: status.foreground,
                  background: status.background,
                  size: 44,
                ),
                const SizedBox(width: AppSpacing.innerCompact),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppEyebrow(status.label, color: status.foreground),
                      if (review != null)
                        Text(
                          'Review ${DateFormat('d MMM y', 'id_ID').format(review)}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.section),
            Text(
              project.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            if (progress != null &&
                totalDays != null &&
                currentDay != null) ...[
              const SizedBox(height: AppSpacing.section),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.innerCompact),
                  Text(
                    'Hari ${currentDay.clamp(1, totalDays)}/$totalDays',
                    style: AppTextStyles.number.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ProjectDirectionItem extends StatelessWidget {
  const ProjectDirectionItem({
    required this.number,
    required this.label,
    required this.value,
    this.emphasized = false,
    super.key,
  });

  final String number;
  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: emphasized ? AppColors.accent : AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          child: Text(
            number,
            style: AppTextStyles.number.copyWith(
              color: emphasized
                  ? AppColors.textInverse
                  : AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.innerCompact),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: emphasized
                        ? AppColors.accentDeep
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.micro),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectDestination extends StatelessWidget {
  const ProjectDestination({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.emphasized = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Ink(
        padding: const EdgeInsets.all(AppSpacing.standard),
        decoration: BoxDecoration(
          color: emphasized ? AppColors.accentSoft : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Row(
          children: [
            AppIconBadge(
              icon: icon,
              foreground: emphasized
                  ? AppColors.accentDeep
                  : AppColors.textPrimary,
              background: emphasized
                  ? AppColors.surface
                  : AppColors.surfaceSecondary,
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailLoading extends StatelessWidget {
  const ProjectDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.generous),
        child: Column(
          children: [
            AppLoadingBlock(height: 230),
            SizedBox(height: AppSpacing.major),
            AppLoadingBlock(height: 92),
            SizedBox(height: AppSpacing.compact),
            AppLoadingBlock(height: 92),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailError extends StatelessWidget {
  const ProjectDetailError({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.generous),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppNotice(
              icon: Icons.sync_problem_rounded,
              title: 'Proyek belum dapat dibuka',
              description: 'Data lokal tetap aman. Coba muat proyek lagi.',
              background: AppColors.dangerSoft,
              foreground: AppColors.danger,
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Muat lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectNotFound extends StatelessWidget {
  const ProjectNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(child: Text('Proyek ini tidak ditemukan.')),
    );
  }
}

({String label, IconData icon, Color foreground, Color background})
_statusPresentation(ProjectStatus status) => switch (status) {
  ProjectStatus.focus => (
    label: 'Fokus utama',
    icon: Icons.adjust_rounded,
    foreground: AppColors.accentDeep,
    background: AppColors.accentSoft,
  ),
  ProjectStatus.maintenance => (
    label: 'Tetap dijaga',
    icon: Icons.spa_outlined,
    foreground: AppColors.success,
    background: AppColors.successSoft,
  ),
  ProjectStatus.parkingLot => (
    label: 'Disimpan dulu',
    icon: Icons.inventory_2_outlined,
    foreground: AppColors.textSecondary,
    background: AppColors.surfaceSecondary,
  ),
  ProjectStatus.archived => (
    label: 'Diarsipkan',
    icon: Icons.archive_outlined,
    foreground: AppColors.textSecondary,
    background: AppColors.surfaceSecondary,
  ),
};
