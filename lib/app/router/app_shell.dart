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
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            destinations: [
              NavigationDestination(
                icon: const _NavigationIcon(icon: Icons.today_outlined),
                selectedIcon: const _NavigationIcon(
                  icon: Icons.today_rounded,
                  selected: true,
                ),
                label: strings.todayTab,
                tooltip: 'Mulai dari satu hasil hari ini',
              ),
              NavigationDestination(
                icon: const _NavigationIcon(icon: Icons.folder_outlined),
                selectedIcon: const _NavigationIcon(
                  icon: Icons.folder_rounded,
                  selected: true,
                ),
                label: strings.projectsTab,
                tooltip: 'Atur fokus dan simpan ide lain',
              ),
              NavigationDestination(
                icon: const _NavigationIcon(icon: Icons.menu_book_outlined),
                selectedIcon: const _NavigationIcon(
                  icon: Icons.menu_book_rounded,
                  selected: true,
                ),
                label: strings.guidesTab,
                tooltip: 'Buka panduan saat butuh arah',
              ),
              NavigationDestination(
                icon: const _NavigationIcon(icon: Icons.insights_outlined),
                selectedIcon: const _NavigationIcon(
                  icon: Icons.insights_rounded,
                  selected: true,
                ),
                label: strings.resultsTab,
                tooltip: 'Lihat bukti untuk mengambil keputusan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationIcon extends StatelessWidget {
  const _NavigationIcon({required this.icon, this.selected = false});

  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 30,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Icon(icon),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : AppDuration.tap,
              width: selected ? 18 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: selected ? AppColors.action : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
