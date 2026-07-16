enum ProjectStatus { focus, maintenance, parkingLot, archived }

enum SprintStatus { active, completed, cancelled }

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.shortGoal,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.whyChosen,
    this.successDefinition,
    this.targetRevenueMinor,
    this.startDate,
    this.reviewDate,
    this.primaryGuideDocumentId,
    this.archivedAt,
  });

  final String id;
  final String name;
  final String shortGoal;
  final String? whyChosen;
  final String? successDefinition;
  final int? targetRevenueMinor;
  final ProjectStatus status;
  final DateTime? startDate;
  final DateTime? reviewDate;
  final String? primaryGuideDocumentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
}

class Sprint {
  const Sprint({
    required this.id,
    required this.projectId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.hypothesis,
    this.targetOutputs,
    this.successCriteria,
  });

  final String id;
  final String projectId;
  final String name;
  final String? hypothesis;
  final DateTime startDate;
  final DateTime endDate;
  final int? targetOutputs;
  final String? successCriteria;
  final SprintStatus status;
}

class DailyAction {
  const DailyAction({
    required this.id,
    required this.position,
    required this.label,
    required this.isCompleted,
    this.completedAt,
  });

  final String id;
  final int position;
  final String label;
  final bool isCompleted;
  final DateTime? completedAt;
}

class ShipRecord {
  const ShipRecord({
    required this.id,
    required this.outputType,
    required this.outputTitle,
    required this.isPartial,
    required this.shippedAt,
    this.externalUrl,
    this.evidenceNote,
  });

  final String id;
  final String outputType;
  final String outputTitle;
  final String? externalUrl;
  final String? evidenceNote;
  final bool isPartial;
  final DateTime shippedAt;
}

class TodayOverview {
  const TodayOverview({
    required this.project,
    required this.sprint,
    required this.dailyPlanId,
    required this.planDate,
    required this.requiredOutcome,
    required this.actions,
    this.lowEnergyAction,
    this.linkedGuideDocumentId,
    this.linkedGuidePage,
    this.shipRecord,
  });

  final Project project;
  final Sprint sprint;
  final String dailyPlanId;
  final DateTime planDate;
  final String requiredOutcome;
  final String? lowEnergyAction;
  final String? linkedGuideDocumentId;
  final int? linkedGuidePage;
  final List<DailyAction> actions;
  final ShipRecord? shipRecord;

  int get sprintDay {
    final start = DateTime.utc(
      sprint.startDate.year,
      sprint.startDate.month,
      sprint.startDate.day,
    );
    final day = DateTime.utc(planDate.year, planDate.month, planDate.day);
    return day.difference(start).inDays + 1;
  }

  int get sprintLength =>
      sprint.endDate.difference(sprint.startDate).inDays + 1;
}

class CreateProjectInput {
  const CreateProjectInput({
    required this.name,
    required this.shortGoal,
    required this.status,
    required this.startDate,
    required this.requiredOutcome,
    required this.actions,
    this.whyChosen,
    this.successDefinition,
    this.targetRevenueMinor,
    this.lowEnergyAction,
    this.sprintDays = 30,
  });

  final String name;
  final String shortGoal;
  final String? whyChosen;
  final String? successDefinition;
  final int? targetRevenueMinor;
  final ProjectStatus status;
  final DateTime startDate;
  final String requiredOutcome;
  final List<String> actions;
  final String? lowEnergyAction;
  final int sprintDays;
}

class UpdateProjectInput {
  const UpdateProjectInput({
    required this.name,
    required this.shortGoal,
    required this.status,
    this.whyChosen,
    this.successDefinition,
    this.targetRevenueMinor,
  });

  final String name;
  final String shortGoal;
  final String? whyChosen;
  final String? successDefinition;
  final int? targetRevenueMinor;
  final ProjectStatus status;
}

class CreateDailyPlanInput {
  const CreateDailyPlanInput({
    required this.planDate,
    required this.requiredOutcome,
    required this.actions,
    this.lowEnergyAction,
  });

  final DateTime planDate;
  final String requiredOutcome;
  final List<String> actions;
  final String? lowEnergyAction;
}
