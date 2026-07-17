import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';

class GuideReaderLoading extends StatelessWidget {
  const GuideReaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.generous),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppSpacing.major),
              AppLoadingBlock(height: 56),
              SizedBox(height: AppSpacing.section),
              Expanded(child: AppLoadingBlock()),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideReaderUnavailable extends StatelessWidget {
  const GuideReaderUnavailable({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _leaveReader(context),
          tooltip: 'Kembali ke Panduan',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Pembaca panduan'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.generous),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppIconBadge(
                icon: Icons.picture_as_pdf_outlined,
                foreground: AppColors.danger,
                background: AppColors.dangerSoft,
                size: 56,
              ),
              const SizedBox(height: AppSpacing.section),
              Text(
                'Panduan belum dapat dibuka',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.compact),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.section),
              FilledButton.icon(
                onPressed: () => _leaveReader(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Kembali ke Panduan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _leaveReader(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/guides');
    }
  }
}

class GuideReaderProgress extends StatelessWidget {
  const GuideReaderProgress({this.value, super.key});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.section),
          child: SizedBox.square(
            dimension: 30,
            child: CircularProgressIndicator.adaptive(value: value),
          ),
        ),
      ),
    );
  }
}

class GuideReaderErrorCard extends StatelessWidget {
  const GuideReaderErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.generous),
        child: AppNotice(
          icon: Icons.broken_image_outlined,
          title: 'PDF tidak dapat dibaca',
          description:
              'File mungkin rusak atau dilindungi password. Coba impor salinan PDF lain.',
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
        ),
      ),
    );
  }
}
