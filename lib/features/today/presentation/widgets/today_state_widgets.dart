import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';

class TodayLoading extends StatelessWidget {
  const TodayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppLoadingBlock(height: 320),
        SizedBox(height: AppSpacing.major),
        AppLoadingBlock(height: 72),
        SizedBox(height: AppSpacing.compact),
        AppLoadingBlock(height: 72),
      ],
    );
  }
}

class PostShipCard extends StatelessWidget {
  const PostShipCard({required this.onAddEvidence, super.key});

  final VoidCallback onAddEvidence;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.successSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.success),
            const SizedBox(width: AppSpacing.innerCompact),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hasil hari ini sudah tercatat',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    'Punya views, order, pendapatan, atau waktu kerja? Tambahkan sebagai bukti, bukan kewajiban.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.compact),
                  TextButton.icon(
                    onPressed: onAddEvidence,
                    icon: const Icon(Icons.add_chart_rounded),
                    label: const Text('Catat angka hasil'),
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

class RecoveryShortcut extends StatelessWidget {
  const RecoveryShortcut({
    required this.hasGuide,
    required this.onTap,
    super.key,
  });

  final bool hasGuide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Aku Lupa Arah',
      hint: 'Lihat tujuan dan satu tindakan berikutnya',
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.standard),
          decoration: BoxDecoration(
            color: AppColors.guideSoft,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            children: [
              const AppIconBadge(
                icon: Icons.explore_outlined,
                foreground: AppColors.guide,
                background: AppColors.surface,
              ),
              const SizedBox(width: AppSpacing.innerCompact),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aku Lupa Arah',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.micro),
                    Text(
                      hasGuide
                          ? 'Ingat tujuan, lihat langkah terkecil, atau buka panduan.'
                          : 'Ingat tujuan dan lihat satu langkah terkecil.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.compact),
              const Icon(Icons.arrow_forward_rounded, color: AppColors.guide),
            ],
          ),
        ),
      ),
    );
  }
}
