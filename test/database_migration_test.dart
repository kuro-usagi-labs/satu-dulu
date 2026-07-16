import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';

import 'generated_migrations/schema.dart';

void main() {
  test(
    'schema v1 baseline matches runtime and preserves existing data',
    () async {
      final verifier = SchemaVerifier(GeneratedHelper());
      final schema = await verifier.schemaAt(1);
      addTearDown(schema.close);

      final timestamp = DateTime.utc(2026, 7, 17).millisecondsSinceEpoch;
      schema.rawDatabase.execute(
        '''
      INSERT INTO projects (
        id, name, short_goal, status, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?)
      ''',
        [
          'project-before-open',
          'Proyek lama',
          'Tetap utuh',
          'focus',
          timestamp,
          timestamp,
        ],
      );

      final database = AppDatabase.forTesting(schema.newConnection());
      addTearDown(database.close);

      await verifier.migrateAndValidate(
        database,
        1,
        options: const ValidationOptions(validateDropped: true),
      );

      final project = await (database.select(
        database.projects,
      )..where((table) => table.id.equals('project-before-open'))).getSingle();
      expect(project.name, 'Proyek lama');
      expect(project.shortGoal, 'Tetap utuh');

      final foreignKeys = await database
          .customSelect('PRAGMA foreign_keys')
          .getSingle();
      expect(foreignKeys.read<int>('foreign_keys'), 1);
    },
  );

  test('schema v1 contains every released MVP table', () async {
    final verifier = SchemaVerifier(GeneratedHelper());
    final connection = await verifier.startAt(1);
    final database = AppDatabase.forTesting(connection);
    addTearDown(database.close);

    await database.customSelect('SELECT 1').get();
    final rows = await database
        .customSelect(
          "SELECT name FROM sqlite_schema WHERE type = 'table' AND name NOT LIKE 'sqlite_%'",
        )
        .get();
    final names = rows.map((row) => row.read<String>('name')).toSet();

    expect(
      names,
      containsAll({
        'projects',
        'sprints',
        'daily_plans',
        'daily_actions',
        'ship_records',
        'guide_documents',
        'pdf_bookmarks',
        'pdf_notes',
        'metric_entries',
        'weekly_reviews',
        'notification_preferences',
      }),
    );
  });
}
