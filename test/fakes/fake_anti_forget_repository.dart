import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/domain/repositories/anti_forget_repository.dart';

class FakeAntiForgetRepository implements AntiForgetRepository {
  const FakeAntiForgetRepository({this.support});

  final AntiForgetTodaySupport? support;

  @override
  Future<AntiForgetTodaySupport> loadTodaySupport(DateTime localDate) async {
    return support ??
        AntiForgetTodaySupport(
          checkIn: null,
          capsule: null,
          recovery: const RecoveryBrief.none(),
        );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
