import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';

class GuideSection extends StatelessWidget {
  const GuideSection({
    required this.title,
    required this.description,
    required this.items,
    super.key,
  });

  final String title;
  final String description;
  final List<GuideDocument> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: title, description: description),
        const SizedBox(height: AppSpacing.innerCompact),
        for (final document in items) ...[
          GuideCard(document: document),
          if (document != items.last)
            const SizedBox(height: AppSpacing.innerCompact),
        ],
      ],
    );
  }
}

class GuideCard extends StatelessWidget {
  const GuideCard({required this.document, super.key});

  final GuideDocument document;

  @override
  Widget build(BuildContext context) {
    final hasProgress = document.lastReadPage > 1;
    final progress = document.progress.clamp(0.0, 1.0);
    final contextParts = [
      document.category,
      document.projectName,
    ].whereType<String>().where((value) => value.isNotEmpty).toList();
    final contextLabel = contextParts.join(' • ');
    final readingLabel = hasProgress
        ? 'Halaman ${document.lastReadPage} dari ${document.pageCount}'
        : '${document.pageCount} halaman • belum dibaca';

    return Semantics(
      button: true,
      label: 'Buka panduan ${document.displayTitle}',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.card),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => context.push('/guides/${document.id}'),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.standard),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 72,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.guideSoft,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: const Icon(
                      Icons.auto_stories_outlined,
                      color: AppColors.guide,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.innerCompact),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.displayTitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.compact),
                        Wrap(
                          spacing: AppSpacing.compact,
                          runSpacing: AppSpacing.micro,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (contextLabel.isNotEmpty)
                              Text(
                                contextLabel,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            if (document.isPinned) const _PinnedLabel(),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.innerCompact),
                        Text(
                          readingLabel,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textTertiary),
                        ),
                        if (hasProgress) ...[
                          const SizedBox(height: AppSpacing.compact),
                          Semantics(
                            label: 'Progres membaca',
                            value: '${(progress * 100).round()} persen',
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 4,
                              borderRadius: BorderRadius.circular(999),
                              backgroundColor: AppColors.surfaceSecondary,
                              color: AppColors.guide,
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
        ),
      ),
    );
  }
}

class _PinnedLabel extends StatelessWidget {
  const _PinnedLabel();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.guideSoft,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.compact,
          vertical: AppSpacing.micro,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.push_pin_outlined,
              size: 14,
              color: AppColors.guide,
            ),
            const SizedBox(width: AppSpacing.micro),
            Flexible(
              child: Text(
                'Disematkan',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.guide),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuideLoadingState extends StatelessWidget {
  const GuideLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppLoadingBlock(height: 142),
        SizedBox(height: AppSpacing.innerCompact),
        AppLoadingBlock(height: 142),
        SizedBox(height: AppSpacing.innerCompact),
        AppLoadingBlock(height: 142),
      ],
    );
  }
}

class GuideMessagePanel extends StatelessWidget {
  const GuideMessagePanel({
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppIconBadge(
                icon: icon,
                foreground: AppColors.guide,
                background: AppColors.guideSoft,
              ),
            ),
            const SizedBox(height: AppSpacing.standard),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.compact),
            Text(
              description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.standard),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
