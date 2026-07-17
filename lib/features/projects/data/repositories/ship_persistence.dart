import 'package:drift/drift.dart';
import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/projects/data/repositories/tracker_repository_support.dart';
import 'package:uuid/uuid.dart';

class ShipPersistence {
  const ShipPersistence(this._database, this._uuid);

  final AppDatabase _database;
  final Uuid _uuid;

  Future<void> save({
    required String dailyPlanId,
    required String outputTitle,
    required bool isPartial,
    required String outputType,
    String? externalUrl,
    String? evidenceNote,
  }) async {
    if (outputTitle.trim().isEmpty) {
      throw const ValidationException('Judul hasil wajib diisi.');
    }

    try {
      await _database.transaction(() async {
        final existingShip =
            await (_database.select(_database.shipRecords)
                  ..where((table) => table.dailyPlanId.equals(dailyPlanId)))
                .getSingleOrNull();
        if (existingShip != null) {
          throw const ValidationException('Hari ini sudah pernah di-ship.');
        }

        final plan = await (_database.select(
          _database.dailyPlans,
        )..where((table) => table.id.equals(dailyPlanId))).getSingleOrNull();
        if (plan == null) {
          throw const DatabaseException('Rencana hari ini tidak ditemukan.');
        }
        final sprint = await (_database.select(
          _database.sprints,
        )..where((table) => table.id.equals(plan.sprintId))).getSingleOrNull();
        if (sprint == null) {
          throw const DatabaseException('Fokus aktif tidak ditemukan.');
        }

        final now = DateTime.now().toUtc();
        final metricNote =
            TrackerRepositorySupport.nullableTrim(evidenceNote) ??
            outputTitle.trim();
        await _database
            .into(_database.shipRecords)
            .insert(
              ShipRecordsCompanion.insert(
                id: _uuid.v4(),
                dailyPlanId: dailyPlanId,
                outputType: outputType,
                outputTitle: outputTitle.trim(),
                externalUrl: Value(
                  TrackerRepositorySupport.nullableTrim(externalUrl),
                ),
                evidenceNote: Value(
                  TrackerRepositorySupport.nullableTrim(evidenceNote),
                ),
                isPartial: Value(isPartial),
                shippedAt: now,
              ),
            );

        final existingMetric =
            await (_database.select(_database.metricEntries)..where(
                  (table) =>
                      table.projectId.equals(sprint.projectId) &
                      table.entryDate.equals(plan.planDate),
                ))
                .getSingleOrNull();
        if (existingMetric == null) {
          await _database
              .into(_database.metricEntries)
              .insert(
                MetricEntriesCompanion.insert(
                  id: _uuid.v4(),
                  projectId: sprint.projectId,
                  entryDate: plan.planDate,
                  outputsCount: const Value(1),
                  note: Value(metricNote),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        } else {
          await (_database.update(
            _database.metricEntries,
          )..where((table) => table.id.equals(existingMetric.id))).write(
            MetricEntriesCompanion(
              outputsCount: Value(
                existingMetric.outputsCount < 1
                    ? 1
                    : existingMetric.outputsCount,
              ),
              note: Value(existingMetric.note ?? metricNote),
              updatedAt: Value(now),
            ),
          );
        }
      });
    } on AppException {
      rethrow;
    } catch (error) {
      throw DatabaseException('Hasil hari ini tidak dapat disimpan.', error);
    }
  }
}
