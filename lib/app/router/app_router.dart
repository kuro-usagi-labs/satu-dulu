import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:satu_dulu/app/router/app_shell.dart';
import 'package:satu_dulu/app/theme/app_theme.dart';
import 'package:satu_dulu/features/anti_forget/presentation/screens/daily_check_in_screen.dart';
import 'package:satu_dulu/features/anti_forget/presentation/screens/idea_inbox_screen.dart';
import 'package:satu_dulu/features/anti_forget/presentation/screens/restart_capsule_screen.dart';
import 'package:satu_dulu/features/guides/domain/entities/guide_models.dart';
import 'package:satu_dulu/features/guides/presentation/screens/guide_detail_screen.dart';
import 'package:satu_dulu/features/guides/presentation/screens/guide_edit_screen.dart';
import 'package:satu_dulu/features/guides/presentation/screens/guide_import_screen.dart';
import 'package:satu_dulu/features/guides/presentation/screens/guide_reader_screen.dart';
import 'package:satu_dulu/features/guides/presentation/screens/guides_screen.dart';
import 'package:satu_dulu/features/onboarding/presentation/screens/startup_screen.dart';
import 'package:satu_dulu/features/projects/presentation/screens/create_project_screen.dart';
import 'package:satu_dulu/features/projects/presentation/screens/edit_project_screen.dart';
import 'package:satu_dulu/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:satu_dulu/features/projects/presentation/screens/projects_screen.dart';
import 'package:satu_dulu/features/results/presentation/screens/metric_entry_screen.dart';
import 'package:satu_dulu/features/results/presentation/screens/results_screen.dart';
import 'package:satu_dulu/features/results/presentation/screens/weekly_review_screen.dart';
import 'package:satu_dulu/features/settings/presentation/screens/settings_screen.dart';
import 'package:satu_dulu/features/today/presentation/screens/create_daily_plan_screen.dart';
import 'package:satu_dulu/features/today/presentation/screens/today_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    errorBuilder: (context, state) => _RouteProblemScreen(
      title: 'Halaman tidak ditemukan',
      description:
          'Tautan ini tidak lengkap atau sudah tidak berlaku. Kembali ke Hari Ini untuk melanjutkan.',
    ),
    routes: [
      GoRoute(
        path: '/',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const StartupScreen(),
      ),
      GoRoute(
        path: '/ideas',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const IdeaInboxScreen(),
      ),
      GoRoute(
        path: '/check-in',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DailyCheckInScreen(),
      ),
      GoRoute(
        path: '/projects/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => CreateProjectScreen(
          onboarding: state.uri.queryParameters['onboarding'] == 'true',
        ),
      ),
      GoRoute(
        path: '/projects/:projectId/restart',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => RestartCapsuleScreen(
          projectId: state.pathParameters['projectId']!,
        ),
      ),
      GoRoute(
        path: '/projects/:projectId/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            EditProjectScreen(projectId: state.pathParameters['projectId']!),
      ),
      GoRoute(
        path: '/projects/:projectId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            ProjectDetailScreen(projectId: state.pathParameters['projectId']!),
      ),
      GoRoute(
        path: '/today/plan',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreateDailyPlanScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/results/metric',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final projectId = state.uri.queryParameters['project']?.trim();
          return projectId == null || projectId.isEmpty
              ? const _RouteProblemScreen(
                  title: 'Proyek belum dipilih',
                  description:
                      'Buka Hasil lalu pilih proyek yang ingin diberi bukti.',
                )
              : MetricEntryScreen(
                  projectId: projectId,
                  fromShip: state.uri.queryParameters['source'] == 'ship',
                );
        },
      ),
      GoRoute(
        path: '/results/review',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final projectId = state.uri.queryParameters['project']?.trim();
          return projectId == null || projectId.isEmpty
              ? const _RouteProblemScreen(
                  title: 'Proyek belum dipilih',
                  description:
                      'Buka Hasil lalu pilih proyek yang ingin direview.',
                )
              : WeeklyReviewScreen(projectId: projectId);
        },
      ),
      GoRoute(
        path: '/guides/import',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final staged = state.extra;
          return staged is StagedGuideFile
              ? GuideImportScreen(staged: staged)
              : const _RouteProblemScreen(
                  title: 'Pilih PDF dari Panduan',
                  description:
                      'File belum dipilih. Kembali ke Panduan lalu ketuk Impor PDF panduan.',
                );
        },
      ),
      GoRoute(
        path: '/guides/:documentId/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            GuideEditScreen(documentId: state.pathParameters['documentId']!),
      ),
      GoRoute(
        path: '/guides/:documentId/read',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => GuideReaderScreen(
          documentId: state.pathParameters['documentId']!,
          initialPage: int.tryParse(state.uri.queryParameters['page'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/guides/:documentId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            GuideDetailScreen(documentId: state.pathParameters['documentId']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/projects',
                builder: (context, state) => const ProjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guides',
                builder: (context, state) => const GuidesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/results',
                builder: (context, state) => const ResultsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class _RouteProblemScreen extends StatelessWidget {
  const _RouteProblemScreen({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.section),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.explore_off_outlined, size: 48),
              const SizedBox(height: AppSpacing.section),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.compact),
              Text(description),
              const SizedBox(height: AppSpacing.section),
              FilledButton(
                onPressed: () => context.go('/today'),
                child: const Text('Kembali ke Hari Ini'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
