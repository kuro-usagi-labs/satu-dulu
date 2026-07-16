import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class StartupScreen extends ConsumerWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);

    return projects.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.generous),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 40,
                  color: AppColors.danger,
                ),
                const SizedBox(height: AppSpacing.standard),
                Text(
                  'Data lokal belum dapat dibuka.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.compact),
                const Text('Coba buka ulang aplikasi. Data tidak dihapus.'),
              ],
            ),
          ),
        ),
      ),
      data: (items) {
        if (items.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/today');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return const _OnboardingPromise();
      },
    );
  }
}

class _OnboardingPromise extends StatelessWidget {
  const _OnboardingPromise();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.generous),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Align(
                alignment: Alignment.centerLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.standard),
                    child: Icon(
                      Icons.center_focus_strong_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.section),
              Text(
                'Banyak ide boleh.\nHari ini tetap satu dulu.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.standard),
              Text(
                'Pilih satu fokus untuk 30 hari, ship satu hasil hari ini, dan simpan ide lain tanpa kehilangan arahnya.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.section),
              const _RuleRow(
                icon: Icons.filter_1_rounded,
                label: 'Satu proyek menjadi fokus utama.',
              ),
              const SizedBox(height: AppSpacing.innerCompact),
              const _RuleRow(
                icon: Icons.rocket_launch_outlined,
                label:
                    'Hasil yang diterbitkan lebih penting dari rencana panjang.',
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.go('/projects/new?onboarding=true'),
                child: const Text('Pilih fokus'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent),
        const SizedBox(width: AppSpacing.innerCompact),
        Expanded(child: Text(label)),
      ],
    );
  }
}
