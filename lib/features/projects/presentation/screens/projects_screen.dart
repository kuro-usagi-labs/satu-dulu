import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/projects/presentation/widgets/project_overview_widgets.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final ideaCount = ref.watch(activeIdeasProvider).value?.length ?? 0;

    return ScreenFrame(
      eyebrow: 'Atur perhatianmu',
      title: 'Proyek',
      subtitle: 'Satu fokus aktif, ide lain tetap aman.',
      trailing: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: AppColors.surfaceSecondary,
          foregroundColor: AppColors.textPrimary,
        ),
        onPressed: () => context.push('/projects/new'),
        tooltip: 'Tambah proyek',
        icon: const Icon(Icons.add_rounded),
      ),
      child: projects.when(
        loading: () => const ProjectsLoading(),
        error: (error, stackTrace) =>
            ProjectsError(onRetry: () => ref.invalidate(projectsProvider)),
        data: (items) => items.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _IdeaInboxShortcut(count: ideaCount),
                  const SizedBox(height: AppSpacing.standard),
                  EmptyStateCard(
                    icon: Icons.folder_copy_outlined,
                    title: 'Belum ada proyek',
                    description:
                        'Buat satu fokus untuk 30 hari. Hari Ini akan membantumu bergerak dari sana.',
                    actionLabel: 'Buat fokus pertama',
                    onAction: () => context.push('/projects/new'),
                  ),
                ],
              )
            : _ProjectsContent(items: items, ideaCount: ideaCount),
      ),
    );
  }
}

class _ProjectsContent extends ConsumerWidget {
  const _ProjectsContent({required this.items, required this.ideaCount});

  final List<Project> items;
  final int ideaCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focus = _withStatus(ProjectStatus.focus).firstOrNull;
    final maintained = _withStatus(ProjectStatus.maintenance);
    final parked = _withStatus(ProjectStatus.parkingLot);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _IdeaInboxShortcut(count: ideaCount),
        const SizedBox(height: AppSpacing.major),
        if (focus == null)
          NoFocusBanner(onChoose: () => _chooseFocus(context, ref))
        else
          AppEntrance(child: FocusProjectCard(project: focus)),
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
          description: 'Proyek tetap aman tanpa memecah fokusmu sekarang.',
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
          const QuietProjectEmpty(label: 'Belum ada proyek yang disimpan dulu.')
        else
          for (final project in parked) ...[
            ProjectOverviewRow(project: project, quiet: true),
            if (project != parked.last)
              const SizedBox(height: AppSpacing.compact),
          ],
        const SizedBox(height: AppSpacing.section),
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: AppColors.guide),
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
      sheetAnimationStyle: AppMotion.sheet(context),
      useRootNavigator: true,
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
                'Proyek ini akan muncul di Hari Ini. Restart Capsule akan membantu mengembalikan konteksnya.',
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
      if (context.mounted) {
        if (!MediaQuery.disableAnimationsOf(context)) {
          await HapticFeedback.mediumImpact();
        }
        if (context.mounted) context.go('/today');
      }
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
      sheetAnimationStyle: AppMotion.sheet(context),
      useRootNavigator: true,
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
                    'Proyek siap dilanjutkan nanti dengan konteks dari Restart Capsule.',
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IdeaInboxShortcut extends StatelessWidget {
  const _IdeaInboxShortcut({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accentSoft,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: () => context.push('/ideas'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Row(
            children: [
              const AppIconBadge(
                icon: Icons.lightbulb_outline_rounded,
                foreground: AppColors.accentDeep,
                background: AppColors.surface,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Idea Inbox',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      count == 0
                          ? 'Tangkap ide tanpa menjadikannya tugas.'
                          : '$count ide menunggu keputusan, bukan pengerjaan.',
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
