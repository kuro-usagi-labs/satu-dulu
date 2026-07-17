import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/features/anti_forget/data/repositories/drift_anti_forget_repository.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/domain/repositories/anti_forget_repository.dart';

final antiForgetRepositoryProvider = Provider<AntiForgetRepository>((ref) {
  return DriftAntiForgetRepository(ref.watch(appDatabaseProvider));
});

final activeIdeasProvider = StreamProvider<List<Idea>>((ref) {
  return ref.watch(antiForgetRepositoryProvider).watchIdeas();
});

final dailyCheckInProvider = FutureProvider.autoDispose
    .family<DailyCheckIn?, DateTime>((ref, date) {
      return ref.watch(antiForgetRepositoryProvider).getDailyCheckIn(date);
    });

final restartCapsuleProvider = FutureProvider.autoDispose
    .family<RestartCapsule?, String>((ref, projectId) {
      return ref
          .watch(antiForgetRepositoryProvider)
          .getRestartCapsule(projectId);
    });

final antiForgetTodaySupportProvider = FutureProvider.autoDispose
    .family<AntiForgetTodaySupport, DateTime>((ref, date) {
      return ref.watch(antiForgetRepositoryProvider).loadTodaySupport(date);
    });
