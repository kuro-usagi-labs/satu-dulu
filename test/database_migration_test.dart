import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satu_dulu/core/database/app_database.dart';

import 'generated_migrations/schema.dart';

void main() {
  test(
    'migration v1 to v3 preserves data and adds every merged feature',
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
      schema.rawDatabase.execute(
        '''
      INSERT INTO sprints (
        id, project_id, name, start_date, end_date, status, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''',
        [
          'sprint-before-open',
          'project-before-open',
          'Putaran lama',
          timestamp,
          timestamp + const Duration(days: 29).inMilliseconds,
          'active',
          timestamp,
          timestamp,
        ],
      );
      schema.rawDatabase.execute(
        '''
      INSERT INTO daily_plans (
        id, sprint_id, plan_date, required_outcome, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?)
      ''',
        [
          'plan-before-open',
          'sprint-before-open',
          timestamp,
          'Terbitkan satu hasil',
          timestamp,
          timestamp,
        ],
      );
      schema.rawDatabase.execute(
        '''
      INSERT INTO daily_actions (
        id, daily_plan_id, position, label, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?)
      ''',
        [
          'action-before-open',
          'plan-before-open',
          0,
          'Tulis draf',
          timestamp,
          timestamp,
        ],
      );
      schema.rawDatabase.execute(
        '''
      INSERT INTO ship_records (
        id, daily_plan_id, output_type, output_title, shipped_at
      ) VALUES (?, ?, ?, ?, ?)
      ''',
        [
          'ship-before-open',
          'plan-before-open',
          'other',
          'Hasil lama',
          timestamp,
        ],
      );
      schema.rawDatabase.execute(
        '''
      INSERT INTO metric_entries (
        id, project_id, entry_date, outputs_count, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?)
      ''',
        [
          'metric-before-open',
          'project-before-open',
          timestamp,
          1,
          timestamp,
          timestamp,
        ],
      );
      schema.rawDatabase.execute(
        '''
      INSERT INTO weekly_reviews (
        id, project_id, sprint_id, week_start, week_end, decision,
        created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''',
        [
          'review-before-open',
          'project-before-open',
          'sprint-before-open',
          timestamp,
          timestamp + const Duration(days: 6).inMilliseconds,
          'continueFocus',
          timestamp,
          timestamp,
        ],
      );

      final database = AppDatabase.forTesting(schema.newConnection());
      addTearDown(database.close);

      await verifier.migrateAndValidate(
        database,
        3,
        options: const ValidationOptions(validateDropped: true),
      );

      final project = await (database.select(
        database.projects,
      )..where((table) => table.id.equals('project-before-open'))).getSingle();
      expect(project.name, 'Proyek lama');
      expect(project.shortGoal, 'Tetap utuh');
      expect(await database.select(database.sprints).get(), hasLength(1));
      expect(await database.select(database.dailyPlans).get(), hasLength(1));
      expect(await database.select(database.dailyActions).get(), hasLength(1));
      expect(await database.select(database.shipRecords).get(), hasLength(1));
      expect(await database.select(database.metricEntries).get(), hasLength(1));
      expect(await database.select(database.weeklyReviews).get(), hasLength(1));
      expect(await database.select(database.ideas).get(), isEmpty);
      expect(await database.select(database.restartCapsules).get(), isEmpty);
      expect(await database.select(database.dailyCheckIns).get(), isEmpty);
      expect(await database.select(database.sprintClosures).get(), isEmpty);

      final foreignKeys = await database
          .customSelect('PRAGMA foreign_keys')
          .getSingle();
      expect(foreignKeys.read<int>('foreign_keys'), 1);
    },
  );

  test('schema v3 contains every released table', () async {
    final verifier = SchemaVerifier(GeneratedHelper());
    final connection = await verifier.startAt(3);
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
        'ideas',
        'restart_capsules',
        'daily_check_ins',
        'sprints',
        'sprint_closures',
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

  test('schema v3 rejects invalid and duplicate cycle decisions', () async {
    final verifier = SchemaVerifier(GeneratedHelper());
    final connection = await verifier.startAt(3);
    final database = AppDatabase.forTesting(connection);
    addTearDown(database.close);

    final now = DateTime.utc(2026, 7, 17);
    await database
        .into(database.projects)
        .insert(
          ProjectsCompanion.insert(
            id: 'project-constraint',
            name: 'Project',
            shortGoal: 'Goal',
            status: 'focus',
            createdAt: now,
            updatedAt: now,
          ),
        );
    await database
        .into(database.sprints)
        .insert(
          SprintsCompanion.insert(
            id: 'sprint-constraint',
            projectId: 'project-constraint',
            name: 'Putaran',
            startDate: now,
            endDate: now.add(const Duration(days: 29)),
            status: 'completed',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await expectLater(
      database.customStatement(
        '''
        INSERT INTO sprint_closures (
          id, sprint_id, decision, closed_at, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?)
        ''',
        ['bad', 'sprint-constraint', 'invalid', now, now, now],
      ),
      throwsA(anything),
    );

    await database
        .into(database.sprintClosures)
        .insert(
          SprintClosuresCompanion.insert(
            id: 'closure-valid',
            sprintId: 'sprint-constraint',
            decision: 'continueFocus',
            closedAt: now,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await expectLater(
      database
          .into(database.sprintClosures)
          .insert(
            SprintClosuresCompanion.insert(
              id: 'closure-duplicate',
              sprintId: 'sprint-constraint',
              decision: 'park',
              closedAt: now,
              createdAt: now,
              updatedAt: now,
            ),
          ),
      throwsA(anything),
    );
  });
}
