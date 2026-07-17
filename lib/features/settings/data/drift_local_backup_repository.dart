import 'package:satu_dulu/core/database/app_database.dart';
import 'package:satu_dulu/core/errors/app_exception.dart';
import 'package:satu_dulu/features/settings/data/local_backup_table_codec.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';
import 'package:satu_dulu/features/settings/domain/local_backup_repository.dart';

class DriftLocalBackupRepository implements LocalBackupRepository {
  const DriftLocalBackupRepository(
    this._database, [
    this._codec = const LocalBackupTableCodec(),
  ]);

  final AppDatabase _database;
  final LocalBackupTableCodec _codec;

  @override
  Future<BackupDataSnapshot> exportSnapshot() async {
    try {
      final projects = await _database.select(_database.projects).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final sprints = await _database.select(_database.sprints).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final dailyPlans = await _database.select(_database.dailyPlans).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final dailyActions = await _database.select(_database.dailyActions).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final shipRecords = await _database.select(_database.shipRecords).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final guideDocuments =
          await _database.select(_database.guideDocuments).get()
            ..sort((a, b) => a.id.compareTo(b.id));
      final pdfBookmarks = await _database.select(_database.pdfBookmarks).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final pdfNotes = await _database.select(_database.pdfNotes).get()
        ..sort((a, b) => a.id.compareTo(b.id));
      final metricEntries =
          await _database.select(_database.metricEntries).get()
            ..sort((a, b) => a.id.compareTo(b.id));
      final weeklyReviews =
          await _database.select(_database.weeklyReviews).get()
            ..sort((a, b) => a.id.compareTo(b.id));
      final notificationPreferences =
          await _database.select(_database.notificationPreferences).get()
            ..sort((a, b) => a.id.compareTo(b.id));
      final sprintClosures =
          await _database.select(_database.sprintClosures).get()
            ..sort((a, b) => a.id.compareTo(b.id));

      return BackupDataSnapshot(
        databaseSchemaVersion: AppDatabase.currentSchemaVersion,
        tables: {
          'projects': [for (final row in projects) row.toJson()],
          'sprints': [for (final row in sprints) row.toJson()],
          'dailyPlans': [for (final row in dailyPlans) row.toJson()],
          'dailyActions': [for (final row in dailyActions) row.toJson()],
          'shipRecords': [for (final row in shipRecords) row.toJson()],
          'guideDocuments': [for (final row in guideDocuments) row.toJson()],
          'pdfBookmarks': [for (final row in pdfBookmarks) row.toJson()],
          'pdfNotes': [for (final row in pdfNotes) row.toJson()],
          'metricEntries': [for (final row in metricEntries) row.toJson()],
          'weeklyReviews': [for (final row in weeklyReviews) row.toJson()],
          'notificationPreferences': [
            for (final row in notificationPreferences) row.toJson(),
          ],
          'sprintClosures': [for (final row in sprintClosures) row.toJson()],
        },
      );
    } catch (error) {
      throw DatabaseException(
        'Data belum dapat disiapkan untuk backup.',
        error,
      );
    }
  }

  @override
  void validateSnapshot(BackupDataSnapshot snapshot) {
    _codec.parse(snapshot);
  }

  @override
  Future<void> restoreSnapshot(BackupDataSnapshot snapshot) async {
    final rows = _codec.parse(snapshot);
    try {
      await _database.transaction(() async {
        await _database.batch((batch) {
          batch.deleteAll(_database.sprintClosures);
          batch.deleteAll(_database.notificationPreferences);
          batch.deleteAll(_database.weeklyReviews);
          batch.deleteAll(_database.metricEntries);
          batch.deleteAll(_database.pdfNotes);
          batch.deleteAll(_database.pdfBookmarks);
          batch.deleteAll(_database.guideDocuments);
          batch.deleteAll(_database.shipRecords);
          batch.deleteAll(_database.dailyActions);
          batch.deleteAll(_database.dailyPlans);
          batch.deleteAll(_database.sprints);
          batch.deleteAll(_database.projects);

          batch.insertAll(_database.projects, rows.projects);
          batch.insertAll(_database.sprints, rows.sprints);
          batch.insertAll(_database.dailyPlans, rows.dailyPlans);
          batch.insertAll(_database.dailyActions, rows.dailyActions);
          batch.insertAll(_database.shipRecords, rows.shipRecords);
          batch.insertAll(_database.guideDocuments, rows.guideDocuments);
          batch.insertAll(_database.pdfBookmarks, rows.pdfBookmarks);
          batch.insertAll(_database.pdfNotes, rows.pdfNotes);
          batch.insertAll(_database.metricEntries, rows.metricEntries);
          batch.insertAll(_database.weeklyReviews, rows.weeklyReviews);
          batch.insertAll(
            _database.notificationPreferences,
            rows.notificationPreferences,
          );
          batch.insertAll(_database.sprintClosures, rows.sprintClosures);
        });
      });
    } on BackupException {
      rethrow;
    } catch (error) {
      throw DatabaseException(
        'Restore database gagal. Data sebelumnya tetap dipertahankan.',
        error,
      );
    }
  }
}
