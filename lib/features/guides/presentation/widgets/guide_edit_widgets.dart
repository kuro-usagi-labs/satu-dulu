import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';

class GuideOriginalFileNotice extends StatelessWidget {
  const GuideOriginalFileNotice({required this.fileName, super.key});

  final String fileName;

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
              size: 48,
            ),
            const SizedBox(width: AppSpacing.innerCompact),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'File asli tetap sama',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    fileName,
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

class GuideEditProjectAvailability extends StatelessWidget {
  const GuideEditProjectAvailability({
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
      return const _EditFieldNote(
        icon: Icons.hourglass_top_rounded,
        message: 'Memuat daftar proyek…',
      );
    }
    if (hasError) {
      return _EditFieldNote(
        icon: Icons.info_outline_rounded,
        message: 'Daftar proyek belum dapat dimuat.',
        actionLabel: 'Coba lagi',
        onAction: onRetry,
      );
    }
    if (isEmpty) {
      return const _EditFieldNote(
        icon: Icons.info_outline_rounded,
        message: 'Belum ada proyek aktif untuk dihubungkan.',
      );
    }
    return const SizedBox.shrink();
  }
}

class _EditFieldNote extends StatelessWidget {
  const _EditFieldNote({
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

class GuideEditPinPreference extends StatelessWidget {
  const GuideEditPinPreference({
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
        subtitle: const Text('Tampilkan lebih awal di pustaka panduan.'),
      ),
    );
  }
}

class GuideEditStateScaffold extends StatelessWidget {
  const GuideEditStateScaffold.loading({super.key})
    : title = null,
      description = null,
      actionLabel = null,
      onAction = null;

  const GuideEditStateScaffold.message({
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  bool get isLoading => title == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Edit panduan'),
      ),
      body: isLoading
          ? ListView(
              padding: const EdgeInsets.all(AppSpacing.generous),
              children: const [
                AppLoadingBlock(height: 92),
                SizedBox(height: AppSpacing.section),
                AppLoadingBlock(height: 188),
                SizedBox(height: AppSpacing.innerCompact),
                AppLoadingBlock(height: 188),
              ],
            )
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.generous),
              children: [
                AppNotice(
                  icon: Icons.menu_book_outlined,
                  title: title!,
                  description: description!,
                  background: AppColors.guideSoft,
                  foreground: AppColors.guide,
                ),
                const SizedBox(height: AppSpacing.standard),
                FilledButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ),
    );
  }
}
