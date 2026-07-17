import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

class FocusProjectCard extends StatelessWidget {
  const FocusProjectCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final reviewDate = project.reviewDate?.toLocal();
    return AppFocusCard(
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: AppStatusPill(
              label: 'Fokus utama',
              tone: AppStatusTone.focus,
              icon: Icons.adjust_rounded,
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Text(project.name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.compact),
          Text(
            project.shortGoal,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          if (reviewDate != null) ...[
            const SizedBox(height: AppSpacing.section),
            Text(
              'Review ${DateFormat('d MMM y', 'id_ID').format(reviewDate)}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textTertiary),
            ),
          ],
          const SizedBox(height: AppSpacing.standard),
          AppActionButton(
            onPressed: () => context.push('/projects/${project.id}'),
            icon: Icons.arrow_forward_rounded,
            label: 'Buka arah proyek',
          ),
        ],
      ),
    );
  }
}

class ProjectOverviewRow extends StatelessWidget {
  const ProjectOverviewRow({
    required this.project,
    this.quiet = false,
    super.key,
  });

  final Project project;
  final bool quiet;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${project.name}, ${quiet ? 'disimpan dulu' : 'tetap dijaga'}',
      child: InkWell(
        onTap: () => context.push('/projects/${project.id}'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.standard),
          decoration: BoxDecoration(
            color: quiet ? AppColors.parkingSoft : AppColors.maintenanceSoft,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconBadge(
                icon: quiet ? Icons.inventory_2_outlined : Icons.spa_outlined,
                foreground: quiet ? AppColors.textSecondary : AppColors.success,
                background: quiet ? AppColors.surface : AppColors.surface,
                size: 44,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      project.shortGoal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.compact),
                    AppStatusPill(
                      label: quiet ? 'Disimpan dulu' : 'Tetap dijaga',
                      tone: quiet
                          ? AppStatusTone.parking
                          : AppStatusTone.maintenance,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.compact),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoFocusBanner extends StatelessWidget {
  const NoFocusBanner({required this.onChoose, super.key});

  final VoidCallback onChoose;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.actionSoft,
        borderRadius: BorderRadius.circular(AppRadius.hero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppIconBadge(icon: Icons.adjust_rounded),
            const SizedBox(height: AppSpacing.standard),
            Text(
              'Hari Ini belum punya pemimpin',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.compact),
            Text(
              'Pilih satu dari proyek yang sudah ada. Tidak perlu membuat proyek baru.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.section),
            AppActionButton(onPressed: onChoose, label: 'Pilih fokus utama'),
          ],
        ),
      ),
    );
  }
}

class QuietProjectEmpty extends StatelessWidget {
  const QuietProjectEmpty({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.compact),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiary,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class ProjectsLoading extends StatelessWidget {
  const ProjectsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppLoadingBlock(height: 270),
        SizedBox(height: AppSpacing.major),
        AppLoadingBlock(height: 92),
        SizedBox(height: AppSpacing.compact),
        AppLoadingBlock(height: 92),
      ],
    );
  }
}

class ProjectsError extends StatelessWidget {
  const ProjectsError({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppNotice(
          icon: Icons.folder_off_outlined,
          title: 'Proyek belum dapat dibuka',
          description: 'Data lokal tetap aman. Coba muat daftar proyek lagi.',
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
    );
  }
}
