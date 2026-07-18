import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/app/app_version.dart';

void main() {
  test('default build metadata matches the 1.2.2 release', () {
    expect(AppVersion.name, '1.2.2');
    expect(AppVersion.build, '6');
    expect(AppVersion.display, '1.2.2+6');
  });
}
