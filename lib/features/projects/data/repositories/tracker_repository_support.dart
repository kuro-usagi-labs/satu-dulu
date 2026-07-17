import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/domain/entities/tracker_models.dart';

abstract final class TrackerRepositorySupport {
  static void validateCreateInput(CreateProjectInput input) {
    if (input.name.trim().isEmpty) {
      throw const ValidationException('Nama proyek wajib diisi.');
    }
    if (input.shortGoal.trim().isEmpty) {
      throw const ValidationException('Tujuan proyek wajib diisi.');
    }
    validateDailyPlan(input.requiredOutcome, input.actions);
    if (input.sprintDays < 1) {
      throw const ValidationException('Durasi sprint harus lebih dari nol.');
    }
  }

  static void validateDailyPlan(
    String requiredOutcome,
    List<String> inputActions,
  ) {
    if (requiredOutcome.trim().isEmpty) {
      throw const ValidationException('Hasil wajib hari ini harus diisi.');
    }
    final actions = inputActions
        .where((item) => item.trim().isNotEmpty)
        .toList();
    if (actions.length != inputActions.length) {
      throw const ValidationException('Tindakan harian tidak boleh kosong.');
    }
    if (actions.length > 3) {
      throw const ValidationException('Maksimal tiga tindakan per hari.');
    }
  }

  static Project projectFromRow(ProjectRow row) => Project(
    id: row.id,
    name: row.name,
    shortGoal: row.shortGoal,
    whyChosen: row.whyChosen,
    successDefinition: row.successDefinition,
    targetRevenueMinor: row.targetRevenueMinor,
    status: ProjectStatus.values.byName(row.status),
    startDate: row.startDate?.toUtc(),
    reviewDate: row.reviewDate?.toUtc(),
    primaryGuideDocumentId: row.primaryGuideDocumentId,
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
    archivedAt: row.archivedAt?.toUtc(),
  );

  static Sprint sprintFromRow(SprintRow row) => Sprint(
    id: row.id,
    projectId: row.projectId,
    name: row.name,
    hypothesis: row.hypothesis,
    startDate: row.startDate.toUtc(),
    endDate: row.endDate.toUtc(),
    targetOutputs: row.targetOutputs,
    successCriteria: row.successCriteria,
    status: SprintStatus.values.byName(row.status),
  );

  static DailyAction actionFromRow(DailyActionRow row) => DailyAction(
    id: row.id,
    position: row.position,
    label: row.label,
    isCompleted: row.isCompleted,
    completedAt: row.completedAt?.toUtc(),
  );

  static ShipRecord shipFromRow(ShipRecordRow row) => ShipRecord(
    id: row.id,
    outputType: row.outputType,
    outputTitle: row.outputTitle,
    externalUrl: row.externalUrl,
    evidenceNote: row.evidenceNote,
    isPartial: row.isPartial,
    shippedAt: row.shippedAt.toUtc(),
  );

  static DateTime utcDay(DateTime value) =>
      DateTime.utc(value.year, value.month, value.day);

  static String? nullableTrim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
