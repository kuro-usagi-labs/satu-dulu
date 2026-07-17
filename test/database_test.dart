import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';

void main() {
  test('database scaffold opens at schema version 2', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    expect(database.schemaVersion, 2);
    await database.customSelect('SELECT 1').getSingle();
  });
}
