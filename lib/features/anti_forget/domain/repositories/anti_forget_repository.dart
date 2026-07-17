import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';

abstract interface class AntiForgetRepository {
  Stream<List<Idea>> watchIdeas({bool includeResolved = false});

  Future<String> captureIdea(IdeaInput input);

  Future<void> updateIdea(String ideaId, IdeaInput input);

  Future<void> setIdeaDisposition(String ideaId, IdeaDisposition disposition);

  Future<String> convertIdeaToProject(String ideaId);

  Future<RestartCapsule?> getRestartCapsule(String projectId);

  Future<void> saveRestartCapsule(RestartCapsuleInput input);

  Future<void> applyRestartCapsuleToActivePlan(String projectId);

  Future<DailyCheckIn?> getDailyCheckIn(DateTime localDate);

  Future<void> saveDailyCheckIn(DailyCheckInInput input);

  Future<AntiForgetTodaySupport> loadTodaySupport(DateTime localDate);
}
