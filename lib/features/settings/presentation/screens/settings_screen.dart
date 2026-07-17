import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/core/widgets/app_primitives.dart';
import 'package:satu_dulu/features/settings/presentation/controllers/settings_providers.dart';
import 'package:satu_dulu/features/settings/presentation/widgets/notification_settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(notificationPreferencesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Pengaturan'),
      ),
      body: preferences.when(
        loading: () => const _SettingsLoading(),
        error: (error, stackTrace) => _SettingsError(
          onRetry: () => ref.invalidate(notificationPreferencesProvider),
        ),
        data: (value) => NotificationSettings(preferences: value),
      ),
    );
  }
}

class _SettingsLoading extends StatelessWidget {
  const _SettingsLoading();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: const [
        AppLoadingBlock(height: 112),
        SizedBox(height: AppSpacing.section),
        AppLoadingBlock(height: 260),
      ],
    );
  }
}

class _SettingsError extends StatelessWidget {
  const _SettingsError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.generous),
      children: [
        const AppNotice(
          icon: Icons.sync_problem_outlined,
          title: 'Pengaturan belum dapat dimuat',
          description: 'Data lokalmu tidak berubah. Coba muat lagi.',
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
        ),
        const SizedBox(height: AppSpacing.standard),
        OutlinedButton(onPressed: onRetry, child: const Text('Muat lagi')),
      ],
    );
  }
}
