import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';

class GuideStagedFileSummary extends StatelessWidget {
  const GuideStagedFileSummary({
    required this.fileName,
    required this.details,
    super.key,
  });

  final String fileName;
  final String details;

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
                    fileName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    details,
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

class GuideImportProjectAvailability extends StatelessWidget {
  const GuideImportProjectAvailability({
    required this.loading,
    required this.hasError,
    required this.isEmpty,
    required this.onRetry,
    super.key,
  });

  final bool loading;
  final bool hasError;
  final bool isEmpty;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const _FieldNote(
        icon: Icons.hourglass_top_rounded,
        message: 'Memuat daftar proyek…',
      );
    }
    if (hasError) {
      return _FieldNote(
        icon: Icons.info_outline_rounded,
        message: 'Daftar proyek belum dapat dimuat.',
        actionLabel: 'Coba lagi',
        onAction: onRetry,
      );
    }
    if (isEmpty) {
      return const _FieldNote(
        icon: Icons.info_outline_rounded,
        message: 'Belum ada proyek. Panduan tetap dapat disimpan tanpa proyek.',
      );
    }
    return const SizedBox.shrink();
  }
}

class _FieldNote extends StatelessWidget {
  const _FieldNote({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.micro),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.compact),
          Expanded(
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}

class GuideImportPinPreference extends StatelessWidget {
  const GuideImportPinPreference({
    required this.value,
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: SwitchListTile.adaptive(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.standard,
          vertical: AppSpacing.micro,
        ),
        value: value,
        onChanged: enabled ? onChanged : null,
        secondary: const Icon(Icons.push_pin_outlined, color: AppColors.guide),
        title: const Text('Sematkan di bagian teratas'),
        subtitle: const Text('Cocok untuk panduan yang sering kamu butuhkan.'),
      ),
    );
  }
}
