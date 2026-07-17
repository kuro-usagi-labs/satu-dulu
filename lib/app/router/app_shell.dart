import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/l10n/app_localizations.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.navigation),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
            boxShadow: AppShadows.floating,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.navigation),
            child: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.today_outlined),
                  selectedIcon: const Icon(Icons.today_rounded),
                  label: strings.todayTab,
                  tooltip: 'Mulai dari satu hasil hari ini',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.folder_outlined),
                  selectedIcon: const Icon(Icons.folder_rounded),
                  label: strings.projectsTab,
                  tooltip: 'Atur fokus dan simpan ide lain',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.menu_book_outlined),
                  selectedIcon: const Icon(Icons.menu_book_rounded),
                  label: strings.guidesTab,
                  tooltip: 'Buka panduan saat butuh arah',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.insights_outlined),
                  selectedIcon: const Icon(Icons.insights_rounded),
                  label: strings.resultsTab,
                  tooltip: 'Lihat bukti untuk mengambil keputusan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
