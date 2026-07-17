import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';

class GuideFileSummary extends StatelessWidget {
  const GuideFileSummary({required this.document, super.key});

  final GuideDocument document;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.guideSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppIconBadge(
              icon: Icons.picture_as_pdf_outlined,
              foreground: AppColors.guide,
              background: AppColors.surface,
              size: 52,
            ),
            const SizedBox(width: AppSpacing.innerCompact),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'File tersimpan di perangkat',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    document.originalFileName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuideReadingProgress extends StatelessWidget {
  const GuideReadingProgress({required this.document, super.key});

  final GuideDocument document;

  @override
  Widget build(BuildContext context) {
    final progress = document.progress.clamp(0.0, 1.0);
    final percent = (progress * 100).round();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    document.lastReadPage > 1
                        ? 'Terakhir di halaman ${document.lastReadPage}'
                        : 'Siap mulai membaca',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(width: AppSpacing.innerCompact),
                Text(
                  '$percent%',
                  style: AppTextStyles.number.copyWith(color: AppColors.guide),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.innerCompact),
            Semantics(
              label: 'Progres membaca',
              value: '$percent persen',
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                borderRadius: BorderRadius.circular(999),
                color: AppColors.guide,
                backgroundColor: AppColors.surfaceSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuideRecoveryPrompt extends StatelessWidget {
  const GuideRecoveryPrompt({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppNotice(
      icon: Icons.lightbulb_outline_rounded,
      title: 'Buka panduan ini ketika…',
      description: message,
      background: AppColors.guideSoft,
      foreground: AppColors.guide,
    );
  }
}

class GuideLinkedProjectPanel extends StatelessWidget {
  const GuideLinkedProjectPanel({
    required this.projectName,
    required this.isPrimary,
    required this.loading,
    required this.hasError,
    required this.onSetPrimary,
    super.key,
  });

  final String projectName;
  final bool isPrimary;
  final bool loading;
  final bool hasError;
  final VoidCallback? onSetPrimary;

  @override
  Widget build(BuildContext context) {
    return GuideEditorialPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(projectName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.compact),
          Text(
            isPrimary
                ? 'Panduan ini muncul sebagai rujukan utama saat kamu membuka pemulihan arah.'
                : hasError
                ? 'Status panduan utama belum dapat diperiksa.'
                : 'Jadikan panduan utama agar lebih cepat dibuka dari alur pemulihan arah.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.standard),
          OutlinedButton.icon(
            onPressed: onSetPrimary,
            icon: loading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(isPrimary ? Icons.check_rounded : Icons.link_rounded),
            label: Text(
              isPrimary ? 'Panduan utama proyek' : 'Jadikan panduan utama',
            ),
          ),
        ],
      ),
    );
  }
}

class GuideReadingToolsPanel extends StatelessWidget {
  const GuideReadingToolsPanel({
    required this.bookmarkLabel,
    required this.noteLabel,
    super.key,
  });

  final String bookmarkLabel;
  final String noteLabel;

  @override
  Widget build(BuildContext context) {
    return GuideEditorialPanel(
      child: Column(
        children: [
          _ToolRow(icon: Icons.bookmark_border_rounded, label: bookmarkLabel),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.innerCompact),
            child: Divider(height: 1),
          ),
          _ToolRow(icon: Icons.sticky_note_2_outlined, label: noteLabel),
        ],
      ),
    );
  }
}

class _ToolRow extends StatelessWidget {
  const _ToolRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconBadge(
          icon: icon,
          foreground: AppColors.guide,
          background: AppColors.guideSoft,
          size: 42,
        ),
        const SizedBox(width: AppSpacing.innerCompact),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}

class GuideMetadataLabel extends StatelessWidget {
  const GuideMetadataLabel({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.innerCompact,
          vertical: AppSpacing.compact,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.micro),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuideEditorialPanel extends StatelessWidget {
  const GuideEditorialPanel({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: child,
      ),
    );
  }
}

class GuideMissingFileNotice extends StatelessWidget {
  const GuideMissingFileNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppNotice(
      icon: Icons.error_outline_rounded,
      title: 'File tidak ditemukan',
      description:
          'PDF tidak tersedia di penyimpanan aplikasi. Metadata panduan tetap disimpan.',
      background: AppColors.dangerSoft,
      foreground: AppColors.danger,
    );
  }
}

class GuideDetailLoadingState extends StatelessWidget {
  const GuideDetailLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: const [
        AppLoadingBlock(height: 44),
        SizedBox(height: AppSpacing.innerCompact),
        AppLoadingBlock(height: 112),
        SizedBox(height: AppSpacing.section),
        AppLoadingBlock(height: 138),
        SizedBox(height: AppSpacing.innerCompact),
        AppLoadingBlock(height: 56),
      ],
    );
  }
}

class GuideDetailMessageState extends StatelessWidget {
  const GuideDetailMessageState({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: [
        AppNotice(
          icon: icon,
          title: title,
          description: description,
          background: AppColors.guideSoft,
          foreground: AppColors.guide,
        ),
        const SizedBox(height: AppSpacing.standard),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.guide,
            foregroundColor: AppColors.textInverse,
          ),
          onPressed: onAction,
          child: Text(actionLabel),
        ),
      ],
    );
  }
}
