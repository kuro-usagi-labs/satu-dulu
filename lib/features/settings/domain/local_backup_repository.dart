import 'package:satu_dulu/features/settings/domain/local_backup_models.dart';

abstract interface class LocalBackupRepository {
  Future<BackupDataSnapshot> exportSnapshot();

  void validateSnapshot(BackupDataSnapshot snapshot);

  Future<void> restoreSnapshot(BackupDataSnapshot snapshot);
}
