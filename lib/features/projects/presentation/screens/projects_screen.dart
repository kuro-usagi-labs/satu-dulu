import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final projects = ref.watch(projectsProvider);

    return ScreenFrame(
      title: strings.projectsTitle,
      subtitle: strings.projectsSubtitle,
      child: projects.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => const _ProjectsError(),
        data: (items) {
          if (items.isEmpty) {
            return EmptyStateCard(
              icon: Icons.folder_copy_outlined,
              title: strings.noProjectsTitle,
              description: strings.noProjectsDescription,
              actionLabel: strings.createProject,
              onAction: () => context.push('/projects/new'),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: () => context.push('/projects/new'),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Tambah proyek'),
                ),
              ),
              const SizedBox(height: AppSpacing.section),
              _ProjectSection(
                title: 'Focus',
                emptyLabel: 'Belum ada fokus utama.',
                projects: _withStatus(items, ProjectStatus.focus),
              ),
              const SizedBox(height: AppSpacing.section),
              _ProjectSection(
                title: 'Maintenance',
                emptyLabel: 'Tidak ada proyek maintenance.',
                projects: _withStatus(items, ProjectStatus.maintenance),
              ),
              const SizedBox(height: AppSpacing.section),
              _ProjectSection(
                title: 'Parking Lot',
                emptyLabel: 'Parking Lot masih kosong.',
                projects: _withStatus(items, ProjectStatus.parkingLot),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Project> _withStatus(List<Project> items, ProjectStatus status) => items
      .where((project) => project.status == status)
      .toList(growable: false);
}

class _ProjectSection extends StatelessWidget {
  const _ProjectSection({
    required this.title,
    required this.emptyLabel,
    required this.projects,
  });

  final String title;
  final String emptyLabel;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.innerCompact),
        if (projects.isEmpty)
          Text(
            emptyLabel,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
          )
        else
          for (final project in projects) ...[
            _ProjectCard(
              project: project,
              onTap: () => context.push('/projects/${project.id}'),
            ),
            if (project != projects.last)
              const SizedBox(height: AppSpacing.innerCompact),
          ],
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onTap});

  final Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final reviewDate = project.reviewDate?.toLocal();
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                  color: _statusColor(project.status),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      project.shortGoal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (reviewDate != null) ...[
                      const SizedBox(height: AppSpacing.compact),
                      Text(
                        'Review ${DateFormat('d MMM y', 'id').format(reviewDate)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(ProjectStatus status) => switch (status) {
    ProjectStatus.focus => AppColors.accent,
    ProjectStatus.maintenance => AppColors.success,
    ProjectStatus.parkingLot => AppColors.textTertiary,
    ProjectStatus.archived => AppColors.border,
  };
}

class _ProjectsError extends StatelessWidget {
  const _ProjectsError();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Text(
          'Proyek belum dapat dimuat. Coba buka ulang aplikasi.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
