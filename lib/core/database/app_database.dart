import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

@DataClassName('ProjectRow')
class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get shortGoal => text()();
  TextColumn get whyChosen => text().nullable()();
  TextColumn get successDefinition => text().nullable()();
  IntColumn get targetRevenueMinor => integer().nullable()();
  TextColumn get status => text()();
  TextColumn get iconKey => text().nullable()();
  TextColumn get accentKey => text().nullable()();
  TextColumn get primaryGuideDocumentId => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get reviewDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('IdeaRow')
class Ideas extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get note => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get disposition => text()();
  TextColumn get convertedProjectId => text().nullable().references(
    Projects,
    #id,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get capturedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('RestartCapsuleRow')
class RestartCapsules extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().unique().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get lastKnownState => text().nullable()();
  TextColumn get lastOutput => text().nullable()();
  TextColumn get whatWorked => text().nullable()();
  TextColumn get blocker => text().nullable()();
  TextColumn get nextAction => text().nullable()();
  TextColumn get parkedReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DailyCheckInRow')
class DailyCheckIns extends Table {
  TextColumn get id => text()();
  DateTimeColumn get checkInDate => dateTime().unique()();
  TextColumn get energyLevel => text()();
  IntColumn get availableMinutes => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SprintRow')
class Sprints extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get hypothesis => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get targetOutputs => integer().nullable()();
  TextColumn get successCriteria => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DailyPlanRow')
class DailyPlans extends Table {
  TextColumn get id => text()();
  TextColumn get sprintId =>
      text().references(Sprints, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get planDate => dateTime()();
  TextColumn get requiredOutcome => text()();
  TextColumn get lowEnergyAction => text().nullable()();
  TextColumn get linkedGuideDocumentId => text().nullable()();
  IntColumn get linkedGuidePage => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {sprintId, planDate},
  ];

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DailyActionRow')
class DailyActions extends Table {
  TextColumn get id => text()();
  TextColumn get dailyPlanId =>
      text().references(DailyPlans, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get label => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {dailyPlanId, position},
  ];

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ShipRecordRow')
class ShipRecords extends Table {
  TextColumn get id => text()();
  TextColumn get dailyPlanId => text().unique().references(
    DailyPlans,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get outputType => text()();
  TextColumn get outputTitle => text()();
  TextColumn get externalUrl => text().nullable()();
  TextColumn get evidenceNote => text().nullable()();
  BoolColumn get isPartial => boolean().withDefault(const Constant(false))();
  DateTimeColumn get shippedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('GuideDocumentRow')
class GuideDocuments extends Table {
  TextColumn get id => text()();
  TextColumn get originalFileName => text()();
  TextColumn get displayTitle => text()();
  TextColumn get storedRelativePath => text().unique()();
  IntColumn get fileSizeBytes => integer()();
  TextColumn get checksum => text().nullable()();
  TextColumn get projectId => text().nullable().references(
    Projects,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get category => text()();
  TextColumn get description => text().nullable()();
  TextColumn get whenToRead => text().nullable()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  IntColumn get pageCount => integer()();
  IntColumn get lastReadPage => integer().withDefault(const Constant(1))();
  DateTimeColumn get lastOpenedAt => dateTime().nullable()();
  DateTimeColumn get importedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get cleanupNeeded =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PdfBookmarkRow')
class PdfBookmarks extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(GuideDocuments, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageNumber => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {documentId, pageNumber},
  ];

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PdfNoteRow')
class PdfNotes extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(GuideDocuments, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageNumber => integer()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MetricEntryRow')
class MetricEntries extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get entryDate => dateTime()();
  IntColumn get outputsCount => integer().withDefault(const Constant(0))();
  IntColumn get views => integer().nullable()();
  IntColumn get clicks => integer().nullable()();
  IntColumn get orders => integer().nullable()();
  IntColumn get revenueMinor => integer().nullable()();
  IntColumn get workMinutes => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {projectId, entryDate},
  ];

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('WeeklyReviewRow')
class WeeklyReviews extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get sprintId =>
      text().nullable().references(Sprints, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get weekStart => dateTime()();
  DateTimeColumn get weekEnd => dateTime()();
  TextColumn get shippedSummary => text().nullable()();
  TextColumn get importantResult => text().nullable()();
  TextColumn get workedWell => text().nullable()();
  TextColumn get wasteOrBlocker => text().nullable()();
  TextColumn get decision => text()();
  TextColumn get nextWeekFocus => text().nullable()();
  DateTimeColumn get decisionAppliedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {projectId, weekStart},
  ];

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NotificationPreferenceRow')
class NotificationPreferences extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get morningEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get afterWorkEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get eveningEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get morningMinutes => integer().withDefault(const Constant(480))();
  IntColumn get afterWorkMinutes =>
      integer().withDefault(const Constant(1020))();
  IntColumn get eveningMinutes => integer().withDefault(const Constant(1260))();
  TextColumn get timeZoneId =>
      text().withDefault(const Constant('Asia/Jakarta'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Projects,
    Ideas,
    RestartCapsules,
    DailyCheckIns,
    Sprints,
    DailyPlans,
    DailyActions,
    ShipRecords,
    GuideDocuments,
    PdfBookmarks,
    PdfNotes,
    MetricEntries,
    WeeklyReviews,
    NotificationPreferences,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'satu_dulu',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from > to) {
        throw StateError(
          'Database downgrade from version $from to $to is not supported.',
        );
      }
      if (from < 2) {
        await migrator.createTable(ideas);
        await migrator.createTable(restartCapsules);
        await migrator.createTable(dailyCheckIns);
        await migrator.addColumn(
          weeklyReviews,
          weeklyReviews.decisionAppliedAt,
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
