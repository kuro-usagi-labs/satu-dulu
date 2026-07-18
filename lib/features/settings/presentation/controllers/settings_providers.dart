import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart'
    hide NotificationPreferences;
import 'package:satu_dulu/features/anti_forget/presentation/controllers/anti_forget_providers.dart';
import 'package:satu_dulu/features/guides/presentation/controllers/guide_providers.dart';
import 'package:satu_dulu/features/projects/presentation/controllers/tracker_providers.dart';
import 'package:satu_dulu/features/results/presentation/controllers/results_providers.dart';
import 'package:satu_dulu/features/settings/application/local_backup_coordinator.dart';
import 'package:satu_dulu/features/settings/application/local_notification_service.dart';
import 'package:satu_dulu/features/settings/data/drift_local_backup_repository.dart';
import 'package:satu_dulu/features/settings/data/services/local_backup_file_service_factory.dart';
import 'package:satu_dulu/features/settings/data/notification_preferences_repository.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_file_service.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_repository.dart';
import 'package:satu_dulu/features/settings/domain/notification_preferences.dart';

final notificationPreferencesRepositoryProvider =
    Provider<NotificationPreferencesRepository>((ref) {
      return NotificationPreferencesRepository(ref.watch(appDatabaseProvider));
    });

final localNotificationServiceProvider = Provider<LocalNotificationService>((
  ref,
) {
  return LocalNotificationService();
});

final notificationPreferencesProvider = StreamProvider<NotificationPreferences>(
  (ref) {
    return ref.watch(notificationPreferencesRepositoryProvider).watch();
  },
);

final localBackupRepositoryProvider = Provider<LocalBackupRepository>((ref) {
  return DriftLocalBackupRepository(ref.watch(appDatabaseProvider));
});

final localBackupFileServiceProvider = Provider<LocalBackupFileService>((ref) {
  return createLocalBackupFileService();
});

final localBackupCoordinatorProvider = Provider<LocalBackupActions>((ref) {
  return LocalBackupCoordinator(
    ref.watch(localBackupRepositoryProvider),
    ref.watch(localBackupFileServiceProvider),
    onRestored: () async {
      ref.invalidate(projectsProvider);
      ref.invalidate(todayProvider);
      ref.invalidate(projectProvider);
      ref.invalidate(latestSprintProvider);
      ref.invalidate(cycleReviewTargetProvider);
      ref.invalidate(guideDocumentsProvider);
      ref.invalidate(guideDocumentProvider);
      ref.invalidate(guidePathProvider);
      ref.invalidate(guideExistsProvider);
      ref.invalidate(guideBookmarksProvider);
      ref.invalidate(guideNotesProvider);
      ref.invalidate(resultsSummaryProvider);
      ref.invalidate(cycleResultsSummaryProvider);
      ref.invalidate(weeklyReviewsProvider);
      ref.read(selectedResultsProjectProvider.notifier).clear();
      ref.invalidate(notificationPreferencesProvider);
      ref.invalidate(activeIdeasProvider);
      ref.invalidate(dailyCheckInProvider);
      ref.invalidate(restartCapsuleProvider);
      ref.invalidate(antiForgetTodaySupportProvider);

      final preferences = await ref
          .read(notificationPreferencesRepositoryProvider)
          .load();
      await ref.read(localNotificationServiceProvider).reschedule(preferences);
    },
  );
});
