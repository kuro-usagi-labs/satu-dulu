import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

enum IdeaDisposition { inbox, parked, discarded, converted }

enum EnergyLevel { low, normal, high }

enum RecoverySeverity { none, gentle, urgent }

enum RecoveryReason {
  none,
  missingSprint,
  reviewDue,
  noPlanAfterNoon,
  noShipTwoDays,
  lowEnergyOversizedPlan,
}

class Idea {
  const Idea({
    required this.id,
    required this.title,
    required this.disposition,
    required this.capturedAt,
    required this.updatedAt,
    this.note,
    this.source,
    this.convertedProjectId,
  });

  final String id;
  final String title;
  final String? note;
  final String? source;
  final IdeaDisposition disposition;
  final String? convertedProjectId;
  final DateTime capturedAt;
  final DateTime updatedAt;
}

class IdeaInput {
  const IdeaInput({required this.title, this.note, this.source});

  final String title;
  final String? note;
  final String? source;
}

class RestartCapsule {
  const RestartCapsule({
    required this.id,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    this.lastKnownState,
    this.lastOutput,
    this.whatWorked,
    this.blocker,
    this.nextAction,
    this.parkedReason,
  });

  final String id;
  final String projectId;
  final String? lastKnownState;
  final String? lastOutput;
  final String? whatWorked;
  final String? blocker;
  final String? nextAction;
  final String? parkedReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get hasContext => [
    lastKnownState,
    lastOutput,
    whatWorked,
    blocker,
    nextAction,
    parkedReason,
  ].any((value) => value?.trim().isNotEmpty == true);
}

class RestartCapsuleInput {
  const RestartCapsuleInput({
    required this.projectId,
    this.lastKnownState,
    this.lastOutput,
    this.whatWorked,
    this.blocker,
    this.nextAction,
    this.parkedReason,
  });

  final String projectId;
  final String? lastKnownState;
  final String? lastOutput;
  final String? whatWorked;
  final String? blocker;
  final String? nextAction;
  final String? parkedReason;
}

class DailyCheckIn {
  const DailyCheckIn({
    required this.id,
    required this.checkInDate,
    required this.energyLevel,
    required this.availableMinutes,
    required this.createdAt,
    required this.updatedAt,
    this.note,
  });

  final String id;
  final DateTime checkInDate;
  final EnergyLevel energyLevel;
  final int availableMinutes;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get capacityLabel => switch (availableMinutes) {
    <= 10 => '10 menit',
    <= 30 => '30 menit',
    <= 60 => '1 jam',
    _ => '2+ jam',
  };
}

class DailyCheckInInput {
  const DailyCheckInInput({
    required this.checkInDate,
    required this.energyLevel,
    required this.availableMinutes,
    this.note,
  });

  final DateTime checkInDate;
  final EnergyLevel energyLevel;
  final int availableMinutes;
  final String? note;
}

class RecoverySnapshot {
  const RecoverySnapshot({
    required this.now,
    required this.project,
    required this.hasActiveSprint,
    required this.hasTodayPlan,
    required this.todayActionCount,
    required this.shippedToday,
    required this.shipsLastSevenDays,
    this.checkIn,
    this.capsule,
    this.lastShippedAt,
  });

  final DateTime now;
  final Project? project;
  final bool hasActiveSprint;
  final bool hasTodayPlan;
  final int todayActionCount;
  final bool shippedToday;
  final int shipsLastSevenDays;
  final DailyCheckIn? checkIn;
  final RestartCapsule? capsule;
  final DateTime? lastShippedAt;
}

class RecoveryBrief {
  const RecoveryBrief({
    required this.severity,
    required this.reason,
    required this.title,
    required this.message,
    required this.primaryActionLabel,
    this.secondaryActionLabel,
    this.suggestedAction,
  });

  const RecoveryBrief.none()
    : severity = RecoverySeverity.none,
      reason = RecoveryReason.none,
      title = '',
      message = '',
      primaryActionLabel = '',
      secondaryActionLabel = null,
      suggestedAction = null;

  final RecoverySeverity severity;
  final RecoveryReason reason;
  final String title;
  final String message;
  final String primaryActionLabel;
  final String? secondaryActionLabel;
  final String? suggestedAction;

  bool get isActive => severity != RecoverySeverity.none;
}

class AntiForgetTodaySupport {
  const AntiForgetTodaySupport({
    required this.checkIn,
    required this.capsule,
    required this.recovery,
  });

  final DailyCheckIn? checkIn;
  final RestartCapsule? capsule;
  final RecoveryBrief recovery;
}
