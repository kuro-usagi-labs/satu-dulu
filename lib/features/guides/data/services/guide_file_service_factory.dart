import 'package:satu_dulu/features/guides/domain/services/guide_file_service.dart';

import 'guide_file_service_stub.dart'
    if (dart.library.io) 'guide_file_service_native.dart';

GuideFileService createGuideFileService() => createPlatformGuideFileService();
