import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/onboarding/presentation/widgets/onboarding_pages.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';

class StartupScreen extends ConsumerWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);

    return projects.when(
      loading: () => const _StartupLoading(),
      error: (error, stackTrace) =>
          _StartupError(onRetry: () => ref.invalidate(projectsProvider)),
      data: (items) {
        if (items.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/today');
          });
          return const _StartupLoading();
        }
        return _OnboardingFlow(
          onFinish: () => context.go('/projects/new?onboarding=true'),
        );
      },
    );
  }
}

class _StartupLoading extends StatelessWidget {
  const _StartupLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.generous),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WordMark(),
              Spacer(),
              AppLoadingBlock(height: 184),
              SizedBox(height: AppSpacing.standard),
              AppLoadingBlock(height: 58),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _StartupError extends StatelessWidget {
  const _StartupError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.generous),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _WordMark(),
              const Spacer(),
              const AppIconBadge(
                icon: Icons.lock_clock_outlined,
                foreground: AppColors.danger,
                background: AppColors.dangerSoft,
                size: 56,
              ),
              const SizedBox(height: AppSpacing.section),
              Text(
                'Data lokal belum dapat dibuka',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.compact),
              Text(
                'Data tidak dihapus. Coba muat lagi atau buka ulang aplikasi.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.section),
              FilledButton(onPressed: onRetry, child: const Text('Muat lagi')),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingFlow extends StatefulWidget {
  const _OnboardingFlow({required this.onFinish});

  final VoidCallback onFinish;

  @override
  State<_OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<_OnboardingFlow> {
  final _pageController = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.generous,
                AppSpacing.standard,
                AppSpacing.generous,
                0,
              ),
              child: _WordMark(),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _page = value),
                children: const [
                  OnboardingPromisePage(),
                  OnboardingHowItWorksPage(),
                  OnboardingSpacesPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.generous,
                AppSpacing.innerCompact,
                AppSpacing.generous,
                AppSpacing.generous,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      for (var index = 0; index < 3; index++) ...[
                        AnimatedContainer(
                          duration: reduceMotion
                              ? Duration.zero
                              : AppDuration.stateChange,
                          width: index == _page ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == _page
                                ? AppColors.accent
                                : AppColors.border,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        if (index < 2)
                          const SizedBox(width: AppSpacing.compact),
                      ],
                      const Spacer(),
                      Text(
                        '${_page + 1} dari 3',
                        style: AppTextStyles.number.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.standard),
                  FilledButton.icon(
                    onPressed: _page == 2 ? widget.onFinish : _next,
                    icon: Icon(
                      _page == 2
                          ? Icons.arrow_forward_rounded
                          : Icons.chevron_right_rounded,
                    ),
                    label: Text(_page == 2 ? 'Pilih fokus' : 'Lanjut'),
                  ),
                  if (_page < 2)
                    TextButton(
                      onPressed: widget.onFinish,
                      child: const Text('Langsung pilih fokus'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _next() {
    _pageController.nextPage(
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : AppDuration.card,
      curve: Curves.easeOutCubic,
    );
  }
}

class _WordMark extends StatelessWidget {
  const _WordMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: 6,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.compact),
        Text(
          'satu dulu',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
