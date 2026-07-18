enum ReviewDecision { continueFocus, pivot, park }

class MetricEntry {
  const MetricEntry({
    required this.id,
    required this.projectId,
    required this.entryDate,
    required this.outputsCount,
    required this.createdAt,
    required this.updatedAt,
    this.views,
    this.clicks,
    this.orders,
    this.revenueMinor,
    this.workMinutes,
    this.note,
  });

  final String id;
  final String projectId;
  final DateTime entryDate;
  final int outputsCount;
  final int? views;
  final int? clicks;
  final int? orders;
  final int? revenueMinor;
  final int? workMinutes;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class MetricInput {
  const MetricInput({
    required this.projectId,
    required this.entryDate,
    required this.outputsCount,
    this.views,
    this.clicks,
    this.orders,
    this.revenueMinor,
    this.workMinutes,
    this.note,
  });

  final String projectId;
  final DateTime entryDate;
  final int outputsCount;
  final int? views;
  final int? clicks;
  final int? orders;
  final int? revenueMinor;
  final int? workMinutes;
  final String? note;
}

class ResultsSummary {
  const ResultsSummary({
    required this.entries,
    required this.outputs,
    required this.views,
    required this.clicks,
    required this.orders,
    required this.revenueMinor,
    required this.workMinutes,
    required this.ordersPerThousandViews,
    required this.revenuePerThousandViewsMinor,
    required this.revenuePerHourMinor,
    required this.outputsPerWeek,
    required this.shipConsistency,
  });

  final List<MetricEntry> entries;
  final int outputs;
  final int views;
  final int clicks;
  final int orders;
  final int revenueMinor;
  final int workMinutes;
  final double? ordersPerThousandViews;
  final double? revenuePerThousandViewsMinor;
  final double? revenuePerHourMinor;
  final double outputsPerWeek;
  final double shipConsistency;

  bool get hasData => entries.isNotEmpty;
  bool get hasSmallSample => views < 100 || entries.length < 7;
}

class WeeklyReview {
  const WeeklyReview({
    required this.id,
    required this.projectId,
    required this.weekStart,
    required this.weekEnd,
    required this.decision,
    required this.createdAt,
    required this.updatedAt,
    this.sprintId,
    this.shippedSummary,
    this.importantResult,
    this.workedWell,
    this.wasteOrBlocker,
    this.nextWeekFocus,
    this.decisionAppliedAt,
  });

  final String id;
  final String projectId;
  final String? sprintId;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String? shippedSummary;
  final String? importantResult;
  final String? workedWell;
  final String? wasteOrBlocker;
  final ReviewDecision decision;
  final String? nextWeekFocus;
  final DateTime? decisionAppliedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isApplied => decisionAppliedAt != null;
}

class WeeklyReviewInput {
  const WeeklyReviewInput({
    required this.projectId,
    required this.weekStart,
    required this.weekEnd,
    required this.decision,
    this.sprintId,
    this.shippedSummary,
    this.importantResult,
    this.workedWell,
    this.wasteOrBlocker,
    this.nextWeekFocus,
  });

  final String projectId;
  final String? sprintId;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String? shippedSummary;
  final String? importantResult;
  final String? workedWell;
  final String? wasteOrBlocker;
  final ReviewDecision decision;
  final String? nextWeekFocus;
}
