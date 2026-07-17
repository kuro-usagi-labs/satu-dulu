import 'package:flutter/material.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';

class OnboardingPromisePage extends StatelessWidget {
  const OnboardingPromisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.generous,
        AppSpacing.screen,
        AppSpacing.generous,
        AppSpacing.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppEyebrow('Pendamping fokus personal'),
          const SizedBox(height: AppSpacing.innerCompact),
          Text(
            'Banyak ide boleh.\nHari ini tetap satu dulu.',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: AppSpacing.standard),
          Text(
            'Satu Dulu membantumu memilih arah, menyelesaikan satu hasil, lalu melihat buktinya—tanpa daftar tugas yang tidak habis-habis.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.major),
          const _FocusComposition(),
        ],
      ),
    );
  }
}

class _FocusComposition extends StatelessWidget {
  const _FocusComposition();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: Stack(
        children: [
          Positioned(
            left: 30,
            right: 8,
            top: 8,
            child: Container(
              height: 116,
              decoration: BoxDecoration(
                color: AppColors.canvasDeep,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 20,
            top: 28,
            child: Container(
              height: 116,
              decoration: BoxDecoration(
                color: AppColors.guideSoft,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 34,
            top: 48,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.standard),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.hero),
                boxShadow: AppShadows.card,
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 70,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: AppSpacing.compact),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Text(
                      '01',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.standard),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppEyebrow('Hari ini'),
                        const SizedBox(height: AppSpacing.micro),
                        Text(
                          'Satu hasil yang benar-benar dikirim',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
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

class OnboardingHowItWorksPage extends StatelessWidget {
  const OnboardingHowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.generous,
        AppSpacing.screen,
        AppSpacing.generous,
        AppSpacing.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppEyebrow('Cara kerjanya'),
          const SizedBox(height: AppSpacing.innerCompact),
          Text(
            'Bukan daftar tugas.\nIni alur untuk selesai.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.section),
          const AppStepRow(
            number: 1,
            title: 'Pilih satu fokus',
            description:
                'Ide lain tetap aman, tetapi hanya satu yang memimpin 30 hari ini.',
            highlighted: true,
          ),
          const AppStepRow(
            number: 2,
            title: 'Kerjakan langkah berikutnya',
            description:
                'Satu hasil harian dipecah menjadi paling banyak tiga langkah.',
          ),
          const AppStepRow(
            number: 3,
            title: 'Ship dan lihat bukti',
            description:
                'Catat yang benar-benar dikirim, lalu review tanpa rasa bersalah.',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class OnboardingSpacesPage extends StatelessWidget {
  const OnboardingSpacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.generous,
        AppSpacing.screen,
        AppSpacing.generous,
        AppSpacing.section,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppEyebrow('Empat ruang'),
          const SizedBox(height: AppSpacing.innerCompact),
          Text(
            'Kamu selalu tahu harus membuka yang mana.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.section),
          const _SpaceRow(
            icon: Icons.today_rounded,
            title: 'Hari Ini',
            description: 'Mulai dan selesaikan satu hasil.',
            emphasized: true,
          ),
          const _SpaceRow(
            icon: Icons.folder_rounded,
            title: 'Proyek',
            description: 'Pilih fokus; simpan ide lain tanpa gangguan.',
          ),
          const _SpaceRow(
            icon: Icons.menu_book_rounded,
            title: 'Panduan',
            description: 'Buka rujukan saat kamu kehilangan arah.',
          ),
          const _SpaceRow(
            icon: Icons.insights_rounded,
            title: 'Hasil',
            description: 'Gunakan bukti untuk lanjut, ubah, atau simpan dulu.',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _SpaceRow extends StatelessWidget {
  const _SpaceRow({
    required this.icon,
    required this.title,
    required this.description,
    this.emphasized = false,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool emphasized;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.standard),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconBadge(
            icon: icon,
            size: 46,
            foreground: emphasized
                ? AppColors.textInverse
                : AppColors.textPrimary,
            background: emphasized
                ? AppColors.accent
                : AppColors.surfaceSecondary,
          ),
          const SizedBox(width: AppSpacing.standard),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
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
