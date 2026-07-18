import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/app/router/app_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/settings/presentation/controllers/settings_providers.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class SatuDuluApp extends ConsumerStatefulWidget {
  const SatuDuluApp({super.key});

  @override
  ConsumerState<SatuDuluApp> createState() => _SatuDuluAppState();
}

class _SatuDuluAppState extends ConsumerState<SatuDuluApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_syncReminders());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_syncReminders());
  }

  Future<void> _syncReminders() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) return;
    try {
      final preferences = await ref
          .read(notificationPreferencesRepositoryProvider)
          .load();
      await ref.read(localNotificationServiceProvider).reschedule(preferences);
    } catch (_) {
      // Reminder settings remain intact and will be retried on the next resume.
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Satu Dulu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
