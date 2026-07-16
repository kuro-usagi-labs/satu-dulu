import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/core/widgets/screen_frame.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final projects = ref.watch(projectsProvider).value ?? const [];
    if (projects.isEmpty) {
      return ScreenFrame(
        title: strings.resultsTitle,
        subtitle: strings.resultsSubtitle,
        child: const EmptyStateCard(
          icon: Icons.insights_rounded,
          title: 'Belum ada proyek untuk diukur',
          description: 'Buat proyek fokus terlebih dahulu.',
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
    final reviews =
        ref.watch(weeklyReviewsProvider(selected.id)).value ?? const [];
    return ScreenFrame(
      title: strings.resultsTitle,
      subtitle: strings.resultsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            initialValue: selected.id,
            decoration: const InputDecoration(labelText: 'Proyek'),
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
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () =>
                      context.push('/results/metric?project=${selected.id}'),
                  icon: const Icon(Icons.add_chart_rounded),
                  label: const Text('Catat hasil'),
                ),
              ),
              const SizedBox(width: AppSpacing.compact),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      context.push('/results/review?project=${selected.id}'),
                  icon: const Icon(Icons.rate_review_outlined),
                  label: const Text('Review minggu'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          summary.when(
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            error: (error, stackTrace) =>
                const Text('Ringkasan hasil belum dapat dimuat.'),
            data: (value) => _SummaryContent(summary: value),
          ),
          if (projects.length > 1) ...[
            const SizedBox(height: AppSpacing.section),
            _ProjectComparison(projects: projects),
          ],
          if (reviews.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.section),
            Text(
              'Review terakhir',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            _ReviewCard(review: reviews.first),
          ],
        ],
      ),
    );
  }
}

class _ProjectComparison extends ConsumerWidget {
  const _ProjectComparison({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Bandingkan konteks',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.compact),
        Text(
          'Angka membantu melihat pola, bukan menentukan proyek terbaik secara mutlak.',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.innerCompact),
        for (final project in projects.take(3)) ...[
          _ComparisonRow(
            project: project,
            summary: ref.watch(resultsSummaryProvider(project.id)),
          ),
          const SizedBox(height: AppSpacing.compact),
        ],
      ],
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({required this.project, required this.summary});

  final Project project;
  final AsyncValue<ResultsSummary> summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          children: [
            Expanded(child: Text(project.name)),
            summary.when(
              loading: () => const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (error, stackTrace) => const Text('—'),
              data: (value) => Text(
                '${value.outputs} output • ${MoneyUnits.formatMinor(value.revenueMinor)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent({required this.summary});

  final ResultsSummary summary;

  @override
  Widget build(BuildContext context) {
    if (!summary.hasData) {
      return const EmptyStateCard(
        icon: Icons.insights_rounded,
        title: 'Belum ada hasil tercatat',
        description: 'Catat angka kecil setiap hari agar pola mulai terlihat.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _TopMetric(label: 'Output', value: '${summary.outputs}'),
            ),
            const SizedBox(width: AppSpacing.compact),
            Expanded(
              child: _TopMetric(
                label: 'Waktu kerja',
                value: '${(summary.workMinutes / 60).toStringAsFixed(1)} jam',
              ),
            ),
            const SizedBox(width: AppSpacing.compact),
            Expanded(
              child: _TopMetric(
                label: 'Pendapatan',
                value: MoneyUnits.formatMinor(summary.revenueMinor),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.standard),
        Wrap(
          spacing: AppSpacing.compact,
          runSpacing: AppSpacing.compact,
          children: [
            _MetricChip(label: 'Views', value: '${summary.views}'),
            _MetricChip(label: 'Klik', value: '${summary.clicks}'),
            _MetricChip(label: 'Order', value: '${summary.orders}'),
            _MetricChip(
              label: 'Output/minggu',
              value: summary.outputsPerWeek.toStringAsFixed(1),
            ),
            _MetricChip(
              label: 'Konsistensi ship',
              value: '${(summary.shipConsistency * 100).round()}%',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        Text('Output terbaru', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.innerCompact),
        _OutputBars(
          entries: summary.entries.take(7).toList().reversed.toList(),
        ),
        const SizedBox(height: AppSpacing.standard),
        Card(
          color: AppColors.accentSoft,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.standard),
            child: Text(
              summary.hasSmallSample
                  ? 'Data masih sedikit. Gunakan angka ini sebagai petunjuk, bukan kesimpulan mutlak.'
                  : 'Bandingkan tren dengan konteks eksperimen, bukan satu angka saja.',
            ),
          ),
        ),
      ],
    );
  }
}

class _TopMetric extends StatelessWidget {
  const _TopMetric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.innerCompact),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.micro),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    ),
  );
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Chip(label: Text('$label  $value'));
}

class _OutputBars extends StatelessWidget {
  const _OutputBars({required this.entries});
  final List<MetricEntry> entries;

  @override
  Widget build(BuildContext context) {
    final maxValue = entries.fold<int>(1, (max, row) {
      return row.outputsCount > max ? row.outputsCount : max;
    });
    return SizedBox(
      height: 132,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final entry in entries)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${entry.outputsCount}'),
                    const SizedBox(height: AppSpacing.micro),
                    Container(
                      height: 72 * entry.outputsCount / maxValue + 4,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(AppRadius.small),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      DateFormat(
                        'E',
                        'id_ID',
                      ).format(entry.entryDate.toLocal()),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final WeeklyReview review;

  @override
  Widget build(BuildContext context) {
    final decision = switch (review.decision) {
      ReviewDecision.continueFocus => 'Lanjut',
      ReviewDecision.pivot => 'Pivot',
      ReviewDecision.park => 'Parkir',
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keputusan: $decision',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (review.importantResult != null) ...[
              const SizedBox(height: AppSpacing.compact),
              Text(review.importantResult!),
            ],
            if (review.nextWeekFocus != null) ...[
              const SizedBox(height: AppSpacing.compact),
              Text('Berikutnya: ${review.nextWeekFocus!}'),
            ],
          ],
        ),
      ),
    );
  }
}
