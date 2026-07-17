import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/results/domain/entities/result_models.dart';

class ResultsDecisionSection extends StatelessWidget {
  const ResultsDecisionSection({
    required this.projectId,
    required this.reviews,
    super.key,
  });

  final String projectId;
  final AsyncValue<List<WeeklyReview>> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(
          title: 'Keputusan berikutnya',
          description: 'Pilih arah dari bukti, bukan dari rasa bersalah.',
        ),
        const SizedBox(height: AppSpacing.standard),
        reviews.when(
          loading: () => const AppLoadingBlock(height: 150),
          error: (error, stackTrace) => const AppNotice(
            icon: Icons.sync_problem_outlined,
            title: 'Review belum dapat dibaca',
            description: 'Kamu tetap dapat membuat review minggu ini.',
          ),
          data: (items) => items.isEmpty
              ? const AppNotice(
                  icon: Icons.route_outlined,
                  title: 'Belum ada keputusan mingguan',
                  description:
                      'Lihat bukti yang ada, lalu tentukan apakah arah ini dilanjutkan, diubah, atau disimpan dulu.',
                )
              : _ReviewCard(review: items.first),
        ),
        const SizedBox(height: AppSpacing.standard),
        OutlinedButton.icon(
          onPressed: () => context.push('/results/review?project=$projectId'),
          icon: const Icon(Icons.rate_review_outlined),
          label: const Text('Tinjau minggu ini'),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final WeeklyReview review;

  @override
  Widget build(BuildContext context) {
    final decision = switch (review.decision) {
      ReviewDecision.continueFocus => 'Lanjutkan arah ini',
      ReviewDecision.pivot => 'Ubah pendekatan',
      ReviewDecision.park => 'Simpan dulu',
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.guideSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppEyebrow('Keputusan terakhir', color: AppColors.guide),
            const SizedBox(height: AppSpacing.compact),
            Text(decision, style: Theme.of(context).textTheme.headlineMedium),
            if (review.importantResult case final result?) ...[
              const SizedBox(height: AppSpacing.standard),
              Text(result),
            ],
            if (review.nextWeekFocus case final focus?) ...[
              const SizedBox(height: AppSpacing.standard),
              Text(
                'Satu fokus berikutnya',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.micro),
              Text(focus, style: Theme.of(context).textTheme.titleMedium),
            ],
          ],
        ),
      ),
    );
  }
}
