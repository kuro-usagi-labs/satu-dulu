import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';
import 'package:satu_dulu/features/results/presentation/widgets/results_story.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final projects = ref.watch(projectsProvider);

    return projects.when(
      loading: () => ScreenFrame(
        eyebrow: 'Bukti, bukan tebakan',
        title: strings.resultsTitle,
        subtitle: strings.resultsSubtitle,
        child: const Column(
          children: [
            AppLoadingBlock(height: 64),
            SizedBox(height: AppSpacing.section),
            AppLoadingBlock(height: 220),
          ],
        ),
      ),
      error: (error, stackTrace) => ScreenFrame(
        eyebrow: 'Bukti, bukan tebakan',
        title: strings.resultsTitle,
        subtitle: strings.resultsSubtitle,
        child: _LoadError(
          message: 'Hasil belum dapat dimuat. Data lokalmu tidak berubah.',
          onRetry: () => ref.invalidate(projectsProvider),
        ),
      ),
      data: (items) => _buildWithProjects(context, ref, strings, items),
    );
  }

  Widget _buildWithProjects(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations strings,
    List<Project> projects,
  ) {
    if (projects.isEmpty) {
      return ScreenFrame(
        eyebrow: 'Bukti, bukan tebakan',
        title: strings.resultsTitle,
        subtitle: strings.resultsSubtitle,
        child: EmptyStateCard(
          icon: Icons.insights_outlined,
          title: 'Mulai dari satu fokus',
          description:
              'Buat proyek fokus sebelum mencatat apa yang benar-benar terjadi.',
          actionLabel: 'Buat fokus pertama',
          onAction: () => context.push('/projects/new'),
        ),
      );
    }

    final selectedId = ref.watch(selectedResultsProjectProvider);
    final selected = projects.firstWhere(
      (project) => project.id == selectedId,
      orElse: () => projects.firstWhere(
        (project) => project.status == ProjectStatus.focus,
        orElse: () => projects.first,
      ),
    );
    final summary = ref.watch(resultsSummaryProvider(selected.id));
    final reviews = ref.watch(weeklyReviewsProvider(selected.id));

    return ScreenFrame(
      eyebrow: 'Bukti, bukan tebakan',
      title: strings.resultsTitle,
      subtitle: strings.resultsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            initialValue: selected.id,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Membaca hasil untuk',
              prefixIcon: Icon(Icons.center_focus_strong_outlined),
            ),
            items: [
              for (final project in projects)
                DropdownMenuItem(value: project.id, child: Text(project.name)),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(selectedResultsProjectProvider.notifier).select(value);
              }
            },
          ),
          const SizedBox(height: AppSpacing.standard),
          AppActionButton(
            onPressed: () =>
                context.push('/results/metric?project=${selected.id}'),
            icon: Icons.add_rounded,
            label: 'Catat bukti',
          ),
          const SizedBox(height: AppSpacing.major),
          summary.when(
            loading: () => const Column(
              children: [
                AppLoadingBlock(height: 220),
                SizedBox(height: AppSpacing.section),
                AppLoadingBlock(height: 160),
              ],
            ),
            error: (error, stackTrace) => _LoadError(
              message: 'Ringkasan proyek ini belum dapat dibaca.',
              onRetry: () =>
                  ref.invalidate(resultsSummaryProvider(selected.id)),
            ),
            data: (value) => ResultsStory(
              projectId: selected.id,
              summary: value,
              reviews: reviews,
              projects: projects,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppNotice(
          icon: Icons.sync_problem_outlined,
          title: 'Belum dapat membaca data',
          description: message,
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
        ),
        const SizedBox(height: AppSpacing.standard),
        OutlinedButton(onPressed: onRetry, child: const Text('Muat lagi')),
      ],
    );
  }
}
