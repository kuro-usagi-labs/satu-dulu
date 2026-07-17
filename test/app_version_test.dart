import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app_version.dart';

void main() {
  test('default build metadata matches the 1.1.0 release', () {
    expect(AppVersion.name, '1.1.0');
    expect(AppVersion.build, '3');
    expect(AppVersion.display, '1.1.0+3');
  });
}
