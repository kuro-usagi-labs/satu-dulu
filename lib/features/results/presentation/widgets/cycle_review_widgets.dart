import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';
import 'package:satu_dulu/features/results/domain/services/money_units.dart';

class CycleEvidenceSnapshot extends StatelessWidget {
  const CycleEvidenceSnapshot({required this.summary, super.key});

  final ResultsSummary summary;

  @override
  Widget build(BuildContext context) {
    final compactNumber = NumberFormat.compact(locale: 'id_ID');
    return AppEvidenceCard(
      padding: const EdgeInsets.all(AppSpacing.standard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppEyebrow('BUKTI PUTARAN INI', color: AppColors.action),
          const SizedBox(height: AppSpacing.compact),
          Text(
            summary.hasData
                ? 'Yang benar-benar terjadi'
                : 'Belum ada angka tercatat',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.onEvidence),
          ),
          const SizedBox(height: AppSpacing.micro),
          Text(
            summary.hasData
                ? 'Snapshot ini hanya membaca tanggal di dalam putaran.'
                : 'Kamu tetap boleh memilih arah. Tidak ada angka juga merupakan informasi.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.evidenceMuted),
          ),
          const SizedBox(height: AppSpacing.standard),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - AppSpacing.innerCompact) / 2;
              return Wrap(
                spacing: AppSpacing.innerCompact,
                runSpacing: AppSpacing.innerCompact,
                children: [
                  _EvidenceMetric(
                    width: itemWidth,
                    label: 'Output',
                    value: compactNumber.format(summary.outputs),
                  ),
                  _EvidenceMetric(
                    width: itemWidth,
                    label: 'Tayangan',
                    value: compactNumber.format(summary.views),
                  ),
                  _EvidenceMetric(
                    width: itemWidth,
                    label: 'Pesanan',
                    value: compactNumber.format(summary.orders),
                  ),
                  _EvidenceMetric(
                    width: itemWidth,
                    label: 'Waktu kerja',
                    value: _workTime(summary.workMinutes),
                  ),
                  _EvidenceMetric(
                    width: itemWidth,
                    label: 'Omzet',
                    value: MoneyUnits.formatMinor(summary.revenueMinor),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _workTime(int minutes) {
    if (minutes < 60) return '$minutes mnt';
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    return remainder == 0 ? '$hours jam' : '$hours j $remainder m';
  }
}

class _EvidenceMetric extends StatelessWidget {
  const _EvidenceMetric({
    required this.width,
    required this.label,
    required this.value,
  });

  final double width;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label, $value',
      excludeSemantics: true,
      child: SizedBox(
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.onEvidence.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.innerCompact),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.evidenceMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.micro),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onEvidence,
                    fontWeight: FontWeight.w800,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CycleDecisionCard extends StatelessWidget {
  const CycleDecisionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? AppColors.onEvidence : AppColors.textPrimary;
    final secondary = selected
        ? AppColors.evidenceMuted
        : AppColors.textSecondary;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.evidence : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? AppColors.evidence : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.standard),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: selected ? AppColors.action : secondary,
                  ),
                  const SizedBox(width: AppSpacing.innerCompact),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: foreground),
                        ),
                        const SizedBox(height: AppSpacing.micro),
                        Text(
                          description,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: secondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.compact),
                  Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    size: 22,
                    color: selected ? AppColors.action : AppColors.border,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ParkReplacementPicker extends StatelessWidget {
  const ParkReplacementPicker({
    required this.projects,
    required this.currentProjectId,
    required this.selectedProjectId,
    required this.onSelected,
    required this.onRetry,
    super.key,
  });

  final AsyncValue<List<Project>> projects;
  final String currentProjectId;
  final String? selectedProjectId;
  final ValueChanged<String?> onSelected;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(
          title: 'Fokus setelah ini',
          description:
              'Pilih proyek pengganti, atau simpan dulu tanpa memilih fokus.',
        ),
        const SizedBox(height: AppSpacing.standard),
        _ReplacementOption(
          title: 'Belum pilih sekarang',
          description: 'Kembali ke Proyek dan pilih saat kamu sudah siap.',
          selected: selectedProjectId == null,
          onTap: () => onSelected(null),
          icon: Icons.pause_circle_outline_rounded,
        ),
        projects.when(
          loading: () => const Padding(
            padding: EdgeInsets.only(top: AppSpacing.compact),
            child: AppLoadingBlock(height: 64),
          ),
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.only(top: AppSpacing.compact),
            child: AppNotice(
              icon: Icons.sync_problem_outlined,
              title: 'Daftar proyek belum terbaca',
              description:
                  'Kamu tetap bisa memilih “Belum pilih sekarang” dan melanjutkan.',
            ),
          ),
          data: (items) {
            final candidates = items
                .where(
                  (project) =>
                      project.id != currentProjectId &&
                      project.status != ProjectStatus.archived,
                )
                .toList();
            if (candidates.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSpacing.compact),
                child: Text(
                  'Belum ada proyek lain yang bisa dijadikan fokus.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }
            return Column(
              children: [
                for (final project in candidates) ...[
                  const SizedBox(height: AppSpacing.compact),
                  _ReplacementOption(
                    title: project.name,
                    description: _projectStatusLabel(project.status),
                    selected: selectedProjectId == project.id,
                    onTap: () => onSelected(project.id),
                    icon: Icons.folder_outlined,
                  ),
                ],
              ],
            );
          },
        ),
        if (projects.hasError) ...[
          const SizedBox(height: AppSpacing.compact),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Muat daftar lagi'),
            ),
          ),
        ],
      ],
    );
  }

  String _projectStatusLabel(ProjectStatus status) => switch (status) {
    ProjectStatus.focus => 'Fokus aktif',
    ProjectStatus.maintenance => 'Sedang dirawat',
    ProjectStatus.parkingLot => 'Tersimpan di Parking Lot',
    ProjectStatus.archived => 'Diarsipkan',
  };
}

class _ReplacementOption extends StatelessWidget {
  const _ReplacementOption({
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.actionSoft : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.innerCompact),
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? AppColors.action : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
            child: Row(
              children: [
                Icon(icon, size: 22, color: AppColors.textSecondary),
                const SizedBox(width: AppSpacing.innerCompact),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
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
                const SizedBox(width: AppSpacing.compact),
                Icon(
                  selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: selected ? AppColors.actionDeep : AppColors.border,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CycleReviewMessage extends StatelessWidget {
  const CycleReviewMessage({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
    this.tone = AppStatusTone.neutral,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;
  final AppStatusTone tone;

  @override
  Widget build(BuildContext context) {
    final palette = switch (tone) {
      AppStatusTone.success => (
        background: AppColors.successSoft,
        foreground: AppColors.success,
      ),
      AppStatusTone.warning => (
        background: AppColors.warningSoft,
        foreground: AppColors.warning,
      ),
      AppStatusTone.danger => (
        background: AppColors.dangerSoft,
        foreground: AppColors.danger,
      ),
      _ => (
        background: AppColors.surfaceSecondary,
        foreground: AppColors.textPrimary,
      ),
    };

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.generous),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppIconBadge(
                    icon: icon,
                    foreground: palette.foreground,
                    background: palette.background,
                  ),
                ),
                const SizedBox(height: AppSpacing.standard),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.compact),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.section),
                OutlinedButton(onPressed: onAction, child: Text(actionLabel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
