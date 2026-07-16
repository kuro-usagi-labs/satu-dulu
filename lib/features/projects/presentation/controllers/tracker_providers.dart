import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/projects/data/repositories/drift_tracker_repository.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';
import 'package:satu_dulu/features/projects/domain/repositories/tracker_repository.dart';

final trackerRepositoryProvider = Provider<TrackerRepository>((ref) {
  return DriftTrackerRepository(ref.watch(appDatabaseProvider));
});

final projectsProvider = StreamProvider<List<Project>>((ref) {
  return ref.watch(trackerRepositoryProvider).watchProjects();
});

final todayProvider = FutureProvider.autoDispose
    .family<TodayOverview?, DateTime>((ref, date) {
      return ref.watch(trackerRepositoryProvider).loadToday(date);
    });

final projectProvider = FutureProvider.autoDispose.family<Project?, String>((
  ref,
  projectId,
) {
  return ref.watch(trackerRepositoryProvider).getProject(projectId);
});
