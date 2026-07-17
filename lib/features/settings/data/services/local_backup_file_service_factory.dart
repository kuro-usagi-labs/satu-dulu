import 'package:satu_dulu/features/settings/domain/local_backup_file_service.dart';

import 'local_backup_file_service_stub.dart'
    if (dart.library.io) 'local_backup_file_service_native.dart';

LocalBackupFileService createLocalBackupFileService() {
  return createPlatformLocalBackupFileService();
}
