import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/core/widgets/empty_state_card.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';
import 'package:satu_dulu/features/results/presentation/widgets/evidence_sparkline.dart';
import 'package:satu_dulu/features/results/presentation/widgets/results_decision_section.dart';

class ResultsStory extends StatelessWidget {
  const ResultsStory({
    required this.projectId,
    required this.summary,
    required this.reviews,
    required this.projects,
    required this.canReview,
    super.key,
  });

  final String projectId;
  final ResultsSummary summary;
  final AsyncValue<List<WeeklyReview>> reviews;
  final List<Project> projects;
  final bool canReview;

  @override
  Widget build(BuildContext context) {
    if (!summary.hasData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EmptyStateCard(
            icon: Icons.fact_check_outlined,
            title: 'Belum ada hasil tercatat',
            description:
                'Catat angka yang kamu tahu. Tidak perlu menunggu hasil besar.',
          ),
          const SizedBox(height: AppSpacing.section),
          ResultsDecisionSection(
            projectId: projectId,
            reviews: reviews,
            canReview: canReview,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppEntrance(child: _EvidenceSection(summary: summary)),
        const SizedBox(height: AppSpacing.screen),
        _LearningSection(summary: summary),
        if (projects.length > 1) ...[
          const SizedBox(height: AppSpacing.section),
          _ProjectComparison(projects: projects),
        ],
        const SizedBox(height: AppSpacing.screen),
        ResultsDecisionSection(
          projectId: projectId,
          reviews: reviews,
          canReview: canReview,
        ),
      ],
    );
  }
}

class _EvidenceSection extends StatelessWidget {
  const _EvidenceSection({required this.summary});

  final ResultsSummary summary;

  @override
  Widget build(BuildContext context) {
    final recent = summary.entries.take(4).toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(
          title: 'Bukti yang terkumpul',
          description: 'Apa yang benar-benar sudah keluar dan terjadi.',
        ),
        const SizedBox(height: AppSpacing.standard),
        AppEvidenceCard(
          padding: const EdgeInsets.all(AppSpacing.section),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppEyebrow('Putaran ini', color: AppColors.evidenceMuted),
              const SizedBox(height: AppSpacing.compact),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: AppSpacing.innerCompact,
                runSpacing: AppSpacing.micro,
                children: [
                  Text(
                    '${summary.outputs}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.onEvidence,
                      fontSize: 52,
                      height: 1,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text(
                    'hasil terbit',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.onEvidence,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.section),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth < 320
                      ? constraints.maxWidth
                      : (constraints.maxWidth - AppSpacing.standard) / 2;
                  return Wrap(
                    spacing: AppSpacing.standard,
                    runSpacing: AppSpacing.standard,
                    children: [
                      SizedBox(
                        width: itemWidth,
                        child: _FactRow(
                          icon: Icons.schedule_outlined,
                          label: 'Waktu kerja',
                          value: _formatDuration(summary.workMinutes),
                          inverse: true,
                        ),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: _FactRow(
                          icon: Icons.payments_outlined,
                          label: 'Nilai tercatat',
                          value: MoneyUnits.formatMinor(summary.revenueMinor),
                          inverse: true,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.section),
              EvidenceSparkline(entries: summary.entries),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        Text('Bukti terbaru', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.compact),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.standard),
            child: Column(
              children: [
                for (var index = 0; index < recent.length; index++) ...[
                  _EvidenceEntry(entry: recent[index]),
                  if (index != recent.length - 1) const Divider(height: 25),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _formatDuration(int minutes) {
    if (minutes < 60) return '$minutes menit';
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return rest == 0 ? '$hours jam' : '$hours jam $rest menit';
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.inverse = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: inverse ? AppColors.evidenceMuted : AppColors.textSecondary,
        ),
        const SizedBox(width: AppSpacing.innerCompact),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: inverse
                      ? AppColors.evidenceMuted
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.micro),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: inverse ? AppColors.onEvidence : AppColors.textPrimary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EvidenceEntry extends StatelessWidget {
  const _EvidenceEntry({required this.entry});

  final MetricEntry entry;

  @override
  Widget build(BuildContext context) {
    final details = <String>[
      if (entry.views != null) '${entry.views} tayangan',
      if (entry.clicks != null) '${entry.clicks} klik',
      if (entry.orders != null) '${entry.orders} order',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.compact),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: AppColors.action,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.innerCompact),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat(
                    'EEEE, d MMM',
                    'id_ID',
                  ).format(entry.entryDate.toLocal()),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.micro),
                Text(
                  '${entry.outputsCount} output',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (details.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    details.join(' · '),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                if (entry.note case final note?) ...[
                  const SizedBox(height: AppSpacing.compact),
                  Text(note, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningSection extends StatelessWidget {
  const _LearningSection({required this.summary});

  final ResultsSummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(
          title: 'Apa yang datanya katakan?',
          description: 'Baca pola perlahan. Angka kecil belum menjadi vonis.',
        ),
        const SizedBox(height: AppSpacing.standard),
        if (summary.hasSmallSample) ...[
          const AppNotice(
            icon: Icons.hourglass_top_rounded,
            title: 'Masih terlalu dini untuk menyimpulkan',
            description:
                'Terus catat bukti. Gunakan pola ini sebagai petunjuk sementara.',
          ),
          const SizedBox(height: AppSpacing.standard),
        ],
        AppFocusCard(
          padding: const EdgeInsets.all(AppSpacing.standard),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppEyebrow('Petunjuk sementara'),
              const SizedBox(height: AppSpacing.standard),
              _InsightRow(
                title: 'Ritme pengiriman',
                value:
                    '${summary.outputsPerWeek.toStringAsFixed(1)} output/minggu',
                description:
                    'Rata-rata berdasarkan rentang hari yang sudah dicatat.',
              ),
              const Divider(height: 33),
              _InsightRow(
                title: 'Hari dengan output',
                value: '${(summary.shipConsistency * 100).round()}%',
                description: 'Dari hari yang memiliki catatan hasil.',
              ),
              const Divider(height: 33),
              _InsightRow(
                title: 'Respons yang tercatat',
                value: summary.views == 0
                    ? 'Belum ada data respons'
                    : '${summary.views} tayangan → ${summary.clicks} klik → ${summary.orders} order',
                description: summary.views == 0
                    ? 'Tambahkan tayangan atau respons saat angkanya tersedia.'
                    : 'Lihat urutannya; jangan menilai dari satu angka saja.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({
    required this.title,
    required this.value,
    required this.description,
  });

  final String title;
  final String value;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.micro),
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.micro),
        Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
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
        const AppSectionHeader(
          title: 'Konteks antar proyek',
          description:
              'Perbandingan membantu bertanya, bukan memilih pemenang.',
        ),
        const SizedBox(height: AppSpacing.standard),
        for (var index = 0; index < projects.take(3).length; index++) ...[
          _ComparisonRow(
            project: projects[index],
            summary: ref.watch(resultsSummaryProvider(projects[index].id)),
          ),
          if (index != projects.take(3).length - 1)
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.micro),
            summary.when(
              loading: () => const LinearProgressIndicator(minHeight: 2),
              error: (error, stackTrace) => Text(
                'Ringkasan belum tersedia',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              data: (value) => Text(
                '${value.outputs} output · ${MoneyUnits.formatMinor(value.revenueMinor)}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
