import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/projects/presentation/widgets/project_overview_widgets.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);

    return ScreenFrame(
      eyebrow: 'Atur perhatianmu',
      title: 'Proyek',
      subtitle:
          'Satu fokus memimpin. Satu boleh tetap dijaga. Ide lain aman disimpan dulu.',
      trailing: IconButton.filled(
        onPressed: () => context.push('/projects/new'),
        tooltip: 'Tambah proyek',
        icon: const Icon(Icons.add_rounded),
      ),
      child: projects.when(
        loading: () => const ProjectsLoading(),
        error: (error, stackTrace) =>
            ProjectsError(onRetry: () => ref.invalidate(projectsProvider)),
        data: (items) => items.isEmpty
            ? EmptyStateCard(
                icon: Icons.folder_copy_outlined,
                title: 'Belum ada proyek',
                description:
                    'Buat satu fokus untuk 30 hari. Hari Ini akan membantumu bergerak dari sana.',
                actionLabel: 'Buat fokus pertama',
                onAction: () => context.push('/projects/new'),
              )
            : _ProjectsContent(items: items),
      ),
    );
  }
}

class _ProjectsContent extends ConsumerWidget {
  const _ProjectsContent({required this.items});

  final List<Project> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focus = _withStatus(ProjectStatus.focus).firstOrNull;
    final maintained = _withStatus(ProjectStatus.maintenance);
    final parked = _withStatus(ProjectStatus.parkingLot);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (focus == null)
          NoFocusBanner(onChoose: () => _chooseFocus(context, ref))
        else
          FocusProjectCard(project: focus),
        const SizedBox(height: AppSpacing.major),
        const AppSectionHeader(
          title: 'Tetap dijaga',
          description: 'Tidak mengambil alih Hari Ini. Maksimal satu proyek.',
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        if (maintained.isEmpty)
          const QuietProjectEmpty(label: 'Belum ada proyek yang tetap dijaga.')
        else
          for (final project in maintained) ...[
            ProjectOverviewRow(project: project),
            if (project != maintained.last)
              const SizedBox(height: AppSpacing.compact),
          ],
        const SizedBox(height: AppSpacing.major),
        AppSectionHeader(
          title: 'Disimpan dulu',
          description: 'Ide tetap aman tanpa memecah fokusmu sekarang.',
          trailing: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(AppRadius.small),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.compact,
                vertical: AppSpacing.micro,
              ),
              child: Text(
                '${parked.length}',
                style: AppTextStyles.number.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        if (parked.isEmpty)
          const QuietProjectEmpty(label: 'Belum ada ide yang disimpan dulu.')
        else
          for (final project in parked) ...[
            ProjectOverviewRow(project: project, quiet: true),
            if (project != parked.last)
              const SizedBox(height: AppSpacing.compact),
          ],
        const SizedBox(height: AppSpacing.section),
        TextButton.icon(
          onPressed: () => _showStatusGuide(context),
          icon: const Icon(Icons.help_outline_rounded),
          label: const Text('Apa bedanya tiga tempat ini?'),
        ),
      ],
    );
  }

  List<Project> _withStatus(ProjectStatus status) => items
      .where((project) => project.status == status)
      .toList(growable: false);

  Future<void> _chooseFocus(BuildContext context, WidgetRef ref) async {
    final candidates = items
        .where((project) => project.status != ProjectStatus.archived)
        .toList(growable: false);
    final selected = await showModalBottomSheet<Project>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.generous,
            0,
            AppSpacing.generous,
            AppSpacing.section,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppEyebrow('Pilih satu saja'),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Proyek mana yang memimpin sekarang?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Proyek ini akan muncul di Hari Ini. Kamu bisa menggantinya nanti.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.section),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.48,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: candidates.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, index) {
                    final project = candidates[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const AppIconBadge(
                        icon: Icons.arrow_outward_rounded,
                        size: 42,
                      ),
                      title: Text(project.name),
                      subtitle: Text(
                        project.shortGoal,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.pop(context, project),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (selected == null || !context.mounted) return;

    try {
      await ref
          .read(trackerRepositoryProvider)
          .updateProject(
            selected.id,
            UpdateProjectInput(
              name: selected.name,
              shortGoal: selected.shortGoal,
              whyChosen: selected.whyChosen,
              successDefinition: selected.successDefinition,
              targetRevenueMinor: selected.targetRevenueMinor,
              status: ProjectStatus.focus,
            ),
          );
      ref.invalidate(projectsProvider);
      ref.invalidate(todayProvider);
      if (context.mounted) context.go('/today');
    } on AppException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
  }

  void _showStatusGuide(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (context) => const SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.generous,
            0,
            AppSpacing.generous,
            AppSpacing.section,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppEyebrow('Tiga tempat, tiga tugas'),
              SizedBox(height: AppSpacing.section),
              AppStepRow(
                number: 1,
                title: 'Fokus utama',
                description:
                    'Satu proyek yang memimpin 30 hari dan muncul di Hari Ini.',
                highlighted: true,
              ),
              AppStepRow(
                number: 2,
                title: 'Tetap dijaga',
                description:
                    'Satu proyek yang perlu tetap hidup, tetapi tidak menguasai perhatian.',
              ),
              AppStepRow(
                number: 3,
                title: 'Disimpan dulu',
                description:
                    'Semua ide lain. Aman untuk nanti dan tidak hilang.',
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
