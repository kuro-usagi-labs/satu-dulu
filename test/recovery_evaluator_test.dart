import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/features/anti_forget/domain/entities/anti_forget_models.dart';
import 'package:satu_dulu/features/anti_forget/domain/services/recovery_evaluator.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

void main() {
  final now = DateTime(2026, 7, 17, 13);
  final project = Project(
    id: 'project',
    name: 'Upgrade Dikit',
    shortGoal: 'Terbitkan konten konsisten',
    status: ProjectStatus.focus,
    createdAt: now,
    updatedAt: now,
    reviewDate: now.add(const Duration(days: 10)),
  );

  test('returns none when there is no focus project', () {
    final result = RecoveryEvaluator.evaluate(
      RecoverySnapshot(
        now: now,
        project: null,
        hasActiveSprint: false,
        hasTodayPlan: false,
        todayActionCount: 0,
        shippedToday: false,
        shipsLastSevenDays: 0,
      ),
    );

    expect(result.isActive, isFalse);
  });

  test('missing active sprint is urgent', () {
    final result = RecoveryEvaluator.evaluate(
      _snapshot(now: now, project: project, hasActiveSprint: false),
    );

    expect(result.severity, RecoverySeverity.urgent);
    expect(result.reason, RecoveryReason.missingSprint);
  });

  test('review due outranks missing plan', () {
    final due = Project(
      id: project.id,
      name: project.name,
      shortGoal: project.shortGoal,
      status: project.status,
      createdAt: project.createdAt,
      updatedAt: project.updatedAt,
      reviewDate: now,
    );
    final result = RecoveryEvaluator.evaluate(
      _snapshot(now: now, project: due, hasTodayPlan: false),
    );

    expect(result.reason, RecoveryReason.reviewDue);
    expect(result.severity, RecoverySeverity.urgent);
  });

  test('missing plan after noon creates gentle recovery', () {
    final result = RecoveryEvaluator.evaluate(
      _snapshot(now: now, project: project, hasTodayPlan: false),
    );

    expect(result.reason, RecoveryReason.noPlanAfterNoon);
    expect(result.severity, RecoverySeverity.gentle);
  });

  test('two days without ship creates urgent recovery', () {
    final result = RecoveryEvaluator.evaluate(
      _snapshot(
        now: now,
        project: project,
        lastShippedAt: now.subtract(const Duration(days: 2)),
      ),
    );

    expect(result.reason, RecoveryReason.noShipTwoDays);
    expect(result.severity, RecoverySeverity.urgent);
  });

  test('low energy with oversized plan is reduced gently', () {
    final result = RecoveryEvaluator.evaluate(
      _snapshot(
        now: now,
        project: project,
        todayActionCount: 3,
        checkIn: DailyCheckIn(
          id: 'check-in',
          checkInDate: now,
          energyLevel: EnergyLevel.low,
          availableMinutes: 10,
          createdAt: now,
          updatedAt: now,
        ),
      ),
    );

    expect(result.reason, RecoveryReason.lowEnergyOversizedPlan);
    expect(result.severity, RecoverySeverity.gentle);
  });
}

RecoverySnapshot _snapshot({
  required DateTime now,
  required Project project,
  bool hasActiveSprint = true,
  bool hasTodayPlan = true,
  int todayActionCount = 1,
  DailyCheckIn? checkIn,
  DateTime? lastShippedAt,
}) {
  return RecoverySnapshot(
    now: now,
    project: project,
    hasActiveSprint: hasActiveSprint,
    hasTodayPlan: hasTodayPlan,
    todayActionCount: todayActionCount,
    shippedToday: false,
    shipsLastSevenDays: 1,
    checkIn: checkIn,
    lastShippedAt: lastShippedAt,
  );
}
