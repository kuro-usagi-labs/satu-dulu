// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects
    with TableInfo<$ProjectsTable, ProjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortGoalMeta = const VerificationMeta(
    'shortGoal',
  );
  @override
  late final GeneratedColumn<String> shortGoal = GeneratedColumn<String>(
    'short_goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _whyChosenMeta = const VerificationMeta(
    'whyChosen',
  );
  @override
  late final GeneratedColumn<String> whyChosen = GeneratedColumn<String>(
    'why_chosen',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _successDefinitionMeta = const VerificationMeta(
    'successDefinition',
  );
  @override
  late final GeneratedColumn<String> successDefinition =
      GeneratedColumn<String>(
        'success_definition',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetRevenueMinorMeta =
      const VerificationMeta('targetRevenueMinor');
  @override
  late final GeneratedColumn<int> targetRevenueMinor = GeneratedColumn<int>(
    'target_revenue_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accentKeyMeta = const VerificationMeta(
    'accentKey',
  );
  @override
  late final GeneratedColumn<String> accentKey = GeneratedColumn<String>(
    'accent_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _primaryGuideDocumentIdMeta =
      const VerificationMeta('primaryGuideDocumentId');
  @override
  late final GeneratedColumn<String> primaryGuideDocumentId =
      GeneratedColumn<String>(
        'primary_guide_document_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewDateMeta = const VerificationMeta(
    'reviewDate',
  );
  @override
  late final GeneratedColumn<DateTime> reviewDate = GeneratedColumn<DateTime>(
    'review_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    shortGoal,
    whyChosen,
    successDefinition,
    targetRevenueMinor,
    status,
    iconKey,
    accentKey,
    primaryGuideDocumentId,
    startDate,
    reviewDate,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('short_goal')) {
      context.handle(
        _shortGoalMeta,
        shortGoal.isAcceptableOrUnknown(data['short_goal']!, _shortGoalMeta),
      );
    } else if (isInserting) {
      context.missing(_shortGoalMeta);
    }
    if (data.containsKey('why_chosen')) {
      context.handle(
        _whyChosenMeta,
        whyChosen.isAcceptableOrUnknown(data['why_chosen']!, _whyChosenMeta),
      );
    }
    if (data.containsKey('success_definition')) {
      context.handle(
        _successDefinitionMeta,
        successDefinition.isAcceptableOrUnknown(
          data['success_definition']!,
          _successDefinitionMeta,
        ),
      );
    }
    if (data.containsKey('target_revenue_minor')) {
      context.handle(
        _targetRevenueMinorMeta,
        targetRevenueMinor.isAcceptableOrUnknown(
          data['target_revenue_minor']!,
          _targetRevenueMinorMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('accent_key')) {
      context.handle(
        _accentKeyMeta,
        accentKey.isAcceptableOrUnknown(data['accent_key']!, _accentKeyMeta),
      );
    }
    if (data.containsKey('primary_guide_document_id')) {
      context.handle(
        _primaryGuideDocumentIdMeta,
        primaryGuideDocumentId.isAcceptableOrUnknown(
          data['primary_guide_document_id']!,
          _primaryGuideDocumentIdMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('review_date')) {
      context.handle(
        _reviewDateMeta,
        reviewDate.isAcceptableOrUnknown(data['review_date']!, _reviewDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      shortGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_goal'],
      )!,
      whyChosen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}why_chosen'],
      ),
      successDefinition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}success_definition'],
      ),
      targetRevenueMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_revenue_minor'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      accentKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_key'],
      ),
      primaryGuideDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_guide_document_id'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      reviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}review_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class ProjectRow extends DataClass implements Insertable<ProjectRow> {
  final String id;
  final String name;
  final String shortGoal;
  final String? whyChosen;
  final String? successDefinition;
  final int? targetRevenueMinor;
  final String status;
  final String? iconKey;
  final String? accentKey;
  final String? primaryGuideDocumentId;
  final DateTime? startDate;
  final DateTime? reviewDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const ProjectRow({
    required this.id,
    required this.name,
    required this.shortGoal,
    this.whyChosen,
    this.successDefinition,
    this.targetRevenueMinor,
    required this.status,
    this.iconKey,
    this.accentKey,
    this.primaryGuideDocumentId,
    this.startDate,
    this.reviewDate,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['short_goal'] = Variable<String>(shortGoal);
    if (!nullToAbsent || whyChosen != null) {
      map['why_chosen'] = Variable<String>(whyChosen);
    }
    if (!nullToAbsent || successDefinition != null) {
      map['success_definition'] = Variable<String>(successDefinition);
    }
    if (!nullToAbsent || targetRevenueMinor != null) {
      map['target_revenue_minor'] = Variable<int>(targetRevenueMinor);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    if (!nullToAbsent || accentKey != null) {
      map['accent_key'] = Variable<String>(accentKey);
    }
    if (!nullToAbsent || primaryGuideDocumentId != null) {
      map['primary_guide_document_id'] = Variable<String>(
        primaryGuideDocumentId,
      );
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || reviewDate != null) {
      map['review_date'] = Variable<DateTime>(reviewDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      shortGoal: Value(shortGoal),
      whyChosen: whyChosen == null && nullToAbsent
          ? const Value.absent()
          : Value(whyChosen),
      successDefinition: successDefinition == null && nullToAbsent
          ? const Value.absent()
          : Value(successDefinition),
      targetRevenueMinor: targetRevenueMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(targetRevenueMinor),
      status: Value(status),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      accentKey: accentKey == null && nullToAbsent
          ? const Value.absent()
          : Value(accentKey),
      primaryGuideDocumentId: primaryGuideDocumentId == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryGuideDocumentId),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      reviewDate: reviewDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory ProjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shortGoal: serializer.fromJson<String>(json['shortGoal']),
      whyChosen: serializer.fromJson<String?>(json['whyChosen']),
      successDefinition: serializer.fromJson<String?>(
        json['successDefinition'],
      ),
      targetRevenueMinor: serializer.fromJson<int?>(json['targetRevenueMinor']),
      status: serializer.fromJson<String>(json['status']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      accentKey: serializer.fromJson<String?>(json['accentKey']),
      primaryGuideDocumentId: serializer.fromJson<String?>(
        json['primaryGuideDocumentId'],
      ),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      reviewDate: serializer.fromJson<DateTime?>(json['reviewDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'shortGoal': serializer.toJson<String>(shortGoal),
      'whyChosen': serializer.toJson<String?>(whyChosen),
      'successDefinition': serializer.toJson<String?>(successDefinition),
      'targetRevenueMinor': serializer.toJson<int?>(targetRevenueMinor),
      'status': serializer.toJson<String>(status),
      'iconKey': serializer.toJson<String?>(iconKey),
      'accentKey': serializer.toJson<String?>(accentKey),
      'primaryGuideDocumentId': serializer.toJson<String?>(
        primaryGuideDocumentId,
      ),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'reviewDate': serializer.toJson<DateTime?>(reviewDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  ProjectRow copyWith({
    String? id,
    String? name,
    String? shortGoal,
    Value<String?> whyChosen = const Value.absent(),
    Value<String?> successDefinition = const Value.absent(),
    Value<int?> targetRevenueMinor = const Value.absent(),
    String? status,
    Value<String?> iconKey = const Value.absent(),
    Value<String?> accentKey = const Value.absent(),
    Value<String?> primaryGuideDocumentId = const Value.absent(),
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> reviewDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => ProjectRow(
    id: id ?? this.id,
    name: name ?? this.name,
    shortGoal: shortGoal ?? this.shortGoal,
    whyChosen: whyChosen.present ? whyChosen.value : this.whyChosen,
    successDefinition: successDefinition.present
        ? successDefinition.value
        : this.successDefinition,
    targetRevenueMinor: targetRevenueMinor.present
        ? targetRevenueMinor.value
        : this.targetRevenueMinor,
    status: status ?? this.status,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    accentKey: accentKey.present ? accentKey.value : this.accentKey,
    primaryGuideDocumentId: primaryGuideDocumentId.present
        ? primaryGuideDocumentId.value
        : this.primaryGuideDocumentId,
    startDate: startDate.present ? startDate.value : this.startDate,
    reviewDate: reviewDate.present ? reviewDate.value : this.reviewDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  ProjectRow copyWithCompanion(ProjectsCompanion data) {
    return ProjectRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shortGoal: data.shortGoal.present ? data.shortGoal.value : this.shortGoal,
      whyChosen: data.whyChosen.present ? data.whyChosen.value : this.whyChosen,
      successDefinition: data.successDefinition.present
          ? data.successDefinition.value
          : this.successDefinition,
      targetRevenueMinor: data.targetRevenueMinor.present
          ? data.targetRevenueMinor.value
          : this.targetRevenueMinor,
      status: data.status.present ? data.status.value : this.status,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      accentKey: data.accentKey.present ? data.accentKey.value : this.accentKey,
      primaryGuideDocumentId: data.primaryGuideDocumentId.present
          ? data.primaryGuideDocumentId.value
          : this.primaryGuideDocumentId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      reviewDate: data.reviewDate.present
          ? data.reviewDate.value
          : this.reviewDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortGoal: $shortGoal, ')
          ..write('whyChosen: $whyChosen, ')
          ..write('successDefinition: $successDefinition, ')
          ..write('targetRevenueMinor: $targetRevenueMinor, ')
          ..write('status: $status, ')
          ..write('iconKey: $iconKey, ')
          ..write('accentKey: $accentKey, ')
          ..write('primaryGuideDocumentId: $primaryGuideDocumentId, ')
          ..write('startDate: $startDate, ')
          ..write('reviewDate: $reviewDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    shortGoal,
    whyChosen,
    successDefinition,
    targetRevenueMinor,
    status,
    iconKey,
    accentKey,
    primaryGuideDocumentId,
    startDate,
    reviewDate,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.shortGoal == this.shortGoal &&
          other.whyChosen == this.whyChosen &&
          other.successDefinition == this.successDefinition &&
          other.targetRevenueMinor == this.targetRevenueMinor &&
          other.status == this.status &&
          other.iconKey == this.iconKey &&
          other.accentKey == this.accentKey &&
          other.primaryGuideDocumentId == this.primaryGuideDocumentId &&
          other.startDate == this.startDate &&
          other.reviewDate == this.reviewDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class ProjectsCompanion extends UpdateCompanion<ProjectRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> shortGoal;
  final Value<String?> whyChosen;
  final Value<String?> successDefinition;
  final Value<int?> targetRevenueMinor;
  final Value<String> status;
  final Value<String?> iconKey;
  final Value<String?> accentKey;
  final Value<String?> primaryGuideDocumentId;
  final Value<DateTime?> startDate;
  final Value<DateTime?> reviewDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shortGoal = const Value.absent(),
    this.whyChosen = const Value.absent(),
    this.successDefinition = const Value.absent(),
    this.targetRevenueMinor = const Value.absent(),
    this.status = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.accentKey = const Value.absent(),
    this.primaryGuideDocumentId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.reviewDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String name,
    required String shortGoal,
    this.whyChosen = const Value.absent(),
    this.successDefinition = const Value.absent(),
    this.targetRevenueMinor = const Value.absent(),
    required String status,
    this.iconKey = const Value.absent(),
    this.accentKey = const Value.absent(),
    this.primaryGuideDocumentId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.reviewDate = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       shortGoal = Value(shortGoal),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProjectRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? shortGoal,
    Expression<String>? whyChosen,
    Expression<String>? successDefinition,
    Expression<int>? targetRevenueMinor,
    Expression<String>? status,
    Expression<String>? iconKey,
    Expression<String>? accentKey,
    Expression<String>? primaryGuideDocumentId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? reviewDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shortGoal != null) 'short_goal': shortGoal,
      if (whyChosen != null) 'why_chosen': whyChosen,
      if (successDefinition != null) 'success_definition': successDefinition,
      if (targetRevenueMinor != null)
        'target_revenue_minor': targetRevenueMinor,
      if (status != null) 'status': status,
      if (iconKey != null) 'icon_key': iconKey,
      if (accentKey != null) 'accent_key': accentKey,
      if (primaryGuideDocumentId != null)
        'primary_guide_document_id': primaryGuideDocumentId,
      if (startDate != null) 'start_date': startDate,
      if (reviewDate != null) 'review_date': reviewDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? shortGoal,
    Value<String?>? whyChosen,
    Value<String?>? successDefinition,
    Value<int?>? targetRevenueMinor,
    Value<String>? status,
    Value<String?>? iconKey,
    Value<String?>? accentKey,
    Value<String?>? primaryGuideDocumentId,
    Value<DateTime?>? startDate,
    Value<DateTime?>? reviewDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shortGoal: shortGoal ?? this.shortGoal,
      whyChosen: whyChosen ?? this.whyChosen,
      successDefinition: successDefinition ?? this.successDefinition,
      targetRevenueMinor: targetRevenueMinor ?? this.targetRevenueMinor,
      status: status ?? this.status,
      iconKey: iconKey ?? this.iconKey,
      accentKey: accentKey ?? this.accentKey,
      primaryGuideDocumentId:
          primaryGuideDocumentId ?? this.primaryGuideDocumentId,
      startDate: startDate ?? this.startDate,
      reviewDate: reviewDate ?? this.reviewDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortGoal.present) {
      map['short_goal'] = Variable<String>(shortGoal.value);
    }
    if (whyChosen.present) {
      map['why_chosen'] = Variable<String>(whyChosen.value);
    }
    if (successDefinition.present) {
      map['success_definition'] = Variable<String>(successDefinition.value);
    }
    if (targetRevenueMinor.present) {
      map['target_revenue_minor'] = Variable<int>(targetRevenueMinor.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (accentKey.present) {
      map['accent_key'] = Variable<String>(accentKey.value);
    }
    if (primaryGuideDocumentId.present) {
      map['primary_guide_document_id'] = Variable<String>(
        primaryGuideDocumentId.value,
      );
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (reviewDate.present) {
      map['review_date'] = Variable<DateTime>(reviewDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortGoal: $shortGoal, ')
          ..write('whyChosen: $whyChosen, ')
          ..write('successDefinition: $successDefinition, ')
          ..write('targetRevenueMinor: $targetRevenueMinor, ')
          ..write('status: $status, ')
          ..write('iconKey: $iconKey, ')
          ..write('accentKey: $accentKey, ')
          ..write('primaryGuideDocumentId: $primaryGuideDocumentId, ')
          ..write('startDate: $startDate, ')
          ..write('reviewDate: $reviewDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IdeasTable extends Ideas with TableInfo<$IdeasTable, IdeaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdeasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dispositionMeta = const VerificationMeta(
    'disposition',
  );
  @override
  late final GeneratedColumn<String> disposition = GeneratedColumn<String>(
    'disposition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _convertedProjectIdMeta =
      const VerificationMeta('convertedProjectId');
  @override
  late final GeneratedColumn<String> convertedProjectId =
      GeneratedColumn<String>(
        'converted_project_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES projects (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    note,
    source,
    disposition,
    convertedProjectId,
    capturedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ideas';
  @override
  VerificationContext validateIntegrity(
    Insertable<IdeaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('disposition')) {
      context.handle(
        _dispositionMeta,
        disposition.isAcceptableOrUnknown(
          data['disposition']!,
          _dispositionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dispositionMeta);
    }
    if (data.containsKey('converted_project_id')) {
      context.handle(
        _convertedProjectIdMeta,
        convertedProjectId.isAcceptableOrUnknown(
          data['converted_project_id']!,
          _convertedProjectIdMeta,
        ),
      );
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_capturedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IdeaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdeaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      disposition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}disposition'],
      )!,
      convertedProjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}converted_project_id'],
      ),
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $IdeasTable createAlias(String alias) {
    return $IdeasTable(attachedDatabase, alias);
  }
}

class IdeaRow extends DataClass implements Insertable<IdeaRow> {
  final String id;
  final String title;
  final String? note;
  final String? source;
  final String disposition;
  final String? convertedProjectId;
  final DateTime capturedAt;
  final DateTime updatedAt;
  const IdeaRow({
    required this.id,
    required this.title,
    this.note,
    this.source,
    required this.disposition,
    this.convertedProjectId,
    required this.capturedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['disposition'] = Variable<String>(disposition);
    if (!nullToAbsent || convertedProjectId != null) {
      map['converted_project_id'] = Variable<String>(convertedProjectId);
    }
    map['captured_at'] = Variable<DateTime>(capturedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  IdeasCompanion toCompanion(bool nullToAbsent) {
    return IdeasCompanion(
      id: Value(id),
      title: Value(title),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      disposition: Value(disposition),
      convertedProjectId: convertedProjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(convertedProjectId),
      capturedAt: Value(capturedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory IdeaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdeaRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      note: serializer.fromJson<String?>(json['note']),
      source: serializer.fromJson<String?>(json['source']),
      disposition: serializer.fromJson<String>(json['disposition']),
      convertedProjectId: serializer.fromJson<String?>(
        json['convertedProjectId'],
      ),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'note': serializer.toJson<String?>(note),
      'source': serializer.toJson<String?>(source),
      'disposition': serializer.toJson<String>(disposition),
      'convertedProjectId': serializer.toJson<String?>(convertedProjectId),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  IdeaRow copyWith({
    String? id,
    String? title,
    Value<String?> note = const Value.absent(),
    Value<String?> source = const Value.absent(),
    String? disposition,
    Value<String?> convertedProjectId = const Value.absent(),
    DateTime? capturedAt,
    DateTime? updatedAt,
  }) => IdeaRow(
    id: id ?? this.id,
    title: title ?? this.title,
    note: note.present ? note.value : this.note,
    source: source.present ? source.value : this.source,
    disposition: disposition ?? this.disposition,
    convertedProjectId: convertedProjectId.present
        ? convertedProjectId.value
        : this.convertedProjectId,
    capturedAt: capturedAt ?? this.capturedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  IdeaRow copyWithCompanion(IdeasCompanion data) {
    return IdeaRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      note: data.note.present ? data.note.value : this.note,
      source: data.source.present ? data.source.value : this.source,
      disposition: data.disposition.present
          ? data.disposition.value
          : this.disposition,
      convertedProjectId: data.convertedProjectId.present
          ? data.convertedProjectId.value
          : this.convertedProjectId,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdeaRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('disposition: $disposition, ')
          ..write('convertedProjectId: $convertedProjectId, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    note,
    source,
    disposition,
    convertedProjectId,
    capturedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdeaRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.note == this.note &&
          other.source == this.source &&
          other.disposition == this.disposition &&
          other.convertedProjectId == this.convertedProjectId &&
          other.capturedAt == this.capturedAt &&
          other.updatedAt == this.updatedAt);
}

class IdeasCompanion extends UpdateCompanion<IdeaRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> note;
  final Value<String?> source;
  final Value<String> disposition;
  final Value<String?> convertedProjectId;
  final Value<DateTime> capturedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const IdeasCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.disposition = const Value.absent(),
    this.convertedProjectId = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IdeasCompanion.insert({
    required String id,
    required String title,
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    required String disposition,
    this.convertedProjectId = const Value.absent(),
    required DateTime capturedAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       disposition = Value(disposition),
       capturedAt = Value(capturedAt),
       updatedAt = Value(updatedAt);
  static Insertable<IdeaRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? note,
    Expression<String>? source,
    Expression<String>? disposition,
    Expression<String>? convertedProjectId,
    Expression<DateTime>? capturedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
      if (source != null) 'source': source,
      if (disposition != null) 'disposition': disposition,
      if (convertedProjectId != null)
        'converted_project_id': convertedProjectId,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IdeasCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? note,
    Value<String?>? source,
    Value<String>? disposition,
    Value<String?>? convertedProjectId,
    Value<DateTime>? capturedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return IdeasCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      source: source ?? this.source,
      disposition: disposition ?? this.disposition,
      convertedProjectId: convertedProjectId ?? this.convertedProjectId,
      capturedAt: capturedAt ?? this.capturedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (disposition.present) {
      map['disposition'] = Variable<String>(disposition.value);
    }
    if (convertedProjectId.present) {
      map['converted_project_id'] = Variable<String>(convertedProjectId.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdeasCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('disposition: $disposition, ')
          ..write('convertedProjectId: $convertedProjectId, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RestartCapsulesTable extends RestartCapsules
    with TableInfo<$RestartCapsulesTable, RestartCapsuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestartCapsulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _lastKnownStateMeta = const VerificationMeta(
    'lastKnownState',
  );
  @override
  late final GeneratedColumn<String> lastKnownState = GeneratedColumn<String>(
    'last_known_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastOutputMeta = const VerificationMeta(
    'lastOutput',
  );
  @override
  late final GeneratedColumn<String> lastOutput = GeneratedColumn<String>(
    'last_output',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _whatWorkedMeta = const VerificationMeta(
    'whatWorked',
  );
  @override
  late final GeneratedColumn<String> whatWorked = GeneratedColumn<String>(
    'what_worked',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _blockerMeta = const VerificationMeta(
    'blocker',
  );
  @override
  late final GeneratedColumn<String> blocker = GeneratedColumn<String>(
    'blocker',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextActionMeta = const VerificationMeta(
    'nextAction',
  );
  @override
  late final GeneratedColumn<String> nextAction = GeneratedColumn<String>(
    'next_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parkedReasonMeta = const VerificationMeta(
    'parkedReason',
  );
  @override
  late final GeneratedColumn<String> parkedReason = GeneratedColumn<String>(
    'parked_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    lastKnownState,
    lastOutput,
    whatWorked,
    blocker,
    nextAction,
    parkedReason,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restart_capsules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RestartCapsuleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('last_known_state')) {
      context.handle(
        _lastKnownStateMeta,
        lastKnownState.isAcceptableOrUnknown(
          data['last_known_state']!,
          _lastKnownStateMeta,
        ),
      );
    }
    if (data.containsKey('last_output')) {
      context.handle(
        _lastOutputMeta,
        lastOutput.isAcceptableOrUnknown(data['last_output']!, _lastOutputMeta),
      );
    }
    if (data.containsKey('what_worked')) {
      context.handle(
        _whatWorkedMeta,
        whatWorked.isAcceptableOrUnknown(data['what_worked']!, _whatWorkedMeta),
      );
    }
    if (data.containsKey('blocker')) {
      context.handle(
        _blockerMeta,
        blocker.isAcceptableOrUnknown(data['blocker']!, _blockerMeta),
      );
    }
    if (data.containsKey('next_action')) {
      context.handle(
        _nextActionMeta,
        nextAction.isAcceptableOrUnknown(data['next_action']!, _nextActionMeta),
      );
    }
    if (data.containsKey('parked_reason')) {
      context.handle(
        _parkedReasonMeta,
        parkedReason.isAcceptableOrUnknown(
          data['parked_reason']!,
          _parkedReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestartCapsuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestartCapsuleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      lastKnownState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_known_state'],
      ),
      lastOutput: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_output'],
      ),
      whatWorked: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}what_worked'],
      ),
      blocker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blocker'],
      ),
      nextAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_action'],
      ),
      parkedReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parked_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RestartCapsulesTable createAlias(String alias) {
    return $RestartCapsulesTable(attachedDatabase, alias);
  }
}

class RestartCapsuleRow extends DataClass
    implements Insertable<RestartCapsuleRow> {
  final String id;
  final String projectId;
  final String? lastKnownState;
  final String? lastOutput;
  final String? whatWorked;
  final String? blocker;
  final String? nextAction;
  final String? parkedReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RestartCapsuleRow({
    required this.id,
    required this.projectId,
    this.lastKnownState,
    this.lastOutput,
    this.whatWorked,
    this.blocker,
    this.nextAction,
    this.parkedReason,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    if (!nullToAbsent || lastKnownState != null) {
      map['last_known_state'] = Variable<String>(lastKnownState);
    }
    if (!nullToAbsent || lastOutput != null) {
      map['last_output'] = Variable<String>(lastOutput);
    }
    if (!nullToAbsent || whatWorked != null) {
      map['what_worked'] = Variable<String>(whatWorked);
    }
    if (!nullToAbsent || blocker != null) {
      map['blocker'] = Variable<String>(blocker);
    }
    if (!nullToAbsent || nextAction != null) {
      map['next_action'] = Variable<String>(nextAction);
    }
    if (!nullToAbsent || parkedReason != null) {
      map['parked_reason'] = Variable<String>(parkedReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RestartCapsulesCompanion toCompanion(bool nullToAbsent) {
    return RestartCapsulesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      lastKnownState: lastKnownState == null && nullToAbsent
          ? const Value.absent()
          : Value(lastKnownState),
      lastOutput: lastOutput == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOutput),
      whatWorked: whatWorked == null && nullToAbsent
          ? const Value.absent()
          : Value(whatWorked),
      blocker: blocker == null && nullToAbsent
          ? const Value.absent()
          : Value(blocker),
      nextAction: nextAction == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAction),
      parkedReason: parkedReason == null && nullToAbsent
          ? const Value.absent()
          : Value(parkedReason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RestartCapsuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestartCapsuleRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      lastKnownState: serializer.fromJson<String?>(json['lastKnownState']),
      lastOutput: serializer.fromJson<String?>(json['lastOutput']),
      whatWorked: serializer.fromJson<String?>(json['whatWorked']),
      blocker: serializer.fromJson<String?>(json['blocker']),
      nextAction: serializer.fromJson<String?>(json['nextAction']),
      parkedReason: serializer.fromJson<String?>(json['parkedReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'lastKnownState': serializer.toJson<String?>(lastKnownState),
      'lastOutput': serializer.toJson<String?>(lastOutput),
      'whatWorked': serializer.toJson<String?>(whatWorked),
      'blocker': serializer.toJson<String?>(blocker),
      'nextAction': serializer.toJson<String?>(nextAction),
      'parkedReason': serializer.toJson<String?>(parkedReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RestartCapsuleRow copyWith({
    String? id,
    String? projectId,
    Value<String?> lastKnownState = const Value.absent(),
    Value<String?> lastOutput = const Value.absent(),
    Value<String?> whatWorked = const Value.absent(),
    Value<String?> blocker = const Value.absent(),
    Value<String?> nextAction = const Value.absent(),
    Value<String?> parkedReason = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RestartCapsuleRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    lastKnownState: lastKnownState.present
        ? lastKnownState.value
        : this.lastKnownState,
    lastOutput: lastOutput.present ? lastOutput.value : this.lastOutput,
    whatWorked: whatWorked.present ? whatWorked.value : this.whatWorked,
    blocker: blocker.present ? blocker.value : this.blocker,
    nextAction: nextAction.present ? nextAction.value : this.nextAction,
    parkedReason: parkedReason.present ? parkedReason.value : this.parkedReason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RestartCapsuleRow copyWithCompanion(RestartCapsulesCompanion data) {
    return RestartCapsuleRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      lastKnownState: data.lastKnownState.present
          ? data.lastKnownState.value
          : this.lastKnownState,
      lastOutput: data.lastOutput.present
          ? data.lastOutput.value
          : this.lastOutput,
      whatWorked: data.whatWorked.present
          ? data.whatWorked.value
          : this.whatWorked,
      blocker: data.blocker.present ? data.blocker.value : this.blocker,
      nextAction: data.nextAction.present
          ? data.nextAction.value
          : this.nextAction,
      parkedReason: data.parkedReason.present
          ? data.parkedReason.value
          : this.parkedReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestartCapsuleRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('lastKnownState: $lastKnownState, ')
          ..write('lastOutput: $lastOutput, ')
          ..write('whatWorked: $whatWorked, ')
          ..write('blocker: $blocker, ')
          ..write('nextAction: $nextAction, ')
          ..write('parkedReason: $parkedReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    lastKnownState,
    lastOutput,
    whatWorked,
    blocker,
    nextAction,
    parkedReason,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestartCapsuleRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.lastKnownState == this.lastKnownState &&
          other.lastOutput == this.lastOutput &&
          other.whatWorked == this.whatWorked &&
          other.blocker == this.blocker &&
          other.nextAction == this.nextAction &&
          other.parkedReason == this.parkedReason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RestartCapsulesCompanion extends UpdateCompanion<RestartCapsuleRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String?> lastKnownState;
  final Value<String?> lastOutput;
  final Value<String?> whatWorked;
  final Value<String?> blocker;
  final Value<String?> nextAction;
  final Value<String?> parkedReason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RestartCapsulesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.lastKnownState = const Value.absent(),
    this.lastOutput = const Value.absent(),
    this.whatWorked = const Value.absent(),
    this.blocker = const Value.absent(),
    this.nextAction = const Value.absent(),
    this.parkedReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RestartCapsulesCompanion.insert({
    required String id,
    required String projectId,
    this.lastKnownState = const Value.absent(),
    this.lastOutput = const Value.absent(),
    this.whatWorked = const Value.absent(),
    this.blocker = const Value.absent(),
    this.nextAction = const Value.absent(),
    this.parkedReason = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RestartCapsuleRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? lastKnownState,
    Expression<String>? lastOutput,
    Expression<String>? whatWorked,
    Expression<String>? blocker,
    Expression<String>? nextAction,
    Expression<String>? parkedReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (lastKnownState != null) 'last_known_state': lastKnownState,
      if (lastOutput != null) 'last_output': lastOutput,
      if (whatWorked != null) 'what_worked': whatWorked,
      if (blocker != null) 'blocker': blocker,
      if (nextAction != null) 'next_action': nextAction,
      if (parkedReason != null) 'parked_reason': parkedReason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RestartCapsulesCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String?>? lastKnownState,
    Value<String?>? lastOutput,
    Value<String?>? whatWorked,
    Value<String?>? blocker,
    Value<String?>? nextAction,
    Value<String?>? parkedReason,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RestartCapsulesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      lastKnownState: lastKnownState ?? this.lastKnownState,
      lastOutput: lastOutput ?? this.lastOutput,
      whatWorked: whatWorked ?? this.whatWorked,
      blocker: blocker ?? this.blocker,
      nextAction: nextAction ?? this.nextAction,
      parkedReason: parkedReason ?? this.parkedReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (lastKnownState.present) {
      map['last_known_state'] = Variable<String>(lastKnownState.value);
    }
    if (lastOutput.present) {
      map['last_output'] = Variable<String>(lastOutput.value);
    }
    if (whatWorked.present) {
      map['what_worked'] = Variable<String>(whatWorked.value);
    }
    if (blocker.present) {
      map['blocker'] = Variable<String>(blocker.value);
    }
    if (nextAction.present) {
      map['next_action'] = Variable<String>(nextAction.value);
    }
    if (parkedReason.present) {
      map['parked_reason'] = Variable<String>(parkedReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestartCapsulesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('lastKnownState: $lastKnownState, ')
          ..write('lastOutput: $lastOutput, ')
          ..write('whatWorked: $whatWorked, ')
          ..write('blocker: $blocker, ')
          ..write('nextAction: $nextAction, ')
          ..write('parkedReason: $parkedReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyCheckInsTable extends DailyCheckIns
    with TableInfo<$DailyCheckInsTable, DailyCheckInRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInDateMeta = const VerificationMeta(
    'checkInDate',
  );
  @override
  late final GeneratedColumn<DateTime> checkInDate = GeneratedColumn<DateTime>(
    'check_in_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<String> energyLevel = GeneratedColumn<String>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableMinutesMeta = const VerificationMeta(
    'availableMinutes',
  );
  @override
  late final GeneratedColumn<int> availableMinutes = GeneratedColumn<int>(
    'available_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkInDate,
    energyLevel,
    availableMinutes,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCheckInRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_in_date')) {
      context.handle(
        _checkInDateMeta,
        checkInDate.isAcceptableOrUnknown(
          data['check_in_date']!,
          _checkInDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checkInDateMeta);
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyLevelMeta);
    }
    if (data.containsKey('available_minutes')) {
      context.handle(
        _availableMinutesMeta,
        availableMinutes.isAcceptableOrUnknown(
          data['available_minutes']!,
          _availableMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableMinutesMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyCheckInRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCheckInRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkInDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in_date'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_level'],
      )!,
      availableMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_minutes'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyCheckInsTable createAlias(String alias) {
    return $DailyCheckInsTable(attachedDatabase, alias);
  }
}

class DailyCheckInRow extends DataClass implements Insertable<DailyCheckInRow> {
  final String id;
  final DateTime checkInDate;
  final String energyLevel;
  final int availableMinutes;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyCheckInRow({
    required this.id,
    required this.checkInDate,
    required this.energyLevel,
    required this.availableMinutes,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_in_date'] = Variable<DateTime>(checkInDate);
    map['energy_level'] = Variable<String>(energyLevel);
    map['available_minutes'] = Variable<int>(availableMinutes);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyCheckInsCompanion toCompanion(bool nullToAbsent) {
    return DailyCheckInsCompanion(
      id: Value(id),
      checkInDate: Value(checkInDate),
      energyLevel: Value(energyLevel),
      availableMinutes: Value(availableMinutes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyCheckInRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCheckInRow(
      id: serializer.fromJson<String>(json['id']),
      checkInDate: serializer.fromJson<DateTime>(json['checkInDate']),
      energyLevel: serializer.fromJson<String>(json['energyLevel']),
      availableMinutes: serializer.fromJson<int>(json['availableMinutes']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkInDate': serializer.toJson<DateTime>(checkInDate),
      'energyLevel': serializer.toJson<String>(energyLevel),
      'availableMinutes': serializer.toJson<int>(availableMinutes),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyCheckInRow copyWith({
    String? id,
    DateTime? checkInDate,
    String? energyLevel,
    int? availableMinutes,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DailyCheckInRow(
    id: id ?? this.id,
    checkInDate: checkInDate ?? this.checkInDate,
    energyLevel: energyLevel ?? this.energyLevel,
    availableMinutes: availableMinutes ?? this.availableMinutes,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyCheckInRow copyWithCompanion(DailyCheckInsCompanion data) {
    return DailyCheckInRow(
      id: data.id.present ? data.id.value : this.id,
      checkInDate: data.checkInDate.present
          ? data.checkInDate.value
          : this.checkInDate,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      availableMinutes: data.availableMinutes.present
          ? data.availableMinutes.value
          : this.availableMinutes,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckInRow(')
          ..write('id: $id, ')
          ..write('checkInDate: $checkInDate, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('availableMinutes: $availableMinutes, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkInDate,
    energyLevel,
    availableMinutes,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCheckInRow &&
          other.id == this.id &&
          other.checkInDate == this.checkInDate &&
          other.energyLevel == this.energyLevel &&
          other.availableMinutes == this.availableMinutes &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyCheckInsCompanion extends UpdateCompanion<DailyCheckInRow> {
  final Value<String> id;
  final Value<DateTime> checkInDate;
  final Value<String> energyLevel;
  final Value<int> availableMinutes;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyCheckInsCompanion({
    this.id = const Value.absent(),
    this.checkInDate = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.availableMinutes = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCheckInsCompanion.insert({
    required String id,
    required DateTime checkInDate,
    required String energyLevel,
    required int availableMinutes,
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkInDate = Value(checkInDate),
       energyLevel = Value(energyLevel),
       availableMinutes = Value(availableMinutes),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DailyCheckInRow> custom({
    Expression<String>? id,
    Expression<DateTime>? checkInDate,
    Expression<String>? energyLevel,
    Expression<int>? availableMinutes,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkInDate != null) 'check_in_date': checkInDate,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (availableMinutes != null) 'available_minutes': availableMinutes,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCheckInsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? checkInDate,
    Value<String>? energyLevel,
    Value<int>? availableMinutes,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyCheckInsCompanion(
      id: id ?? this.id,
      checkInDate: checkInDate ?? this.checkInDate,
      energyLevel: energyLevel ?? this.energyLevel,
      availableMinutes: availableMinutes ?? this.availableMinutes,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkInDate.present) {
      map['check_in_date'] = Variable<DateTime>(checkInDate.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<String>(energyLevel.value);
    }
    if (availableMinutes.present) {
      map['available_minutes'] = Variable<int>(availableMinutes.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckInsCompanion(')
          ..write('id: $id, ')
          ..write('checkInDate: $checkInDate, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('availableMinutes: $availableMinutes, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SprintsTable extends Sprints with TableInfo<$SprintsTable, SprintRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SprintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hypothesisMeta = const VerificationMeta(
    'hypothesis',
  );
  @override
  late final GeneratedColumn<String> hypothesis = GeneratedColumn<String>(
    'hypothesis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetOutputsMeta = const VerificationMeta(
    'targetOutputs',
  );
  @override
  late final GeneratedColumn<int> targetOutputs = GeneratedColumn<int>(
    'target_outputs',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _successCriteriaMeta = const VerificationMeta(
    'successCriteria',
  );
  @override
  late final GeneratedColumn<String> successCriteria = GeneratedColumn<String>(
    'success_criteria',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    name,
    hypothesis,
    startDate,
    endDate,
    targetOutputs,
    successCriteria,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sprints';
  @override
  VerificationContext validateIntegrity(
    Insertable<SprintRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('hypothesis')) {
      context.handle(
        _hypothesisMeta,
        hypothesis.isAcceptableOrUnknown(data['hypothesis']!, _hypothesisMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('target_outputs')) {
      context.handle(
        _targetOutputsMeta,
        targetOutputs.isAcceptableOrUnknown(
          data['target_outputs']!,
          _targetOutputsMeta,
        ),
      );
    }
    if (data.containsKey('success_criteria')) {
      context.handle(
        _successCriteriaMeta,
        successCriteria.isAcceptableOrUnknown(
          data['success_criteria']!,
          _successCriteriaMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SprintRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SprintRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hypothesis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hypothesis'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      targetOutputs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_outputs'],
      ),
      successCriteria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}success_criteria'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SprintsTable createAlias(String alias) {
    return $SprintsTable(attachedDatabase, alias);
  }
}

class SprintRow extends DataClass implements Insertable<SprintRow> {
  final String id;
  final String projectId;
  final String name;
  final String? hypothesis;
  final DateTime startDate;
  final DateTime endDate;
  final int? targetOutputs;
  final String? successCriteria;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SprintRow({
    required this.id,
    required this.projectId,
    required this.name,
    this.hypothesis,
    required this.startDate,
    required this.endDate,
    this.targetOutputs,
    this.successCriteria,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || hypothesis != null) {
      map['hypothesis'] = Variable<String>(hypothesis);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    if (!nullToAbsent || targetOutputs != null) {
      map['target_outputs'] = Variable<int>(targetOutputs);
    }
    if (!nullToAbsent || successCriteria != null) {
      map['success_criteria'] = Variable<String>(successCriteria);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SprintsCompanion toCompanion(bool nullToAbsent) {
    return SprintsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      name: Value(name),
      hypothesis: hypothesis == null && nullToAbsent
          ? const Value.absent()
          : Value(hypothesis),
      startDate: Value(startDate),
      endDate: Value(endDate),
      targetOutputs: targetOutputs == null && nullToAbsent
          ? const Value.absent()
          : Value(targetOutputs),
      successCriteria: successCriteria == null && nullToAbsent
          ? const Value.absent()
          : Value(successCriteria),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SprintRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SprintRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      name: serializer.fromJson<String>(json['name']),
      hypothesis: serializer.fromJson<String?>(json['hypothesis']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      targetOutputs: serializer.fromJson<int?>(json['targetOutputs']),
      successCriteria: serializer.fromJson<String?>(json['successCriteria']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'name': serializer.toJson<String>(name),
      'hypothesis': serializer.toJson<String?>(hypothesis),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'targetOutputs': serializer.toJson<int?>(targetOutputs),
      'successCriteria': serializer.toJson<String?>(successCriteria),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SprintRow copyWith({
    String? id,
    String? projectId,
    String? name,
    Value<String?> hypothesis = const Value.absent(),
    DateTime? startDate,
    DateTime? endDate,
    Value<int?> targetOutputs = const Value.absent(),
    Value<String?> successCriteria = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SprintRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    name: name ?? this.name,
    hypothesis: hypothesis.present ? hypothesis.value : this.hypothesis,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    targetOutputs: targetOutputs.present
        ? targetOutputs.value
        : this.targetOutputs,
    successCriteria: successCriteria.present
        ? successCriteria.value
        : this.successCriteria,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SprintRow copyWithCompanion(SprintsCompanion data) {
    return SprintRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      name: data.name.present ? data.name.value : this.name,
      hypothesis: data.hypothesis.present
          ? data.hypothesis.value
          : this.hypothesis,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      targetOutputs: data.targetOutputs.present
          ? data.targetOutputs.value
          : this.targetOutputs,
      successCriteria: data.successCriteria.present
          ? data.successCriteria.value
          : this.successCriteria,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SprintRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('hypothesis: $hypothesis, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('targetOutputs: $targetOutputs, ')
          ..write('successCriteria: $successCriteria, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    name,
    hypothesis,
    startDate,
    endDate,
    targetOutputs,
    successCriteria,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SprintRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.name == this.name &&
          other.hypothesis == this.hypothesis &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.targetOutputs == this.targetOutputs &&
          other.successCriteria == this.successCriteria &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SprintsCompanion extends UpdateCompanion<SprintRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> name;
  final Value<String?> hypothesis;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<int?> targetOutputs;
  final Value<String?> successCriteria;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SprintsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.name = const Value.absent(),
    this.hypothesis = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.targetOutputs = const Value.absent(),
    this.successCriteria = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SprintsCompanion.insert({
    required String id,
    required String projectId,
    required String name,
    this.hypothesis = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.targetOutputs = const Value.absent(),
    this.successCriteria = const Value.absent(),
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       name = Value(name),
       startDate = Value(startDate),
       endDate = Value(endDate),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SprintRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? name,
    Expression<String>? hypothesis,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? targetOutputs,
    Expression<String>? successCriteria,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (name != null) 'name': name,
      if (hypothesis != null) 'hypothesis': hypothesis,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (targetOutputs != null) 'target_outputs': targetOutputs,
      if (successCriteria != null) 'success_criteria': successCriteria,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SprintsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? name,
    Value<String?>? hypothesis,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<int?>? targetOutputs,
    Value<String?>? successCriteria,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SprintsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      hypothesis: hypothesis ?? this.hypothesis,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      targetOutputs: targetOutputs ?? this.targetOutputs,
      successCriteria: successCriteria ?? this.successCriteria,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hypothesis.present) {
      map['hypothesis'] = Variable<String>(hypothesis.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (targetOutputs.present) {
      map['target_outputs'] = Variable<int>(targetOutputs.value);
    }
    if (successCriteria.present) {
      map['success_criteria'] = Variable<String>(successCriteria.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SprintsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('hypothesis: $hypothesis, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('targetOutputs: $targetOutputs, ')
          ..write('successCriteria: $successCriteria, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyPlansTable extends DailyPlans
    with TableInfo<$DailyPlansTable, DailyPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sprintIdMeta = const VerificationMeta(
    'sprintId',
  );
  @override
  late final GeneratedColumn<String> sprintId = GeneratedColumn<String>(
    'sprint_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sprints (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _planDateMeta = const VerificationMeta(
    'planDate',
  );
  @override
  late final GeneratedColumn<DateTime> planDate = GeneratedColumn<DateTime>(
    'plan_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requiredOutcomeMeta = const VerificationMeta(
    'requiredOutcome',
  );
  @override
  late final GeneratedColumn<String> requiredOutcome = GeneratedColumn<String>(
    'required_outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lowEnergyActionMeta = const VerificationMeta(
    'lowEnergyAction',
  );
  @override
  late final GeneratedColumn<String> lowEnergyAction = GeneratedColumn<String>(
    'low_energy_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedGuideDocumentIdMeta =
      const VerificationMeta('linkedGuideDocumentId');
  @override
  late final GeneratedColumn<String> linkedGuideDocumentId =
      GeneratedColumn<String>(
        'linked_guide_document_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _linkedGuidePageMeta = const VerificationMeta(
    'linkedGuidePage',
  );
  @override
  late final GeneratedColumn<int> linkedGuidePage = GeneratedColumn<int>(
    'linked_guide_page',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sprintId,
    planDate,
    requiredOutcome,
    lowEnergyAction,
    linkedGuideDocumentId,
    linkedGuidePage,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sprint_id')) {
      context.handle(
        _sprintIdMeta,
        sprintId.isAcceptableOrUnknown(data['sprint_id']!, _sprintIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sprintIdMeta);
    }
    if (data.containsKey('plan_date')) {
      context.handle(
        _planDateMeta,
        planDate.isAcceptableOrUnknown(data['plan_date']!, _planDateMeta),
      );
    } else if (isInserting) {
      context.missing(_planDateMeta);
    }
    if (data.containsKey('required_outcome')) {
      context.handle(
        _requiredOutcomeMeta,
        requiredOutcome.isAcceptableOrUnknown(
          data['required_outcome']!,
          _requiredOutcomeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredOutcomeMeta);
    }
    if (data.containsKey('low_energy_action')) {
      context.handle(
        _lowEnergyActionMeta,
        lowEnergyAction.isAcceptableOrUnknown(
          data['low_energy_action']!,
          _lowEnergyActionMeta,
        ),
      );
    }
    if (data.containsKey('linked_guide_document_id')) {
      context.handle(
        _linkedGuideDocumentIdMeta,
        linkedGuideDocumentId.isAcceptableOrUnknown(
          data['linked_guide_document_id']!,
          _linkedGuideDocumentIdMeta,
        ),
      );
    }
    if (data.containsKey('linked_guide_page')) {
      context.handle(
        _linkedGuidePageMeta,
        linkedGuidePage.isAcceptableOrUnknown(
          data['linked_guide_page']!,
          _linkedGuidePageMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sprintId, planDate},
  ];
  @override
  DailyPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sprintId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprint_id'],
      )!,
      planDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}plan_date'],
      )!,
      requiredOutcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}required_outcome'],
      )!,
      lowEnergyAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}low_energy_action'],
      ),
      linkedGuideDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_guide_document_id'],
      ),
      linkedGuidePage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}linked_guide_page'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyPlansTable createAlias(String alias) {
    return $DailyPlansTable(attachedDatabase, alias);
  }
}

class DailyPlanRow extends DataClass implements Insertable<DailyPlanRow> {
  final String id;
  final String sprintId;
  final DateTime planDate;
  final String requiredOutcome;
  final String? lowEnergyAction;
  final String? linkedGuideDocumentId;
  final int? linkedGuidePage;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyPlanRow({
    required this.id,
    required this.sprintId,
    required this.planDate,
    required this.requiredOutcome,
    this.lowEnergyAction,
    this.linkedGuideDocumentId,
    this.linkedGuidePage,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sprint_id'] = Variable<String>(sprintId);
    map['plan_date'] = Variable<DateTime>(planDate);
    map['required_outcome'] = Variable<String>(requiredOutcome);
    if (!nullToAbsent || lowEnergyAction != null) {
      map['low_energy_action'] = Variable<String>(lowEnergyAction);
    }
    if (!nullToAbsent || linkedGuideDocumentId != null) {
      map['linked_guide_document_id'] = Variable<String>(linkedGuideDocumentId);
    }
    if (!nullToAbsent || linkedGuidePage != null) {
      map['linked_guide_page'] = Variable<int>(linkedGuidePage);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyPlansCompanion toCompanion(bool nullToAbsent) {
    return DailyPlansCompanion(
      id: Value(id),
      sprintId: Value(sprintId),
      planDate: Value(planDate),
      requiredOutcome: Value(requiredOutcome),
      lowEnergyAction: lowEnergyAction == null && nullToAbsent
          ? const Value.absent()
          : Value(lowEnergyAction),
      linkedGuideDocumentId: linkedGuideDocumentId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedGuideDocumentId),
      linkedGuidePage: linkedGuidePage == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedGuidePage),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyPlanRow(
      id: serializer.fromJson<String>(json['id']),
      sprintId: serializer.fromJson<String>(json['sprintId']),
      planDate: serializer.fromJson<DateTime>(json['planDate']),
      requiredOutcome: serializer.fromJson<String>(json['requiredOutcome']),
      lowEnergyAction: serializer.fromJson<String?>(json['lowEnergyAction']),
      linkedGuideDocumentId: serializer.fromJson<String?>(
        json['linkedGuideDocumentId'],
      ),
      linkedGuidePage: serializer.fromJson<int?>(json['linkedGuidePage']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sprintId': serializer.toJson<String>(sprintId),
      'planDate': serializer.toJson<DateTime>(planDate),
      'requiredOutcome': serializer.toJson<String>(requiredOutcome),
      'lowEnergyAction': serializer.toJson<String?>(lowEnergyAction),
      'linkedGuideDocumentId': serializer.toJson<String?>(
        linkedGuideDocumentId,
      ),
      'linkedGuidePage': serializer.toJson<int?>(linkedGuidePage),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyPlanRow copyWith({
    String? id,
    String? sprintId,
    DateTime? planDate,
    String? requiredOutcome,
    Value<String?> lowEnergyAction = const Value.absent(),
    Value<String?> linkedGuideDocumentId = const Value.absent(),
    Value<int?> linkedGuidePage = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DailyPlanRow(
    id: id ?? this.id,
    sprintId: sprintId ?? this.sprintId,
    planDate: planDate ?? this.planDate,
    requiredOutcome: requiredOutcome ?? this.requiredOutcome,
    lowEnergyAction: lowEnergyAction.present
        ? lowEnergyAction.value
        : this.lowEnergyAction,
    linkedGuideDocumentId: linkedGuideDocumentId.present
        ? linkedGuideDocumentId.value
        : this.linkedGuideDocumentId,
    linkedGuidePage: linkedGuidePage.present
        ? linkedGuidePage.value
        : this.linkedGuidePage,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyPlanRow copyWithCompanion(DailyPlansCompanion data) {
    return DailyPlanRow(
      id: data.id.present ? data.id.value : this.id,
      sprintId: data.sprintId.present ? data.sprintId.value : this.sprintId,
      planDate: data.planDate.present ? data.planDate.value : this.planDate,
      requiredOutcome: data.requiredOutcome.present
          ? data.requiredOutcome.value
          : this.requiredOutcome,
      lowEnergyAction: data.lowEnergyAction.present
          ? data.lowEnergyAction.value
          : this.lowEnergyAction,
      linkedGuideDocumentId: data.linkedGuideDocumentId.present
          ? data.linkedGuideDocumentId.value
          : this.linkedGuideDocumentId,
      linkedGuidePage: data.linkedGuidePage.present
          ? data.linkedGuidePage.value
          : this.linkedGuidePage,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyPlanRow(')
          ..write('id: $id, ')
          ..write('sprintId: $sprintId, ')
          ..write('planDate: $planDate, ')
          ..write('requiredOutcome: $requiredOutcome, ')
          ..write('lowEnergyAction: $lowEnergyAction, ')
          ..write('linkedGuideDocumentId: $linkedGuideDocumentId, ')
          ..write('linkedGuidePage: $linkedGuidePage, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sprintId,
    planDate,
    requiredOutcome,
    lowEnergyAction,
    linkedGuideDocumentId,
    linkedGuidePage,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyPlanRow &&
          other.id == this.id &&
          other.sprintId == this.sprintId &&
          other.planDate == this.planDate &&
          other.requiredOutcome == this.requiredOutcome &&
          other.lowEnergyAction == this.lowEnergyAction &&
          other.linkedGuideDocumentId == this.linkedGuideDocumentId &&
          other.linkedGuidePage == this.linkedGuidePage &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyPlansCompanion extends UpdateCompanion<DailyPlanRow> {
  final Value<String> id;
  final Value<String> sprintId;
  final Value<DateTime> planDate;
  final Value<String> requiredOutcome;
  final Value<String?> lowEnergyAction;
  final Value<String?> linkedGuideDocumentId;
  final Value<int?> linkedGuidePage;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyPlansCompanion({
    this.id = const Value.absent(),
    this.sprintId = const Value.absent(),
    this.planDate = const Value.absent(),
    this.requiredOutcome = const Value.absent(),
    this.lowEnergyAction = const Value.absent(),
    this.linkedGuideDocumentId = const Value.absent(),
    this.linkedGuidePage = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyPlansCompanion.insert({
    required String id,
    required String sprintId,
    required DateTime planDate,
    required String requiredOutcome,
    this.lowEnergyAction = const Value.absent(),
    this.linkedGuideDocumentId = const Value.absent(),
    this.linkedGuidePage = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sprintId = Value(sprintId),
       planDate = Value(planDate),
       requiredOutcome = Value(requiredOutcome),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DailyPlanRow> custom({
    Expression<String>? id,
    Expression<String>? sprintId,
    Expression<DateTime>? planDate,
    Expression<String>? requiredOutcome,
    Expression<String>? lowEnergyAction,
    Expression<String>? linkedGuideDocumentId,
    Expression<int>? linkedGuidePage,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sprintId != null) 'sprint_id': sprintId,
      if (planDate != null) 'plan_date': planDate,
      if (requiredOutcome != null) 'required_outcome': requiredOutcome,
      if (lowEnergyAction != null) 'low_energy_action': lowEnergyAction,
      if (linkedGuideDocumentId != null)
        'linked_guide_document_id': linkedGuideDocumentId,
      if (linkedGuidePage != null) 'linked_guide_page': linkedGuidePage,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? sprintId,
    Value<DateTime>? planDate,
    Value<String>? requiredOutcome,
    Value<String?>? lowEnergyAction,
    Value<String?>? linkedGuideDocumentId,
    Value<int?>? linkedGuidePage,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyPlansCompanion(
      id: id ?? this.id,
      sprintId: sprintId ?? this.sprintId,
      planDate: planDate ?? this.planDate,
      requiredOutcome: requiredOutcome ?? this.requiredOutcome,
      lowEnergyAction: lowEnergyAction ?? this.lowEnergyAction,
      linkedGuideDocumentId:
          linkedGuideDocumentId ?? this.linkedGuideDocumentId,
      linkedGuidePage: linkedGuidePage ?? this.linkedGuidePage,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sprintId.present) {
      map['sprint_id'] = Variable<String>(sprintId.value);
    }
    if (planDate.present) {
      map['plan_date'] = Variable<DateTime>(planDate.value);
    }
    if (requiredOutcome.present) {
      map['required_outcome'] = Variable<String>(requiredOutcome.value);
    }
    if (lowEnergyAction.present) {
      map['low_energy_action'] = Variable<String>(lowEnergyAction.value);
    }
    if (linkedGuideDocumentId.present) {
      map['linked_guide_document_id'] = Variable<String>(
        linkedGuideDocumentId.value,
      );
    }
    if (linkedGuidePage.present) {
      map['linked_guide_page'] = Variable<int>(linkedGuidePage.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyPlansCompanion(')
          ..write('id: $id, ')
          ..write('sprintId: $sprintId, ')
          ..write('planDate: $planDate, ')
          ..write('requiredOutcome: $requiredOutcome, ')
          ..write('lowEnergyAction: $lowEnergyAction, ')
          ..write('linkedGuideDocumentId: $linkedGuideDocumentId, ')
          ..write('linkedGuidePage: $linkedGuidePage, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyActionsTable extends DailyActions
    with TableInfo<$DailyActionsTable, DailyActionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyPlanIdMeta = const VerificationMeta(
    'dailyPlanId',
  );
  @override
  late final GeneratedColumn<String> dailyPlanId = GeneratedColumn<String>(
    'daily_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyPlanId,
    position,
    label,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyActionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('daily_plan_id')) {
      context.handle(
        _dailyPlanIdMeta,
        dailyPlanId.isAcceptableOrUnknown(
          data['daily_plan_id']!,
          _dailyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyPlanIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {dailyPlanId, position},
  ];
  @override
  DailyActionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyActionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dailyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_plan_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyActionsTable createAlias(String alias) {
    return $DailyActionsTable(attachedDatabase, alias);
  }
}

class DailyActionRow extends DataClass implements Insertable<DailyActionRow> {
  final String id;
  final String dailyPlanId;
  final int position;
  final String label;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyActionRow({
    required this.id,
    required this.dailyPlanId,
    required this.position,
    required this.label,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['daily_plan_id'] = Variable<String>(dailyPlanId);
    map['position'] = Variable<int>(position);
    map['label'] = Variable<String>(label);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyActionsCompanion toCompanion(bool nullToAbsent) {
    return DailyActionsCompanion(
      id: Value(id),
      dailyPlanId: Value(dailyPlanId),
      position: Value(position),
      label: Value(label),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyActionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyActionRow(
      id: serializer.fromJson<String>(json['id']),
      dailyPlanId: serializer.fromJson<String>(json['dailyPlanId']),
      position: serializer.fromJson<int>(json['position']),
      label: serializer.fromJson<String>(json['label']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dailyPlanId': serializer.toJson<String>(dailyPlanId),
      'position': serializer.toJson<int>(position),
      'label': serializer.toJson<String>(label),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyActionRow copyWith({
    String? id,
    String? dailyPlanId,
    int? position,
    String? label,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DailyActionRow(
    id: id ?? this.id,
    dailyPlanId: dailyPlanId ?? this.dailyPlanId,
    position: position ?? this.position,
    label: label ?? this.label,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyActionRow copyWithCompanion(DailyActionsCompanion data) {
    return DailyActionRow(
      id: data.id.present ? data.id.value : this.id,
      dailyPlanId: data.dailyPlanId.present
          ? data.dailyPlanId.value
          : this.dailyPlanId,
      position: data.position.present ? data.position.value : this.position,
      label: data.label.present ? data.label.value : this.label,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyActionRow(')
          ..write('id: $id, ')
          ..write('dailyPlanId: $dailyPlanId, ')
          ..write('position: $position, ')
          ..write('label: $label, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dailyPlanId,
    position,
    label,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyActionRow &&
          other.id == this.id &&
          other.dailyPlanId == this.dailyPlanId &&
          other.position == this.position &&
          other.label == this.label &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyActionsCompanion extends UpdateCompanion<DailyActionRow> {
  final Value<String> id;
  final Value<String> dailyPlanId;
  final Value<int> position;
  final Value<String> label;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyActionsCompanion({
    this.id = const Value.absent(),
    this.dailyPlanId = const Value.absent(),
    this.position = const Value.absent(),
    this.label = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyActionsCompanion.insert({
    required String id,
    required String dailyPlanId,
    required int position,
    required String label,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dailyPlanId = Value(dailyPlanId),
       position = Value(position),
       label = Value(label),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DailyActionRow> custom({
    Expression<String>? id,
    Expression<String>? dailyPlanId,
    Expression<int>? position,
    Expression<String>? label,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyPlanId != null) 'daily_plan_id': dailyPlanId,
      if (position != null) 'position': position,
      if (label != null) 'label': label,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyActionsCompanion copyWith({
    Value<String>? id,
    Value<String>? dailyPlanId,
    Value<int>? position,
    Value<String>? label,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyActionsCompanion(
      id: id ?? this.id,
      dailyPlanId: dailyPlanId ?? this.dailyPlanId,
      position: position ?? this.position,
      label: label ?? this.label,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dailyPlanId.present) {
      map['daily_plan_id'] = Variable<String>(dailyPlanId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyActionsCompanion(')
          ..write('id: $id, ')
          ..write('dailyPlanId: $dailyPlanId, ')
          ..write('position: $position, ')
          ..write('label: $label, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShipRecordsTable extends ShipRecords
    with TableInfo<$ShipRecordsTable, ShipRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShipRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyPlanIdMeta = const VerificationMeta(
    'dailyPlanId',
  );
  @override
  late final GeneratedColumn<String> dailyPlanId = GeneratedColumn<String>(
    'daily_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES daily_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _outputTypeMeta = const VerificationMeta(
    'outputType',
  );
  @override
  late final GeneratedColumn<String> outputType = GeneratedColumn<String>(
    'output_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outputTitleMeta = const VerificationMeta(
    'outputTitle',
  );
  @override
  late final GeneratedColumn<String> outputTitle = GeneratedColumn<String>(
    'output_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalUrlMeta = const VerificationMeta(
    'externalUrl',
  );
  @override
  late final GeneratedColumn<String> externalUrl = GeneratedColumn<String>(
    'external_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _evidenceNoteMeta = const VerificationMeta(
    'evidenceNote',
  );
  @override
  late final GeneratedColumn<String> evidenceNote = GeneratedColumn<String>(
    'evidence_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPartialMeta = const VerificationMeta(
    'isPartial',
  );
  @override
  late final GeneratedColumn<bool> isPartial = GeneratedColumn<bool>(
    'is_partial',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_partial" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _shippedAtMeta = const VerificationMeta(
    'shippedAt',
  );
  @override
  late final GeneratedColumn<DateTime> shippedAt = GeneratedColumn<DateTime>(
    'shipped_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyPlanId,
    outputType,
    outputTitle,
    externalUrl,
    evidenceNote,
    isPartial,
    shippedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ship_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShipRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('daily_plan_id')) {
      context.handle(
        _dailyPlanIdMeta,
        dailyPlanId.isAcceptableOrUnknown(
          data['daily_plan_id']!,
          _dailyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyPlanIdMeta);
    }
    if (data.containsKey('output_type')) {
      context.handle(
        _outputTypeMeta,
        outputType.isAcceptableOrUnknown(data['output_type']!, _outputTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_outputTypeMeta);
    }
    if (data.containsKey('output_title')) {
      context.handle(
        _outputTitleMeta,
        outputTitle.isAcceptableOrUnknown(
          data['output_title']!,
          _outputTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outputTitleMeta);
    }
    if (data.containsKey('external_url')) {
      context.handle(
        _externalUrlMeta,
        externalUrl.isAcceptableOrUnknown(
          data['external_url']!,
          _externalUrlMeta,
        ),
      );
    }
    if (data.containsKey('evidence_note')) {
      context.handle(
        _evidenceNoteMeta,
        evidenceNote.isAcceptableOrUnknown(
          data['evidence_note']!,
          _evidenceNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_partial')) {
      context.handle(
        _isPartialMeta,
        isPartial.isAcceptableOrUnknown(data['is_partial']!, _isPartialMeta),
      );
    }
    if (data.containsKey('shipped_at')) {
      context.handle(
        _shippedAtMeta,
        shippedAt.isAcceptableOrUnknown(data['shipped_at']!, _shippedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_shippedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShipRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShipRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dailyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_plan_id'],
      )!,
      outputType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}output_type'],
      )!,
      outputTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}output_title'],
      )!,
      externalUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_url'],
      ),
      evidenceNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence_note'],
      ),
      isPartial: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_partial'],
      )!,
      shippedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}shipped_at'],
      )!,
    );
  }

  @override
  $ShipRecordsTable createAlias(String alias) {
    return $ShipRecordsTable(attachedDatabase, alias);
  }
}

class ShipRecordRow extends DataClass implements Insertable<ShipRecordRow> {
  final String id;
  final String dailyPlanId;
  final String outputType;
  final String outputTitle;
  final String? externalUrl;
  final String? evidenceNote;
  final bool isPartial;
  final DateTime shippedAt;
  const ShipRecordRow({
    required this.id,
    required this.dailyPlanId,
    required this.outputType,
    required this.outputTitle,
    this.externalUrl,
    this.evidenceNote,
    required this.isPartial,
    required this.shippedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['daily_plan_id'] = Variable<String>(dailyPlanId);
    map['output_type'] = Variable<String>(outputType);
    map['output_title'] = Variable<String>(outputTitle);
    if (!nullToAbsent || externalUrl != null) {
      map['external_url'] = Variable<String>(externalUrl);
    }
    if (!nullToAbsent || evidenceNote != null) {
      map['evidence_note'] = Variable<String>(evidenceNote);
    }
    map['is_partial'] = Variable<bool>(isPartial);
    map['shipped_at'] = Variable<DateTime>(shippedAt);
    return map;
  }

  ShipRecordsCompanion toCompanion(bool nullToAbsent) {
    return ShipRecordsCompanion(
      id: Value(id),
      dailyPlanId: Value(dailyPlanId),
      outputType: Value(outputType),
      outputTitle: Value(outputTitle),
      externalUrl: externalUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(externalUrl),
      evidenceNote: evidenceNote == null && nullToAbsent
          ? const Value.absent()
          : Value(evidenceNote),
      isPartial: Value(isPartial),
      shippedAt: Value(shippedAt),
    );
  }

  factory ShipRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShipRecordRow(
      id: serializer.fromJson<String>(json['id']),
      dailyPlanId: serializer.fromJson<String>(json['dailyPlanId']),
      outputType: serializer.fromJson<String>(json['outputType']),
      outputTitle: serializer.fromJson<String>(json['outputTitle']),
      externalUrl: serializer.fromJson<String?>(json['externalUrl']),
      evidenceNote: serializer.fromJson<String?>(json['evidenceNote']),
      isPartial: serializer.fromJson<bool>(json['isPartial']),
      shippedAt: serializer.fromJson<DateTime>(json['shippedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dailyPlanId': serializer.toJson<String>(dailyPlanId),
      'outputType': serializer.toJson<String>(outputType),
      'outputTitle': serializer.toJson<String>(outputTitle),
      'externalUrl': serializer.toJson<String?>(externalUrl),
      'evidenceNote': serializer.toJson<String?>(evidenceNote),
      'isPartial': serializer.toJson<bool>(isPartial),
      'shippedAt': serializer.toJson<DateTime>(shippedAt),
    };
  }

  ShipRecordRow copyWith({
    String? id,
    String? dailyPlanId,
    String? outputType,
    String? outputTitle,
    Value<String?> externalUrl = const Value.absent(),
    Value<String?> evidenceNote = const Value.absent(),
    bool? isPartial,
    DateTime? shippedAt,
  }) => ShipRecordRow(
    id: id ?? this.id,
    dailyPlanId: dailyPlanId ?? this.dailyPlanId,
    outputType: outputType ?? this.outputType,
    outputTitle: outputTitle ?? this.outputTitle,
    externalUrl: externalUrl.present ? externalUrl.value : this.externalUrl,
    evidenceNote: evidenceNote.present ? evidenceNote.value : this.evidenceNote,
    isPartial: isPartial ?? this.isPartial,
    shippedAt: shippedAt ?? this.shippedAt,
  );
  ShipRecordRow copyWithCompanion(ShipRecordsCompanion data) {
    return ShipRecordRow(
      id: data.id.present ? data.id.value : this.id,
      dailyPlanId: data.dailyPlanId.present
          ? data.dailyPlanId.value
          : this.dailyPlanId,
      outputType: data.outputType.present
          ? data.outputType.value
          : this.outputType,
      outputTitle: data.outputTitle.present
          ? data.outputTitle.value
          : this.outputTitle,
      externalUrl: data.externalUrl.present
          ? data.externalUrl.value
          : this.externalUrl,
      evidenceNote: data.evidenceNote.present
          ? data.evidenceNote.value
          : this.evidenceNote,
      isPartial: data.isPartial.present ? data.isPartial.value : this.isPartial,
      shippedAt: data.shippedAt.present ? data.shippedAt.value : this.shippedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShipRecordRow(')
          ..write('id: $id, ')
          ..write('dailyPlanId: $dailyPlanId, ')
          ..write('outputType: $outputType, ')
          ..write('outputTitle: $outputTitle, ')
          ..write('externalUrl: $externalUrl, ')
          ..write('evidenceNote: $evidenceNote, ')
          ..write('isPartial: $isPartial, ')
          ..write('shippedAt: $shippedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dailyPlanId,
    outputType,
    outputTitle,
    externalUrl,
    evidenceNote,
    isPartial,
    shippedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShipRecordRow &&
          other.id == this.id &&
          other.dailyPlanId == this.dailyPlanId &&
          other.outputType == this.outputType &&
          other.outputTitle == this.outputTitle &&
          other.externalUrl == this.externalUrl &&
          other.evidenceNote == this.evidenceNote &&
          other.isPartial == this.isPartial &&
          other.shippedAt == this.shippedAt);
}

class ShipRecordsCompanion extends UpdateCompanion<ShipRecordRow> {
  final Value<String> id;
  final Value<String> dailyPlanId;
  final Value<String> outputType;
  final Value<String> outputTitle;
  final Value<String?> externalUrl;
  final Value<String?> evidenceNote;
  final Value<bool> isPartial;
  final Value<DateTime> shippedAt;
  final Value<int> rowid;
  const ShipRecordsCompanion({
    this.id = const Value.absent(),
    this.dailyPlanId = const Value.absent(),
    this.outputType = const Value.absent(),
    this.outputTitle = const Value.absent(),
    this.externalUrl = const Value.absent(),
    this.evidenceNote = const Value.absent(),
    this.isPartial = const Value.absent(),
    this.shippedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShipRecordsCompanion.insert({
    required String id,
    required String dailyPlanId,
    required String outputType,
    required String outputTitle,
    this.externalUrl = const Value.absent(),
    this.evidenceNote = const Value.absent(),
    this.isPartial = const Value.absent(),
    required DateTime shippedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dailyPlanId = Value(dailyPlanId),
       outputType = Value(outputType),
       outputTitle = Value(outputTitle),
       shippedAt = Value(shippedAt);
  static Insertable<ShipRecordRow> custom({
    Expression<String>? id,
    Expression<String>? dailyPlanId,
    Expression<String>? outputType,
    Expression<String>? outputTitle,
    Expression<String>? externalUrl,
    Expression<String>? evidenceNote,
    Expression<bool>? isPartial,
    Expression<DateTime>? shippedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyPlanId != null) 'daily_plan_id': dailyPlanId,
      if (outputType != null) 'output_type': outputType,
      if (outputTitle != null) 'output_title': outputTitle,
      if (externalUrl != null) 'external_url': externalUrl,
      if (evidenceNote != null) 'evidence_note': evidenceNote,
      if (isPartial != null) 'is_partial': isPartial,
      if (shippedAt != null) 'shipped_at': shippedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShipRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? dailyPlanId,
    Value<String>? outputType,
    Value<String>? outputTitle,
    Value<String?>? externalUrl,
    Value<String?>? evidenceNote,
    Value<bool>? isPartial,
    Value<DateTime>? shippedAt,
    Value<int>? rowid,
  }) {
    return ShipRecordsCompanion(
      id: id ?? this.id,
      dailyPlanId: dailyPlanId ?? this.dailyPlanId,
      outputType: outputType ?? this.outputType,
      outputTitle: outputTitle ?? this.outputTitle,
      externalUrl: externalUrl ?? this.externalUrl,
      evidenceNote: evidenceNote ?? this.evidenceNote,
      isPartial: isPartial ?? this.isPartial,
      shippedAt: shippedAt ?? this.shippedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dailyPlanId.present) {
      map['daily_plan_id'] = Variable<String>(dailyPlanId.value);
    }
    if (outputType.present) {
      map['output_type'] = Variable<String>(outputType.value);
    }
    if (outputTitle.present) {
      map['output_title'] = Variable<String>(outputTitle.value);
    }
    if (externalUrl.present) {
      map['external_url'] = Variable<String>(externalUrl.value);
    }
    if (evidenceNote.present) {
      map['evidence_note'] = Variable<String>(evidenceNote.value);
    }
    if (isPartial.present) {
      map['is_partial'] = Variable<bool>(isPartial.value);
    }
    if (shippedAt.present) {
      map['shipped_at'] = Variable<DateTime>(shippedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShipRecordsCompanion(')
          ..write('id: $id, ')
          ..write('dailyPlanId: $dailyPlanId, ')
          ..write('outputType: $outputType, ')
          ..write('outputTitle: $outputTitle, ')
          ..write('externalUrl: $externalUrl, ')
          ..write('evidenceNote: $evidenceNote, ')
          ..write('isPartial: $isPartial, ')
          ..write('shippedAt: $shippedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GuideDocumentsTable extends GuideDocuments
    with TableInfo<$GuideDocumentsTable, GuideDocumentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuideDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalFileNameMeta = const VerificationMeta(
    'originalFileName',
  );
  @override
  late final GeneratedColumn<String> originalFileName = GeneratedColumn<String>(
    'original_file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayTitleMeta = const VerificationMeta(
    'displayTitle',
  );
  @override
  late final GeneratedColumn<String> displayTitle = GeneratedColumn<String>(
    'display_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storedRelativePathMeta =
      const VerificationMeta('storedRelativePath');
  @override
  late final GeneratedColumn<String> storedRelativePath =
      GeneratedColumn<String>(
        'stored_relative_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _whenToReadMeta = const VerificationMeta(
    'whenToRead',
  );
  @override
  late final GeneratedColumn<String> whenToRead = GeneratedColumn<String>(
    'when_to_read',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPinnedMeta = const VerificationMeta(
    'isPinned',
  );
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReadPageMeta = const VerificationMeta(
    'lastReadPage',
  );
  @override
  late final GeneratedColumn<int> lastReadPage = GeneratedColumn<int>(
    'last_read_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cleanupNeededMeta = const VerificationMeta(
    'cleanupNeeded',
  );
  @override
  late final GeneratedColumn<bool> cleanupNeeded = GeneratedColumn<bool>(
    'cleanup_needed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cleanup_needed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalFileName,
    displayTitle,
    storedRelativePath,
    fileSizeBytes,
    checksum,
    projectId,
    category,
    description,
    whenToRead,
    isPinned,
    pageCount,
    lastReadPage,
    lastOpenedAt,
    importedAt,
    updatedAt,
    cleanupNeeded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guide_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<GuideDocumentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('original_file_name')) {
      context.handle(
        _originalFileNameMeta,
        originalFileName.isAcceptableOrUnknown(
          data['original_file_name']!,
          _originalFileNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalFileNameMeta);
    }
    if (data.containsKey('display_title')) {
      context.handle(
        _displayTitleMeta,
        displayTitle.isAcceptableOrUnknown(
          data['display_title']!,
          _displayTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayTitleMeta);
    }
    if (data.containsKey('stored_relative_path')) {
      context.handle(
        _storedRelativePathMeta,
        storedRelativePath.isAcceptableOrUnknown(
          data['stored_relative_path']!,
          _storedRelativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storedRelativePathMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fileSizeBytesMeta);
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('when_to_read')) {
      context.handle(
        _whenToReadMeta,
        whenToRead.isAcceptableOrUnknown(
          data['when_to_read']!,
          _whenToReadMeta,
        ),
      );
    }
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    } else if (isInserting) {
      context.missing(_pageCountMeta);
    }
    if (data.containsKey('last_read_page')) {
      context.handle(
        _lastReadPageMeta,
        lastReadPage.isAcceptableOrUnknown(
          data['last_read_page']!,
          _lastReadPageMeta,
        ),
      );
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('cleanup_needed')) {
      context.handle(
        _cleanupNeededMeta,
        cleanupNeeded.isAcceptableOrUnknown(
          data['cleanup_needed']!,
          _cleanupNeededMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GuideDocumentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GuideDocumentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      originalFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_file_name'],
      )!,
      displayTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title'],
      )!,
      storedRelativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stored_relative_path'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      whenToRead: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}when_to_read'],
      ),
      isPinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pinned'],
      )!,
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      )!,
      lastReadPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_read_page'],
      )!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened_at'],
      ),
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cleanupNeeded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cleanup_needed'],
      )!,
    );
  }

  @override
  $GuideDocumentsTable createAlias(String alias) {
    return $GuideDocumentsTable(attachedDatabase, alias);
  }
}

class GuideDocumentRow extends DataClass
    implements Insertable<GuideDocumentRow> {
  final String id;
  final String originalFileName;
  final String displayTitle;
  final String storedRelativePath;
  final int fileSizeBytes;
  final String? checksum;
  final String? projectId;
  final String category;
  final String? description;
  final String? whenToRead;
  final bool isPinned;
  final int pageCount;
  final int lastReadPage;
  final DateTime? lastOpenedAt;
  final DateTime importedAt;
  final DateTime updatedAt;
  final bool cleanupNeeded;
  const GuideDocumentRow({
    required this.id,
    required this.originalFileName,
    required this.displayTitle,
    required this.storedRelativePath,
    required this.fileSizeBytes,
    this.checksum,
    this.projectId,
    required this.category,
    this.description,
    this.whenToRead,
    required this.isPinned,
    required this.pageCount,
    required this.lastReadPage,
    this.lastOpenedAt,
    required this.importedAt,
    required this.updatedAt,
    required this.cleanupNeeded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['original_file_name'] = Variable<String>(originalFileName);
    map['display_title'] = Variable<String>(displayTitle);
    map['stored_relative_path'] = Variable<String>(storedRelativePath);
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    if (!nullToAbsent || checksum != null) {
      map['checksum'] = Variable<String>(checksum);
    }
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || whenToRead != null) {
      map['when_to_read'] = Variable<String>(whenToRead);
    }
    map['is_pinned'] = Variable<bool>(isPinned);
    map['page_count'] = Variable<int>(pageCount);
    map['last_read_page'] = Variable<int>(lastReadPage);
    if (!nullToAbsent || lastOpenedAt != null) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    }
    map['imported_at'] = Variable<DateTime>(importedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['cleanup_needed'] = Variable<bool>(cleanupNeeded);
    return map;
  }

  GuideDocumentsCompanion toCompanion(bool nullToAbsent) {
    return GuideDocumentsCompanion(
      id: Value(id),
      originalFileName: Value(originalFileName),
      displayTitle: Value(displayTitle),
      storedRelativePath: Value(storedRelativePath),
      fileSizeBytes: Value(fileSizeBytes),
      checksum: checksum == null && nullToAbsent
          ? const Value.absent()
          : Value(checksum),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      whenToRead: whenToRead == null && nullToAbsent
          ? const Value.absent()
          : Value(whenToRead),
      isPinned: Value(isPinned),
      pageCount: Value(pageCount),
      lastReadPage: Value(lastReadPage),
      lastOpenedAt: lastOpenedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOpenedAt),
      importedAt: Value(importedAt),
      updatedAt: Value(updatedAt),
      cleanupNeeded: Value(cleanupNeeded),
    );
  }

  factory GuideDocumentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuideDocumentRow(
      id: serializer.fromJson<String>(json['id']),
      originalFileName: serializer.fromJson<String>(json['originalFileName']),
      displayTitle: serializer.fromJson<String>(json['displayTitle']),
      storedRelativePath: serializer.fromJson<String>(
        json['storedRelativePath'],
      ),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      checksum: serializer.fromJson<String?>(json['checksum']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      whenToRead: serializer.fromJson<String?>(json['whenToRead']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      pageCount: serializer.fromJson<int>(json['pageCount']),
      lastReadPage: serializer.fromJson<int>(json['lastReadPage']),
      lastOpenedAt: serializer.fromJson<DateTime?>(json['lastOpenedAt']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cleanupNeeded: serializer.fromJson<bool>(json['cleanupNeeded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'originalFileName': serializer.toJson<String>(originalFileName),
      'displayTitle': serializer.toJson<String>(displayTitle),
      'storedRelativePath': serializer.toJson<String>(storedRelativePath),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'checksum': serializer.toJson<String?>(checksum),
      'projectId': serializer.toJson<String?>(projectId),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
      'whenToRead': serializer.toJson<String?>(whenToRead),
      'isPinned': serializer.toJson<bool>(isPinned),
      'pageCount': serializer.toJson<int>(pageCount),
      'lastReadPage': serializer.toJson<int>(lastReadPage),
      'lastOpenedAt': serializer.toJson<DateTime?>(lastOpenedAt),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cleanupNeeded': serializer.toJson<bool>(cleanupNeeded),
    };
  }

  GuideDocumentRow copyWith({
    String? id,
    String? originalFileName,
    String? displayTitle,
    String? storedRelativePath,
    int? fileSizeBytes,
    Value<String?> checksum = const Value.absent(),
    Value<String?> projectId = const Value.absent(),
    String? category,
    Value<String?> description = const Value.absent(),
    Value<String?> whenToRead = const Value.absent(),
    bool? isPinned,
    int? pageCount,
    int? lastReadPage,
    Value<DateTime?> lastOpenedAt = const Value.absent(),
    DateTime? importedAt,
    DateTime? updatedAt,
    bool? cleanupNeeded,
  }) => GuideDocumentRow(
    id: id ?? this.id,
    originalFileName: originalFileName ?? this.originalFileName,
    displayTitle: displayTitle ?? this.displayTitle,
    storedRelativePath: storedRelativePath ?? this.storedRelativePath,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    checksum: checksum.present ? checksum.value : this.checksum,
    projectId: projectId.present ? projectId.value : this.projectId,
    category: category ?? this.category,
    description: description.present ? description.value : this.description,
    whenToRead: whenToRead.present ? whenToRead.value : this.whenToRead,
    isPinned: isPinned ?? this.isPinned,
    pageCount: pageCount ?? this.pageCount,
    lastReadPage: lastReadPage ?? this.lastReadPage,
    lastOpenedAt: lastOpenedAt.present ? lastOpenedAt.value : this.lastOpenedAt,
    importedAt: importedAt ?? this.importedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cleanupNeeded: cleanupNeeded ?? this.cleanupNeeded,
  );
  GuideDocumentRow copyWithCompanion(GuideDocumentsCompanion data) {
    return GuideDocumentRow(
      id: data.id.present ? data.id.value : this.id,
      originalFileName: data.originalFileName.present
          ? data.originalFileName.value
          : this.originalFileName,
      displayTitle: data.displayTitle.present
          ? data.displayTitle.value
          : this.displayTitle,
      storedRelativePath: data.storedRelativePath.present
          ? data.storedRelativePath.value
          : this.storedRelativePath,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      whenToRead: data.whenToRead.present
          ? data.whenToRead.value
          : this.whenToRead,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      lastReadPage: data.lastReadPage.present
          ? data.lastReadPage.value
          : this.lastReadPage,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cleanupNeeded: data.cleanupNeeded.present
          ? data.cleanupNeeded.value
          : this.cleanupNeeded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuideDocumentRow(')
          ..write('id: $id, ')
          ..write('originalFileName: $originalFileName, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('storedRelativePath: $storedRelativePath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('checksum: $checksum, ')
          ..write('projectId: $projectId, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('whenToRead: $whenToRead, ')
          ..write('isPinned: $isPinned, ')
          ..write('pageCount: $pageCount, ')
          ..write('lastReadPage: $lastReadPage, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('importedAt: $importedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cleanupNeeded: $cleanupNeeded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originalFileName,
    displayTitle,
    storedRelativePath,
    fileSizeBytes,
    checksum,
    projectId,
    category,
    description,
    whenToRead,
    isPinned,
    pageCount,
    lastReadPage,
    lastOpenedAt,
    importedAt,
    updatedAt,
    cleanupNeeded,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuideDocumentRow &&
          other.id == this.id &&
          other.originalFileName == this.originalFileName &&
          other.displayTitle == this.displayTitle &&
          other.storedRelativePath == this.storedRelativePath &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.checksum == this.checksum &&
          other.projectId == this.projectId &&
          other.category == this.category &&
          other.description == this.description &&
          other.whenToRead == this.whenToRead &&
          other.isPinned == this.isPinned &&
          other.pageCount == this.pageCount &&
          other.lastReadPage == this.lastReadPage &&
          other.lastOpenedAt == this.lastOpenedAt &&
          other.importedAt == this.importedAt &&
          other.updatedAt == this.updatedAt &&
          other.cleanupNeeded == this.cleanupNeeded);
}

class GuideDocumentsCompanion extends UpdateCompanion<GuideDocumentRow> {
  final Value<String> id;
  final Value<String> originalFileName;
  final Value<String> displayTitle;
  final Value<String> storedRelativePath;
  final Value<int> fileSizeBytes;
  final Value<String?> checksum;
  final Value<String?> projectId;
  final Value<String> category;
  final Value<String?> description;
  final Value<String?> whenToRead;
  final Value<bool> isPinned;
  final Value<int> pageCount;
  final Value<int> lastReadPage;
  final Value<DateTime?> lastOpenedAt;
  final Value<DateTime> importedAt;
  final Value<DateTime> updatedAt;
  final Value<bool> cleanupNeeded;
  final Value<int> rowid;
  const GuideDocumentsCompanion({
    this.id = const Value.absent(),
    this.originalFileName = const Value.absent(),
    this.displayTitle = const Value.absent(),
    this.storedRelativePath = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.checksum = const Value.absent(),
    this.projectId = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.whenToRead = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.lastReadPage = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cleanupNeeded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GuideDocumentsCompanion.insert({
    required String id,
    required String originalFileName,
    required String displayTitle,
    required String storedRelativePath,
    required int fileSizeBytes,
    this.checksum = const Value.absent(),
    this.projectId = const Value.absent(),
    required String category,
    this.description = const Value.absent(),
    this.whenToRead = const Value.absent(),
    this.isPinned = const Value.absent(),
    required int pageCount,
    this.lastReadPage = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    required DateTime importedAt,
    required DateTime updatedAt,
    this.cleanupNeeded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       originalFileName = Value(originalFileName),
       displayTitle = Value(displayTitle),
       storedRelativePath = Value(storedRelativePath),
       fileSizeBytes = Value(fileSizeBytes),
       category = Value(category),
       pageCount = Value(pageCount),
       importedAt = Value(importedAt),
       updatedAt = Value(updatedAt);
  static Insertable<GuideDocumentRow> custom({
    Expression<String>? id,
    Expression<String>? originalFileName,
    Expression<String>? displayTitle,
    Expression<String>? storedRelativePath,
    Expression<int>? fileSizeBytes,
    Expression<String>? checksum,
    Expression<String>? projectId,
    Expression<String>? category,
    Expression<String>? description,
    Expression<String>? whenToRead,
    Expression<bool>? isPinned,
    Expression<int>? pageCount,
    Expression<int>? lastReadPage,
    Expression<DateTime>? lastOpenedAt,
    Expression<DateTime>? importedAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? cleanupNeeded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalFileName != null) 'original_file_name': originalFileName,
      if (displayTitle != null) 'display_title': displayTitle,
      if (storedRelativePath != null)
        'stored_relative_path': storedRelativePath,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (checksum != null) 'checksum': checksum,
      if (projectId != null) 'project_id': projectId,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (whenToRead != null) 'when_to_read': whenToRead,
      if (isPinned != null) 'is_pinned': isPinned,
      if (pageCount != null) 'page_count': pageCount,
      if (lastReadPage != null) 'last_read_page': lastReadPage,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (importedAt != null) 'imported_at': importedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cleanupNeeded != null) 'cleanup_needed': cleanupNeeded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GuideDocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? originalFileName,
    Value<String>? displayTitle,
    Value<String>? storedRelativePath,
    Value<int>? fileSizeBytes,
    Value<String?>? checksum,
    Value<String?>? projectId,
    Value<String>? category,
    Value<String?>? description,
    Value<String?>? whenToRead,
    Value<bool>? isPinned,
    Value<int>? pageCount,
    Value<int>? lastReadPage,
    Value<DateTime?>? lastOpenedAt,
    Value<DateTime>? importedAt,
    Value<DateTime>? updatedAt,
    Value<bool>? cleanupNeeded,
    Value<int>? rowid,
  }) {
    return GuideDocumentsCompanion(
      id: id ?? this.id,
      originalFileName: originalFileName ?? this.originalFileName,
      displayTitle: displayTitle ?? this.displayTitle,
      storedRelativePath: storedRelativePath ?? this.storedRelativePath,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      checksum: checksum ?? this.checksum,
      projectId: projectId ?? this.projectId,
      category: category ?? this.category,
      description: description ?? this.description,
      whenToRead: whenToRead ?? this.whenToRead,
      isPinned: isPinned ?? this.isPinned,
      pageCount: pageCount ?? this.pageCount,
      lastReadPage: lastReadPage ?? this.lastReadPage,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      importedAt: importedAt ?? this.importedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cleanupNeeded: cleanupNeeded ?? this.cleanupNeeded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (originalFileName.present) {
      map['original_file_name'] = Variable<String>(originalFileName.value);
    }
    if (displayTitle.present) {
      map['display_title'] = Variable<String>(displayTitle.value);
    }
    if (storedRelativePath.present) {
      map['stored_relative_path'] = Variable<String>(storedRelativePath.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (whenToRead.present) {
      map['when_to_read'] = Variable<String>(whenToRead.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (lastReadPage.present) {
      map['last_read_page'] = Variable<int>(lastReadPage.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cleanupNeeded.present) {
      map['cleanup_needed'] = Variable<bool>(cleanupNeeded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuideDocumentsCompanion(')
          ..write('id: $id, ')
          ..write('originalFileName: $originalFileName, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('storedRelativePath: $storedRelativePath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('checksum: $checksum, ')
          ..write('projectId: $projectId, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('whenToRead: $whenToRead, ')
          ..write('isPinned: $isPinned, ')
          ..write('pageCount: $pageCount, ')
          ..write('lastReadPage: $lastReadPage, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('importedAt: $importedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cleanupNeeded: $cleanupNeeded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PdfBookmarksTable extends PdfBookmarks
    with TableInfo<$PdfBookmarksTable, PdfBookmarkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfBookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES guide_documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, documentId, pageNumber, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pdf_bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfBookmarkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {documentId, pageNumber},
  ];
  @override
  PdfBookmarkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfBookmarkRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PdfBookmarksTable createAlias(String alias) {
    return $PdfBookmarksTable(attachedDatabase, alias);
  }
}

class PdfBookmarkRow extends DataClass implements Insertable<PdfBookmarkRow> {
  final String id;
  final String documentId;
  final int pageNumber;
  final DateTime createdAt;
  const PdfBookmarkRow({
    required this.id,
    required this.documentId,
    required this.pageNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['page_number'] = Variable<int>(pageNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PdfBookmarksCompanion toCompanion(bool nullToAbsent) {
    return PdfBookmarksCompanion(
      id: Value(id),
      documentId: Value(documentId),
      pageNumber: Value(pageNumber),
      createdAt: Value(createdAt),
    );
  }

  factory PdfBookmarkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfBookmarkRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PdfBookmarkRow copyWith({
    String? id,
    String? documentId,
    int? pageNumber,
    DateTime? createdAt,
  }) => PdfBookmarkRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    pageNumber: pageNumber ?? this.pageNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  PdfBookmarkRow copyWithCompanion(PdfBookmarksCompanion data) {
    return PdfBookmarkRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfBookmarkRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, documentId, pageNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfBookmarkRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.pageNumber == this.pageNumber &&
          other.createdAt == this.createdAt);
}

class PdfBookmarksCompanion extends UpdateCompanion<PdfBookmarkRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> pageNumber;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PdfBookmarksCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PdfBookmarksCompanion.insert({
    required String id,
    required String documentId,
    required int pageNumber,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       pageNumber = Value(pageNumber),
       createdAt = Value(createdAt);
  static Insertable<PdfBookmarkRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? pageNumber,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PdfBookmarksCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? pageNumber,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PdfBookmarksCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      pageNumber: pageNumber ?? this.pageNumber,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfBookmarksCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PdfNotesTable extends PdfNotes
    with TableInfo<$PdfNotesTable, PdfNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES guide_documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    pageNumber,
    content,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pdf_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfNoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfNoteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PdfNotesTable createAlias(String alias) {
    return $PdfNotesTable(attachedDatabase, alias);
  }
}

class PdfNoteRow extends DataClass implements Insertable<PdfNoteRow> {
  final String id;
  final String documentId;
  final int pageNumber;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PdfNoteRow({
    required this.id,
    required this.documentId,
    required this.pageNumber,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['page_number'] = Variable<int>(pageNumber);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PdfNotesCompanion toCompanion(bool nullToAbsent) {
    return PdfNotesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      pageNumber: Value(pageNumber),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PdfNoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfNoteRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PdfNoteRow copyWith({
    String? id,
    String? documentId,
    int? pageNumber,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PdfNoteRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    pageNumber: pageNumber ?? this.pageNumber,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PdfNoteRow copyWithCompanion(PdfNotesCompanion data) {
    return PdfNoteRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfNoteRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, documentId, pageNumber, content, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfNoteRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.pageNumber == this.pageNumber &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PdfNotesCompanion extends UpdateCompanion<PdfNoteRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> pageNumber;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PdfNotesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PdfNotesCompanion.insert({
    required String id,
    required String documentId,
    required int pageNumber,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       pageNumber = Value(pageNumber),
       content = Value(content),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PdfNoteRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? pageNumber,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PdfNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? pageNumber,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PdfNotesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      pageNumber: pageNumber ?? this.pageNumber,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfNotesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetricEntriesTable extends MetricEntries
    with TableInfo<$MetricEntriesTable, MetricEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetricEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _entryDateMeta = const VerificationMeta(
    'entryDate',
  );
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
    'entry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outputsCountMeta = const VerificationMeta(
    'outputsCount',
  );
  @override
  late final GeneratedColumn<int> outputsCount = GeneratedColumn<int>(
    'outputs_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _viewsMeta = const VerificationMeta('views');
  @override
  late final GeneratedColumn<int> views = GeneratedColumn<int>(
    'views',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clicksMeta = const VerificationMeta('clicks');
  @override
  late final GeneratedColumn<int> clicks = GeneratedColumn<int>(
    'clicks',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ordersMeta = const VerificationMeta('orders');
  @override
  late final GeneratedColumn<int> orders = GeneratedColumn<int>(
    'orders',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revenueMinorMeta = const VerificationMeta(
    'revenueMinor',
  );
  @override
  late final GeneratedColumn<int> revenueMinor = GeneratedColumn<int>(
    'revenue_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workMinutesMeta = const VerificationMeta(
    'workMinutes',
  );
  @override
  late final GeneratedColumn<int> workMinutes = GeneratedColumn<int>(
    'work_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    entryDate,
    outputsCount,
    views,
    clicks,
    orders,
    revenueMinor,
    workMinutes,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metric_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetricEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('entry_date')) {
      context.handle(
        _entryDateMeta,
        entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_entryDateMeta);
    }
    if (data.containsKey('outputs_count')) {
      context.handle(
        _outputsCountMeta,
        outputsCount.isAcceptableOrUnknown(
          data['outputs_count']!,
          _outputsCountMeta,
        ),
      );
    }
    if (data.containsKey('views')) {
      context.handle(
        _viewsMeta,
        views.isAcceptableOrUnknown(data['views']!, _viewsMeta),
      );
    }
    if (data.containsKey('clicks')) {
      context.handle(
        _clicksMeta,
        clicks.isAcceptableOrUnknown(data['clicks']!, _clicksMeta),
      );
    }
    if (data.containsKey('orders')) {
      context.handle(
        _ordersMeta,
        orders.isAcceptableOrUnknown(data['orders']!, _ordersMeta),
      );
    }
    if (data.containsKey('revenue_minor')) {
      context.handle(
        _revenueMinorMeta,
        revenueMinor.isAcceptableOrUnknown(
          data['revenue_minor']!,
          _revenueMinorMeta,
        ),
      );
    }
    if (data.containsKey('work_minutes')) {
      context.handle(
        _workMinutesMeta,
        workMinutes.isAcceptableOrUnknown(
          data['work_minutes']!,
          _workMinutesMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {projectId, entryDate},
  ];
  @override
  MetricEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetricEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      entryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date'],
      )!,
      outputsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}outputs_count'],
      )!,
      views: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}views'],
      ),
      clicks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}clicks'],
      ),
      orders: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orders'],
      ),
      revenueMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revenue_minor'],
      ),
      workMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}work_minutes'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MetricEntriesTable createAlias(String alias) {
    return $MetricEntriesTable(attachedDatabase, alias);
  }
}

class MetricEntryRow extends DataClass implements Insertable<MetricEntryRow> {
  final String id;
  final String projectId;
  final DateTime entryDate;
  final int outputsCount;
  final int? views;
  final int? clicks;
  final int? orders;
  final int? revenueMinor;
  final int? workMinutes;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MetricEntryRow({
    required this.id,
    required this.projectId,
    required this.entryDate,
    required this.outputsCount,
    this.views,
    this.clicks,
    this.orders,
    this.revenueMinor,
    this.workMinutes,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['entry_date'] = Variable<DateTime>(entryDate);
    map['outputs_count'] = Variable<int>(outputsCount);
    if (!nullToAbsent || views != null) {
      map['views'] = Variable<int>(views);
    }
    if (!nullToAbsent || clicks != null) {
      map['clicks'] = Variable<int>(clicks);
    }
    if (!nullToAbsent || orders != null) {
      map['orders'] = Variable<int>(orders);
    }
    if (!nullToAbsent || revenueMinor != null) {
      map['revenue_minor'] = Variable<int>(revenueMinor);
    }
    if (!nullToAbsent || workMinutes != null) {
      map['work_minutes'] = Variable<int>(workMinutes);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MetricEntriesCompanion toCompanion(bool nullToAbsent) {
    return MetricEntriesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      entryDate: Value(entryDate),
      outputsCount: Value(outputsCount),
      views: views == null && nullToAbsent
          ? const Value.absent()
          : Value(views),
      clicks: clicks == null && nullToAbsent
          ? const Value.absent()
          : Value(clicks),
      orders: orders == null && nullToAbsent
          ? const Value.absent()
          : Value(orders),
      revenueMinor: revenueMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(revenueMinor),
      workMinutes: workMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(workMinutes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MetricEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetricEntryRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
      outputsCount: serializer.fromJson<int>(json['outputsCount']),
      views: serializer.fromJson<int?>(json['views']),
      clicks: serializer.fromJson<int?>(json['clicks']),
      orders: serializer.fromJson<int?>(json['orders']),
      revenueMinor: serializer.fromJson<int?>(json['revenueMinor']),
      workMinutes: serializer.fromJson<int?>(json['workMinutes']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'entryDate': serializer.toJson<DateTime>(entryDate),
      'outputsCount': serializer.toJson<int>(outputsCount),
      'views': serializer.toJson<int?>(views),
      'clicks': serializer.toJson<int?>(clicks),
      'orders': serializer.toJson<int?>(orders),
      'revenueMinor': serializer.toJson<int?>(revenueMinor),
      'workMinutes': serializer.toJson<int?>(workMinutes),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MetricEntryRow copyWith({
    String? id,
    String? projectId,
    DateTime? entryDate,
    int? outputsCount,
    Value<int?> views = const Value.absent(),
    Value<int?> clicks = const Value.absent(),
    Value<int?> orders = const Value.absent(),
    Value<int?> revenueMinor = const Value.absent(),
    Value<int?> workMinutes = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MetricEntryRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    entryDate: entryDate ?? this.entryDate,
    outputsCount: outputsCount ?? this.outputsCount,
    views: views.present ? views.value : this.views,
    clicks: clicks.present ? clicks.value : this.clicks,
    orders: orders.present ? orders.value : this.orders,
    revenueMinor: revenueMinor.present ? revenueMinor.value : this.revenueMinor,
    workMinutes: workMinutes.present ? workMinutes.value : this.workMinutes,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MetricEntryRow copyWithCompanion(MetricEntriesCompanion data) {
    return MetricEntryRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
      outputsCount: data.outputsCount.present
          ? data.outputsCount.value
          : this.outputsCount,
      views: data.views.present ? data.views.value : this.views,
      clicks: data.clicks.present ? data.clicks.value : this.clicks,
      orders: data.orders.present ? data.orders.value : this.orders,
      revenueMinor: data.revenueMinor.present
          ? data.revenueMinor.value
          : this.revenueMinor,
      workMinutes: data.workMinutes.present
          ? data.workMinutes.value
          : this.workMinutes,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetricEntryRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('entryDate: $entryDate, ')
          ..write('outputsCount: $outputsCount, ')
          ..write('views: $views, ')
          ..write('clicks: $clicks, ')
          ..write('orders: $orders, ')
          ..write('revenueMinor: $revenueMinor, ')
          ..write('workMinutes: $workMinutes, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    entryDate,
    outputsCount,
    views,
    clicks,
    orders,
    revenueMinor,
    workMinutes,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetricEntryRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.entryDate == this.entryDate &&
          other.outputsCount == this.outputsCount &&
          other.views == this.views &&
          other.clicks == this.clicks &&
          other.orders == this.orders &&
          other.revenueMinor == this.revenueMinor &&
          other.workMinutes == this.workMinutes &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MetricEntriesCompanion extends UpdateCompanion<MetricEntryRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<DateTime> entryDate;
  final Value<int> outputsCount;
  final Value<int?> views;
  final Value<int?> clicks;
  final Value<int?> orders;
  final Value<int?> revenueMinor;
  final Value<int?> workMinutes;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MetricEntriesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.entryDate = const Value.absent(),
    this.outputsCount = const Value.absent(),
    this.views = const Value.absent(),
    this.clicks = const Value.absent(),
    this.orders = const Value.absent(),
    this.revenueMinor = const Value.absent(),
    this.workMinutes = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetricEntriesCompanion.insert({
    required String id,
    required String projectId,
    required DateTime entryDate,
    this.outputsCount = const Value.absent(),
    this.views = const Value.absent(),
    this.clicks = const Value.absent(),
    this.orders = const Value.absent(),
    this.revenueMinor = const Value.absent(),
    this.workMinutes = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       entryDate = Value(entryDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MetricEntryRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<DateTime>? entryDate,
    Expression<int>? outputsCount,
    Expression<int>? views,
    Expression<int>? clicks,
    Expression<int>? orders,
    Expression<int>? revenueMinor,
    Expression<int>? workMinutes,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (entryDate != null) 'entry_date': entryDate,
      if (outputsCount != null) 'outputs_count': outputsCount,
      if (views != null) 'views': views,
      if (clicks != null) 'clicks': clicks,
      if (orders != null) 'orders': orders,
      if (revenueMinor != null) 'revenue_minor': revenueMinor,
      if (workMinutes != null) 'work_minutes': workMinutes,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetricEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<DateTime>? entryDate,
    Value<int>? outputsCount,
    Value<int?>? views,
    Value<int?>? clicks,
    Value<int?>? orders,
    Value<int?>? revenueMinor,
    Value<int?>? workMinutes,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MetricEntriesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      entryDate: entryDate ?? this.entryDate,
      outputsCount: outputsCount ?? this.outputsCount,
      views: views ?? this.views,
      clicks: clicks ?? this.clicks,
      orders: orders ?? this.orders,
      revenueMinor: revenueMinor ?? this.revenueMinor,
      workMinutes: workMinutes ?? this.workMinutes,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
    }
    if (outputsCount.present) {
      map['outputs_count'] = Variable<int>(outputsCount.value);
    }
    if (views.present) {
      map['views'] = Variable<int>(views.value);
    }
    if (clicks.present) {
      map['clicks'] = Variable<int>(clicks.value);
    }
    if (orders.present) {
      map['orders'] = Variable<int>(orders.value);
    }
    if (revenueMinor.present) {
      map['revenue_minor'] = Variable<int>(revenueMinor.value);
    }
    if (workMinutes.present) {
      map['work_minutes'] = Variable<int>(workMinutes.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetricEntriesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('entryDate: $entryDate, ')
          ..write('outputsCount: $outputsCount, ')
          ..write('views: $views, ')
          ..write('clicks: $clicks, ')
          ..write('orders: $orders, ')
          ..write('revenueMinor: $revenueMinor, ')
          ..write('workMinutes: $workMinutes, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTable extends WeeklyReviews
    with TableInfo<$WeeklyReviewsTable, WeeklyReviewRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sprintIdMeta = const VerificationMeta(
    'sprintId',
  );
  @override
  late final GeneratedColumn<String> sprintId = GeneratedColumn<String>(
    'sprint_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sprints (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekEndMeta = const VerificationMeta(
    'weekEnd',
  );
  @override
  late final GeneratedColumn<DateTime> weekEnd = GeneratedColumn<DateTime>(
    'week_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shippedSummaryMeta = const VerificationMeta(
    'shippedSummary',
  );
  @override
  late final GeneratedColumn<String> shippedSummary = GeneratedColumn<String>(
    'shipped_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importantResultMeta = const VerificationMeta(
    'importantResult',
  );
  @override
  late final GeneratedColumn<String> importantResult = GeneratedColumn<String>(
    'important_result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workedWellMeta = const VerificationMeta(
    'workedWell',
  );
  @override
  late final GeneratedColumn<String> workedWell = GeneratedColumn<String>(
    'worked_well',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wasteOrBlockerMeta = const VerificationMeta(
    'wasteOrBlocker',
  );
  @override
  late final GeneratedColumn<String> wasteOrBlocker = GeneratedColumn<String>(
    'waste_or_blocker',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextWeekFocusMeta = const VerificationMeta(
    'nextWeekFocus',
  );
  @override
  late final GeneratedColumn<String> nextWeekFocus = GeneratedColumn<String>(
    'next_week_focus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decisionAppliedAtMeta = const VerificationMeta(
    'decisionAppliedAt',
  );
  @override
  late final GeneratedColumn<DateTime> decisionAppliedAt =
      GeneratedColumn<DateTime>(
        'decision_applied_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    sprintId,
    weekStart,
    weekEnd,
    shippedSummary,
    importantResult,
    workedWell,
    wasteOrBlocker,
    decision,
    nextWeekFocus,
    decisionAppliedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyReviewRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('sprint_id')) {
      context.handle(
        _sprintIdMeta,
        sprintId.isAcceptableOrUnknown(data['sprint_id']!, _sprintIdMeta),
      );
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('week_end')) {
      context.handle(
        _weekEndMeta,
        weekEnd.isAcceptableOrUnknown(data['week_end']!, _weekEndMeta),
      );
    } else if (isInserting) {
      context.missing(_weekEndMeta);
    }
    if (data.containsKey('shipped_summary')) {
      context.handle(
        _shippedSummaryMeta,
        shippedSummary.isAcceptableOrUnknown(
          data['shipped_summary']!,
          _shippedSummaryMeta,
        ),
      );
    }
    if (data.containsKey('important_result')) {
      context.handle(
        _importantResultMeta,
        importantResult.isAcceptableOrUnknown(
          data['important_result']!,
          _importantResultMeta,
        ),
      );
    }
    if (data.containsKey('worked_well')) {
      context.handle(
        _workedWellMeta,
        workedWell.isAcceptableOrUnknown(data['worked_well']!, _workedWellMeta),
      );
    }
    if (data.containsKey('waste_or_blocker')) {
      context.handle(
        _wasteOrBlockerMeta,
        wasteOrBlocker.isAcceptableOrUnknown(
          data['waste_or_blocker']!,
          _wasteOrBlockerMeta,
        ),
      );
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionMeta);
    }
    if (data.containsKey('next_week_focus')) {
      context.handle(
        _nextWeekFocusMeta,
        nextWeekFocus.isAcceptableOrUnknown(
          data['next_week_focus']!,
          _nextWeekFocusMeta,
        ),
      );
    }
    if (data.containsKey('decision_applied_at')) {
      context.handle(
        _decisionAppliedAtMeta,
        decisionAppliedAt.isAcceptableOrUnknown(
          data['decision_applied_at']!,
          _decisionAppliedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {projectId, weekStart},
  ];
  @override
  WeeklyReviewRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReviewRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      sprintId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprint_id'],
      ),
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start'],
      )!,
      weekEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_end'],
      )!,
      shippedSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shipped_summary'],
      ),
      importantResult: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}important_result'],
      ),
      workedWell: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}worked_well'],
      ),
      wasteOrBlocker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}waste_or_blocker'],
      ),
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      )!,
      nextWeekFocus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_week_focus'],
      ),
      decisionAppliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}decision_applied_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WeeklyReviewsTable createAlias(String alias) {
    return $WeeklyReviewsTable(attachedDatabase, alias);
  }
}

class WeeklyReviewRow extends DataClass implements Insertable<WeeklyReviewRow> {
  final String id;
  final String projectId;
  final String? sprintId;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String? shippedSummary;
  final String? importantResult;
  final String? workedWell;
  final String? wasteOrBlocker;
  final String decision;
  final String? nextWeekFocus;
  final DateTime? decisionAppliedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WeeklyReviewRow({
    required this.id,
    required this.projectId,
    this.sprintId,
    required this.weekStart,
    required this.weekEnd,
    this.shippedSummary,
    this.importantResult,
    this.workedWell,
    this.wasteOrBlocker,
    required this.decision,
    this.nextWeekFocus,
    this.decisionAppliedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    if (!nullToAbsent || sprintId != null) {
      map['sprint_id'] = Variable<String>(sprintId);
    }
    map['week_start'] = Variable<DateTime>(weekStart);
    map['week_end'] = Variable<DateTime>(weekEnd);
    if (!nullToAbsent || shippedSummary != null) {
      map['shipped_summary'] = Variable<String>(shippedSummary);
    }
    if (!nullToAbsent || importantResult != null) {
      map['important_result'] = Variable<String>(importantResult);
    }
    if (!nullToAbsent || workedWell != null) {
      map['worked_well'] = Variable<String>(workedWell);
    }
    if (!nullToAbsent || wasteOrBlocker != null) {
      map['waste_or_blocker'] = Variable<String>(wasteOrBlocker);
    }
    map['decision'] = Variable<String>(decision);
    if (!nullToAbsent || nextWeekFocus != null) {
      map['next_week_focus'] = Variable<String>(nextWeekFocus);
    }
    if (!nullToAbsent || decisionAppliedAt != null) {
      map['decision_applied_at'] = Variable<DateTime>(decisionAppliedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      sprintId: sprintId == null && nullToAbsent
          ? const Value.absent()
          : Value(sprintId),
      weekStart: Value(weekStart),
      weekEnd: Value(weekEnd),
      shippedSummary: shippedSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(shippedSummary),
      importantResult: importantResult == null && nullToAbsent
          ? const Value.absent()
          : Value(importantResult),
      workedWell: workedWell == null && nullToAbsent
          ? const Value.absent()
          : Value(workedWell),
      wasteOrBlocker: wasteOrBlocker == null && nullToAbsent
          ? const Value.absent()
          : Value(wasteOrBlocker),
      decision: Value(decision),
      nextWeekFocus: nextWeekFocus == null && nullToAbsent
          ? const Value.absent()
          : Value(nextWeekFocus),
      decisionAppliedAt: decisionAppliedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(decisionAppliedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WeeklyReviewRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReviewRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      sprintId: serializer.fromJson<String?>(json['sprintId']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      weekEnd: serializer.fromJson<DateTime>(json['weekEnd']),
      shippedSummary: serializer.fromJson<String?>(json['shippedSummary']),
      importantResult: serializer.fromJson<String?>(json['importantResult']),
      workedWell: serializer.fromJson<String?>(json['workedWell']),
      wasteOrBlocker: serializer.fromJson<String?>(json['wasteOrBlocker']),
      decision: serializer.fromJson<String>(json['decision']),
      nextWeekFocus: serializer.fromJson<String?>(json['nextWeekFocus']),
      decisionAppliedAt: serializer.fromJson<DateTime?>(
        json['decisionAppliedAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'sprintId': serializer.toJson<String?>(sprintId),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'weekEnd': serializer.toJson<DateTime>(weekEnd),
      'shippedSummary': serializer.toJson<String?>(shippedSummary),
      'importantResult': serializer.toJson<String?>(importantResult),
      'workedWell': serializer.toJson<String?>(workedWell),
      'wasteOrBlocker': serializer.toJson<String?>(wasteOrBlocker),
      'decision': serializer.toJson<String>(decision),
      'nextWeekFocus': serializer.toJson<String?>(nextWeekFocus),
      'decisionAppliedAt': serializer.toJson<DateTime?>(decisionAppliedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WeeklyReviewRow copyWith({
    String? id,
    String? projectId,
    Value<String?> sprintId = const Value.absent(),
    DateTime? weekStart,
    DateTime? weekEnd,
    Value<String?> shippedSummary = const Value.absent(),
    Value<String?> importantResult = const Value.absent(),
    Value<String?> workedWell = const Value.absent(),
    Value<String?> wasteOrBlocker = const Value.absent(),
    String? decision,
    Value<String?> nextWeekFocus = const Value.absent(),
    Value<DateTime?> decisionAppliedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WeeklyReviewRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    sprintId: sprintId.present ? sprintId.value : this.sprintId,
    weekStart: weekStart ?? this.weekStart,
    weekEnd: weekEnd ?? this.weekEnd,
    shippedSummary: shippedSummary.present
        ? shippedSummary.value
        : this.shippedSummary,
    importantResult: importantResult.present
        ? importantResult.value
        : this.importantResult,
    workedWell: workedWell.present ? workedWell.value : this.workedWell,
    wasteOrBlocker: wasteOrBlocker.present
        ? wasteOrBlocker.value
        : this.wasteOrBlocker,
    decision: decision ?? this.decision,
    nextWeekFocus: nextWeekFocus.present
        ? nextWeekFocus.value
        : this.nextWeekFocus,
    decisionAppliedAt: decisionAppliedAt.present
        ? decisionAppliedAt.value
        : this.decisionAppliedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WeeklyReviewRow copyWithCompanion(WeeklyReviewsCompanion data) {
    return WeeklyReviewRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      sprintId: data.sprintId.present ? data.sprintId.value : this.sprintId,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      weekEnd: data.weekEnd.present ? data.weekEnd.value : this.weekEnd,
      shippedSummary: data.shippedSummary.present
          ? data.shippedSummary.value
          : this.shippedSummary,
      importantResult: data.importantResult.present
          ? data.importantResult.value
          : this.importantResult,
      workedWell: data.workedWell.present
          ? data.workedWell.value
          : this.workedWell,
      wasteOrBlocker: data.wasteOrBlocker.present
          ? data.wasteOrBlocker.value
          : this.wasteOrBlocker,
      decision: data.decision.present ? data.decision.value : this.decision,
      nextWeekFocus: data.nextWeekFocus.present
          ? data.nextWeekFocus.value
          : this.nextWeekFocus,
      decisionAppliedAt: data.decisionAppliedAt.present
          ? data.decisionAppliedAt.value
          : this.decisionAppliedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sprintId: $sprintId, ')
          ..write('weekStart: $weekStart, ')
          ..write('weekEnd: $weekEnd, ')
          ..write('shippedSummary: $shippedSummary, ')
          ..write('importantResult: $importantResult, ')
          ..write('workedWell: $workedWell, ')
          ..write('wasteOrBlocker: $wasteOrBlocker, ')
          ..write('decision: $decision, ')
          ..write('nextWeekFocus: $nextWeekFocus, ')
          ..write('decisionAppliedAt: $decisionAppliedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    sprintId,
    weekStart,
    weekEnd,
    shippedSummary,
    importantResult,
    workedWell,
    wasteOrBlocker,
    decision,
    nextWeekFocus,
    decisionAppliedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReviewRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.sprintId == this.sprintId &&
          other.weekStart == this.weekStart &&
          other.weekEnd == this.weekEnd &&
          other.shippedSummary == this.shippedSummary &&
          other.importantResult == this.importantResult &&
          other.workedWell == this.workedWell &&
          other.wasteOrBlocker == this.wasteOrBlocker &&
          other.decision == this.decision &&
          other.nextWeekFocus == this.nextWeekFocus &&
          other.decisionAppliedAt == this.decisionAppliedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WeeklyReviewsCompanion extends UpdateCompanion<WeeklyReviewRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String?> sprintId;
  final Value<DateTime> weekStart;
  final Value<DateTime> weekEnd;
  final Value<String?> shippedSummary;
  final Value<String?> importantResult;
  final Value<String?> workedWell;
  final Value<String?> wasteOrBlocker;
  final Value<String> decision;
  final Value<String?> nextWeekFocus;
  final Value<DateTime?> decisionAppliedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WeeklyReviewsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.sprintId = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.weekEnd = const Value.absent(),
    this.shippedSummary = const Value.absent(),
    this.importantResult = const Value.absent(),
    this.workedWell = const Value.absent(),
    this.wasteOrBlocker = const Value.absent(),
    this.decision = const Value.absent(),
    this.nextWeekFocus = const Value.absent(),
    this.decisionAppliedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsCompanion.insert({
    required String id,
    required String projectId,
    this.sprintId = const Value.absent(),
    required DateTime weekStart,
    required DateTime weekEnd,
    this.shippedSummary = const Value.absent(),
    this.importantResult = const Value.absent(),
    this.workedWell = const Value.absent(),
    this.wasteOrBlocker = const Value.absent(),
    required String decision,
    this.nextWeekFocus = const Value.absent(),
    this.decisionAppliedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       weekStart = Value(weekStart),
       weekEnd = Value(weekEnd),
       decision = Value(decision),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WeeklyReviewRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? sprintId,
    Expression<DateTime>? weekStart,
    Expression<DateTime>? weekEnd,
    Expression<String>? shippedSummary,
    Expression<String>? importantResult,
    Expression<String>? workedWell,
    Expression<String>? wasteOrBlocker,
    Expression<String>? decision,
    Expression<String>? nextWeekFocus,
    Expression<DateTime>? decisionAppliedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (sprintId != null) 'sprint_id': sprintId,
      if (weekStart != null) 'week_start': weekStart,
      if (weekEnd != null) 'week_end': weekEnd,
      if (shippedSummary != null) 'shipped_summary': shippedSummary,
      if (importantResult != null) 'important_result': importantResult,
      if (workedWell != null) 'worked_well': workedWell,
      if (wasteOrBlocker != null) 'waste_or_blocker': wasteOrBlocker,
      if (decision != null) 'decision': decision,
      if (nextWeekFocus != null) 'next_week_focus': nextWeekFocus,
      if (decisionAppliedAt != null) 'decision_applied_at': decisionAppliedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String?>? sprintId,
    Value<DateTime>? weekStart,
    Value<DateTime>? weekEnd,
    Value<String?>? shippedSummary,
    Value<String?>? importantResult,
    Value<String?>? workedWell,
    Value<String?>? wasteOrBlocker,
    Value<String>? decision,
    Value<String?>? nextWeekFocus,
    Value<DateTime?>? decisionAppliedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WeeklyReviewsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      sprintId: sprintId ?? this.sprintId,
      weekStart: weekStart ?? this.weekStart,
      weekEnd: weekEnd ?? this.weekEnd,
      shippedSummary: shippedSummary ?? this.shippedSummary,
      importantResult: importantResult ?? this.importantResult,
      workedWell: workedWell ?? this.workedWell,
      wasteOrBlocker: wasteOrBlocker ?? this.wasteOrBlocker,
      decision: decision ?? this.decision,
      nextWeekFocus: nextWeekFocus ?? this.nextWeekFocus,
      decisionAppliedAt: decisionAppliedAt ?? this.decisionAppliedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (sprintId.present) {
      map['sprint_id'] = Variable<String>(sprintId.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (weekEnd.present) {
      map['week_end'] = Variable<DateTime>(weekEnd.value);
    }
    if (shippedSummary.present) {
      map['shipped_summary'] = Variable<String>(shippedSummary.value);
    }
    if (importantResult.present) {
      map['important_result'] = Variable<String>(importantResult.value);
    }
    if (workedWell.present) {
      map['worked_well'] = Variable<String>(workedWell.value);
    }
    if (wasteOrBlocker.present) {
      map['waste_or_blocker'] = Variable<String>(wasteOrBlocker.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (nextWeekFocus.present) {
      map['next_week_focus'] = Variable<String>(nextWeekFocus.value);
    }
    if (decisionAppliedAt.present) {
      map['decision_applied_at'] = Variable<DateTime>(decisionAppliedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sprintId: $sprintId, ')
          ..write('weekStart: $weekStart, ')
          ..write('weekEnd: $weekEnd, ')
          ..write('shippedSummary: $shippedSummary, ')
          ..write('importantResult: $importantResult, ')
          ..write('workedWell: $workedWell, ')
          ..write('wasteOrBlocker: $wasteOrBlocker, ')
          ..write('decision: $decision, ')
          ..write('nextWeekFocus: $nextWeekFocus, ')
          ..write('decisionAppliedAt: $decisionAppliedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPreferencesTable extends NotificationPreferences
    with TableInfo<$NotificationPreferencesTable, NotificationPreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _morningEnabledMeta = const VerificationMeta(
    'morningEnabled',
  );
  @override
  late final GeneratedColumn<bool> morningEnabled = GeneratedColumn<bool>(
    'morning_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("morning_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _afterWorkEnabledMeta = const VerificationMeta(
    'afterWorkEnabled',
  );
  @override
  late final GeneratedColumn<bool> afterWorkEnabled = GeneratedColumn<bool>(
    'after_work_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("after_work_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _eveningEnabledMeta = const VerificationMeta(
    'eveningEnabled',
  );
  @override
  late final GeneratedColumn<bool> eveningEnabled = GeneratedColumn<bool>(
    'evening_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("evening_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _morningMinutesMeta = const VerificationMeta(
    'morningMinutes',
  );
  @override
  late final GeneratedColumn<int> morningMinutes = GeneratedColumn<int>(
    'morning_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(480),
  );
  static const VerificationMeta _afterWorkMinutesMeta = const VerificationMeta(
    'afterWorkMinutes',
  );
  @override
  late final GeneratedColumn<int> afterWorkMinutes = GeneratedColumn<int>(
    'after_work_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1020),
  );
  static const VerificationMeta _eveningMinutesMeta = const VerificationMeta(
    'eveningMinutes',
  );
  @override
  late final GeneratedColumn<int> eveningMinutes = GeneratedColumn<int>(
    'evening_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1260),
  );
  static const VerificationMeta _timeZoneIdMeta = const VerificationMeta(
    'timeZoneId',
  );
  @override
  late final GeneratedColumn<String> timeZoneId = GeneratedColumn<String>(
    'time_zone_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Asia/Jakarta'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    morningEnabled,
    afterWorkEnabled,
    eveningEnabled,
    morningMinutes,
    afterWorkMinutes,
    eveningMinutes,
    timeZoneId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationPreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('morning_enabled')) {
      context.handle(
        _morningEnabledMeta,
        morningEnabled.isAcceptableOrUnknown(
          data['morning_enabled']!,
          _morningEnabledMeta,
        ),
      );
    }
    if (data.containsKey('after_work_enabled')) {
      context.handle(
        _afterWorkEnabledMeta,
        afterWorkEnabled.isAcceptableOrUnknown(
          data['after_work_enabled']!,
          _afterWorkEnabledMeta,
        ),
      );
    }
    if (data.containsKey('evening_enabled')) {
      context.handle(
        _eveningEnabledMeta,
        eveningEnabled.isAcceptableOrUnknown(
          data['evening_enabled']!,
          _eveningEnabledMeta,
        ),
      );
    }
    if (data.containsKey('morning_minutes')) {
      context.handle(
        _morningMinutesMeta,
        morningMinutes.isAcceptableOrUnknown(
          data['morning_minutes']!,
          _morningMinutesMeta,
        ),
      );
    }
    if (data.containsKey('after_work_minutes')) {
      context.handle(
        _afterWorkMinutesMeta,
        afterWorkMinutes.isAcceptableOrUnknown(
          data['after_work_minutes']!,
          _afterWorkMinutesMeta,
        ),
      );
    }
    if (data.containsKey('evening_minutes')) {
      context.handle(
        _eveningMinutesMeta,
        eveningMinutes.isAcceptableOrUnknown(
          data['evening_minutes']!,
          _eveningMinutesMeta,
        ),
      );
    }
    if (data.containsKey('time_zone_id')) {
      context.handle(
        _timeZoneIdMeta,
        timeZoneId.isAcceptableOrUnknown(
          data['time_zone_id']!,
          _timeZoneIdMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationPreferenceRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPreferenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      morningEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}morning_enabled'],
      )!,
      afterWorkEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}after_work_enabled'],
      )!,
      eveningEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}evening_enabled'],
      )!,
      morningMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}morning_minutes'],
      )!,
      afterWorkMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}after_work_minutes'],
      )!,
      eveningMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evening_minutes'],
      )!,
      timeZoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationPreferencesTable createAlias(String alias) {
    return $NotificationPreferencesTable(attachedDatabase, alias);
  }
}

class NotificationPreferenceRow extends DataClass
    implements Insertable<NotificationPreferenceRow> {
  final int id;
  final bool morningEnabled;
  final bool afterWorkEnabled;
  final bool eveningEnabled;
  final int morningMinutes;
  final int afterWorkMinutes;
  final int eveningMinutes;
  final String timeZoneId;
  final DateTime updatedAt;
  const NotificationPreferenceRow({
    required this.id,
    required this.morningEnabled,
    required this.afterWorkEnabled,
    required this.eveningEnabled,
    required this.morningMinutes,
    required this.afterWorkMinutes,
    required this.eveningMinutes,
    required this.timeZoneId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['morning_enabled'] = Variable<bool>(morningEnabled);
    map['after_work_enabled'] = Variable<bool>(afterWorkEnabled);
    map['evening_enabled'] = Variable<bool>(eveningEnabled);
    map['morning_minutes'] = Variable<int>(morningMinutes);
    map['after_work_minutes'] = Variable<int>(afterWorkMinutes);
    map['evening_minutes'] = Variable<int>(eveningMinutes);
    map['time_zone_id'] = Variable<String>(timeZoneId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationPreferencesCompanion toCompanion(bool nullToAbsent) {
    return NotificationPreferencesCompanion(
      id: Value(id),
      morningEnabled: Value(morningEnabled),
      afterWorkEnabled: Value(afterWorkEnabled),
      eveningEnabled: Value(eveningEnabled),
      morningMinutes: Value(morningMinutes),
      afterWorkMinutes: Value(afterWorkMinutes),
      eveningMinutes: Value(eveningMinutes),
      timeZoneId: Value(timeZoneId),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationPreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPreferenceRow(
      id: serializer.fromJson<int>(json['id']),
      morningEnabled: serializer.fromJson<bool>(json['morningEnabled']),
      afterWorkEnabled: serializer.fromJson<bool>(json['afterWorkEnabled']),
      eveningEnabled: serializer.fromJson<bool>(json['eveningEnabled']),
      morningMinutes: serializer.fromJson<int>(json['morningMinutes']),
      afterWorkMinutes: serializer.fromJson<int>(json['afterWorkMinutes']),
      eveningMinutes: serializer.fromJson<int>(json['eveningMinutes']),
      timeZoneId: serializer.fromJson<String>(json['timeZoneId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'morningEnabled': serializer.toJson<bool>(morningEnabled),
      'afterWorkEnabled': serializer.toJson<bool>(afterWorkEnabled),
      'eveningEnabled': serializer.toJson<bool>(eveningEnabled),
      'morningMinutes': serializer.toJson<int>(morningMinutes),
      'afterWorkMinutes': serializer.toJson<int>(afterWorkMinutes),
      'eveningMinutes': serializer.toJson<int>(eveningMinutes),
      'timeZoneId': serializer.toJson<String>(timeZoneId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationPreferenceRow copyWith({
    int? id,
    bool? morningEnabled,
    bool? afterWorkEnabled,
    bool? eveningEnabled,
    int? morningMinutes,
    int? afterWorkMinutes,
    int? eveningMinutes,
    String? timeZoneId,
    DateTime? updatedAt,
  }) => NotificationPreferenceRow(
    id: id ?? this.id,
    morningEnabled: morningEnabled ?? this.morningEnabled,
    afterWorkEnabled: afterWorkEnabled ?? this.afterWorkEnabled,
    eveningEnabled: eveningEnabled ?? this.eveningEnabled,
    morningMinutes: morningMinutes ?? this.morningMinutes,
    afterWorkMinutes: afterWorkMinutes ?? this.afterWorkMinutes,
    eveningMinutes: eveningMinutes ?? this.eveningMinutes,
    timeZoneId: timeZoneId ?? this.timeZoneId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationPreferenceRow copyWithCompanion(
    NotificationPreferencesCompanion data,
  ) {
    return NotificationPreferenceRow(
      id: data.id.present ? data.id.value : this.id,
      morningEnabled: data.morningEnabled.present
          ? data.morningEnabled.value
          : this.morningEnabled,
      afterWorkEnabled: data.afterWorkEnabled.present
          ? data.afterWorkEnabled.value
          : this.afterWorkEnabled,
      eveningEnabled: data.eveningEnabled.present
          ? data.eveningEnabled.value
          : this.eveningEnabled,
      morningMinutes: data.morningMinutes.present
          ? data.morningMinutes.value
          : this.morningMinutes,
      afterWorkMinutes: data.afterWorkMinutes.present
          ? data.afterWorkMinutes.value
          : this.afterWorkMinutes,
      eveningMinutes: data.eveningMinutes.present
          ? data.eveningMinutes.value
          : this.eveningMinutes,
      timeZoneId: data.timeZoneId.present
          ? data.timeZoneId.value
          : this.timeZoneId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferenceRow(')
          ..write('id: $id, ')
          ..write('morningEnabled: $morningEnabled, ')
          ..write('afterWorkEnabled: $afterWorkEnabled, ')
          ..write('eveningEnabled: $eveningEnabled, ')
          ..write('morningMinutes: $morningMinutes, ')
          ..write('afterWorkMinutes: $afterWorkMinutes, ')
          ..write('eveningMinutes: $eveningMinutes, ')
          ..write('timeZoneId: $timeZoneId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    morningEnabled,
    afterWorkEnabled,
    eveningEnabled,
    morningMinutes,
    afterWorkMinutes,
    eveningMinutes,
    timeZoneId,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPreferenceRow &&
          other.id == this.id &&
          other.morningEnabled == this.morningEnabled &&
          other.afterWorkEnabled == this.afterWorkEnabled &&
          other.eveningEnabled == this.eveningEnabled &&
          other.morningMinutes == this.morningMinutes &&
          other.afterWorkMinutes == this.afterWorkMinutes &&
          other.eveningMinutes == this.eveningMinutes &&
          other.timeZoneId == this.timeZoneId &&
          other.updatedAt == this.updatedAt);
}

class NotificationPreferencesCompanion
    extends UpdateCompanion<NotificationPreferenceRow> {
  final Value<int> id;
  final Value<bool> morningEnabled;
  final Value<bool> afterWorkEnabled;
  final Value<bool> eveningEnabled;
  final Value<int> morningMinutes;
  final Value<int> afterWorkMinutes;
  final Value<int> eveningMinutes;
  final Value<String> timeZoneId;
  final Value<DateTime> updatedAt;
  const NotificationPreferencesCompanion({
    this.id = const Value.absent(),
    this.morningEnabled = const Value.absent(),
    this.afterWorkEnabled = const Value.absent(),
    this.eveningEnabled = const Value.absent(),
    this.morningMinutes = const Value.absent(),
    this.afterWorkMinutes = const Value.absent(),
    this.eveningMinutes = const Value.absent(),
    this.timeZoneId = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotificationPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.morningEnabled = const Value.absent(),
    this.afterWorkEnabled = const Value.absent(),
    this.eveningEnabled = const Value.absent(),
    this.morningMinutes = const Value.absent(),
    this.afterWorkMinutes = const Value.absent(),
    this.eveningMinutes = const Value.absent(),
    this.timeZoneId = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<NotificationPreferenceRow> custom({
    Expression<int>? id,
    Expression<bool>? morningEnabled,
    Expression<bool>? afterWorkEnabled,
    Expression<bool>? eveningEnabled,
    Expression<int>? morningMinutes,
    Expression<int>? afterWorkMinutes,
    Expression<int>? eveningMinutes,
    Expression<String>? timeZoneId,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (morningEnabled != null) 'morning_enabled': morningEnabled,
      if (afterWorkEnabled != null) 'after_work_enabled': afterWorkEnabled,
      if (eveningEnabled != null) 'evening_enabled': eveningEnabled,
      if (morningMinutes != null) 'morning_minutes': morningMinutes,
      if (afterWorkMinutes != null) 'after_work_minutes': afterWorkMinutes,
      if (eveningMinutes != null) 'evening_minutes': eveningMinutes,
      if (timeZoneId != null) 'time_zone_id': timeZoneId,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotificationPreferencesCompanion copyWith({
    Value<int>? id,
    Value<bool>? morningEnabled,
    Value<bool>? afterWorkEnabled,
    Value<bool>? eveningEnabled,
    Value<int>? morningMinutes,
    Value<int>? afterWorkMinutes,
    Value<int>? eveningMinutes,
    Value<String>? timeZoneId,
    Value<DateTime>? updatedAt,
  }) {
    return NotificationPreferencesCompanion(
      id: id ?? this.id,
      morningEnabled: morningEnabled ?? this.morningEnabled,
      afterWorkEnabled: afterWorkEnabled ?? this.afterWorkEnabled,
      eveningEnabled: eveningEnabled ?? this.eveningEnabled,
      morningMinutes: morningMinutes ?? this.morningMinutes,
      afterWorkMinutes: afterWorkMinutes ?? this.afterWorkMinutes,
      eveningMinutes: eveningMinutes ?? this.eveningMinutes,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (morningEnabled.present) {
      map['morning_enabled'] = Variable<bool>(morningEnabled.value);
    }
    if (afterWorkEnabled.present) {
      map['after_work_enabled'] = Variable<bool>(afterWorkEnabled.value);
    }
    if (eveningEnabled.present) {
      map['evening_enabled'] = Variable<bool>(eveningEnabled.value);
    }
    if (morningMinutes.present) {
      map['morning_minutes'] = Variable<int>(morningMinutes.value);
    }
    if (afterWorkMinutes.present) {
      map['after_work_minutes'] = Variable<int>(afterWorkMinutes.value);
    }
    if (eveningMinutes.present) {
      map['evening_minutes'] = Variable<int>(eveningMinutes.value);
    }
    if (timeZoneId.present) {
      map['time_zone_id'] = Variable<String>(timeZoneId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('morningEnabled: $morningEnabled, ')
          ..write('afterWorkEnabled: $afterWorkEnabled, ')
          ..write('eveningEnabled: $eveningEnabled, ')
          ..write('morningMinutes: $morningMinutes, ')
          ..write('afterWorkMinutes: $afterWorkMinutes, ')
          ..write('eveningMinutes: $eveningMinutes, ')
          ..write('timeZoneId: $timeZoneId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SprintClosuresTable extends SprintClosures
    with TableInfo<$SprintClosuresTable, SprintClosureRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SprintClosuresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sprintIdMeta = const VerificationMeta(
    'sprintId',
  );
  @override
  late final GeneratedColumn<String> sprintId = GeneratedColumn<String>(
    'sprint_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES sprints (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "decision IN ('continueFocus', 'pivot', 'park')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceSummaryMeta = const VerificationMeta(
    'evidenceSummary',
  );
  @override
  late final GeneratedColumn<String> evidenceSummary = GeneratedColumn<String>(
    'evidence_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextApproachMeta = const VerificationMeta(
    'nextApproach',
  );
  @override
  late final GeneratedColumn<String> nextApproach = GeneratedColumn<String>(
    'next_approach',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextSprintIdMeta = const VerificationMeta(
    'nextSprintId',
  );
  @override
  late final GeneratedColumn<String> nextSprintId = GeneratedColumn<String>(
    'next_sprint_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES sprints (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _replacementProjectIdMeta =
      const VerificationMeta('replacementProjectId');
  @override
  late final GeneratedColumn<String> replacementProjectId =
      GeneratedColumn<String>(
        'replacement_project_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES projects (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sprintId,
    decision,
    evidenceSummary,
    nextApproach,
    nextSprintId,
    replacementProjectId,
    closedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sprint_closures';
  @override
  VerificationContext validateIntegrity(
    Insertable<SprintClosureRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sprint_id')) {
      context.handle(
        _sprintIdMeta,
        sprintId.isAcceptableOrUnknown(data['sprint_id']!, _sprintIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sprintIdMeta);
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionMeta);
    }
    if (data.containsKey('evidence_summary')) {
      context.handle(
        _evidenceSummaryMeta,
        evidenceSummary.isAcceptableOrUnknown(
          data['evidence_summary']!,
          _evidenceSummaryMeta,
        ),
      );
    }
    if (data.containsKey('next_approach')) {
      context.handle(
        _nextApproachMeta,
        nextApproach.isAcceptableOrUnknown(
          data['next_approach']!,
          _nextApproachMeta,
        ),
      );
    }
    if (data.containsKey('next_sprint_id')) {
      context.handle(
        _nextSprintIdMeta,
        nextSprintId.isAcceptableOrUnknown(
          data['next_sprint_id']!,
          _nextSprintIdMeta,
        ),
      );
    }
    if (data.containsKey('replacement_project_id')) {
      context.handle(
        _replacementProjectIdMeta,
        replacementProjectId.isAcceptableOrUnknown(
          data['replacement_project_id']!,
          _replacementProjectIdMeta,
        ),
      );
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_closedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SprintClosureRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SprintClosureRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sprintId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprint_id'],
      )!,
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      )!,
      evidenceSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence_summary'],
      ),
      nextApproach: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_approach'],
      ),
      nextSprintId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_sprint_id'],
      ),
      replacementProjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}replacement_project_id'],
      ),
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SprintClosuresTable createAlias(String alias) {
    return $SprintClosuresTable(attachedDatabase, alias);
  }
}

class SprintClosureRow extends DataClass
    implements Insertable<SprintClosureRow> {
  final String id;
  final String sprintId;
  final String decision;
  final String? evidenceSummary;
  final String? nextApproach;
  final String? nextSprintId;
  final String? replacementProjectId;
  final DateTime closedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SprintClosureRow({
    required this.id,
    required this.sprintId,
    required this.decision,
    this.evidenceSummary,
    this.nextApproach,
    this.nextSprintId,
    this.replacementProjectId,
    required this.closedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sprint_id'] = Variable<String>(sprintId);
    map['decision'] = Variable<String>(decision);
    if (!nullToAbsent || evidenceSummary != null) {
      map['evidence_summary'] = Variable<String>(evidenceSummary);
    }
    if (!nullToAbsent || nextApproach != null) {
      map['next_approach'] = Variable<String>(nextApproach);
    }
    if (!nullToAbsent || nextSprintId != null) {
      map['next_sprint_id'] = Variable<String>(nextSprintId);
    }
    if (!nullToAbsent || replacementProjectId != null) {
      map['replacement_project_id'] = Variable<String>(replacementProjectId);
    }
    map['closed_at'] = Variable<DateTime>(closedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SprintClosuresCompanion toCompanion(bool nullToAbsent) {
    return SprintClosuresCompanion(
      id: Value(id),
      sprintId: Value(sprintId),
      decision: Value(decision),
      evidenceSummary: evidenceSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(evidenceSummary),
      nextApproach: nextApproach == null && nullToAbsent
          ? const Value.absent()
          : Value(nextApproach),
      nextSprintId: nextSprintId == null && nullToAbsent
          ? const Value.absent()
          : Value(nextSprintId),
      replacementProjectId: replacementProjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(replacementProjectId),
      closedAt: Value(closedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SprintClosureRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SprintClosureRow(
      id: serializer.fromJson<String>(json['id']),
      sprintId: serializer.fromJson<String>(json['sprintId']),
      decision: serializer.fromJson<String>(json['decision']),
      evidenceSummary: serializer.fromJson<String?>(json['evidenceSummary']),
      nextApproach: serializer.fromJson<String?>(json['nextApproach']),
      nextSprintId: serializer.fromJson<String?>(json['nextSprintId']),
      replacementProjectId: serializer.fromJson<String?>(
        json['replacementProjectId'],
      ),
      closedAt: serializer.fromJson<DateTime>(json['closedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sprintId': serializer.toJson<String>(sprintId),
      'decision': serializer.toJson<String>(decision),
      'evidenceSummary': serializer.toJson<String?>(evidenceSummary),
      'nextApproach': serializer.toJson<String?>(nextApproach),
      'nextSprintId': serializer.toJson<String?>(nextSprintId),
      'replacementProjectId': serializer.toJson<String?>(replacementProjectId),
      'closedAt': serializer.toJson<DateTime>(closedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SprintClosureRow copyWith({
    String? id,
    String? sprintId,
    String? decision,
    Value<String?> evidenceSummary = const Value.absent(),
    Value<String?> nextApproach = const Value.absent(),
    Value<String?> nextSprintId = const Value.absent(),
    Value<String?> replacementProjectId = const Value.absent(),
    DateTime? closedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SprintClosureRow(
    id: id ?? this.id,
    sprintId: sprintId ?? this.sprintId,
    decision: decision ?? this.decision,
    evidenceSummary: evidenceSummary.present
        ? evidenceSummary.value
        : this.evidenceSummary,
    nextApproach: nextApproach.present ? nextApproach.value : this.nextApproach,
    nextSprintId: nextSprintId.present ? nextSprintId.value : this.nextSprintId,
    replacementProjectId: replacementProjectId.present
        ? replacementProjectId.value
        : this.replacementProjectId,
    closedAt: closedAt ?? this.closedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SprintClosureRow copyWithCompanion(SprintClosuresCompanion data) {
    return SprintClosureRow(
      id: data.id.present ? data.id.value : this.id,
      sprintId: data.sprintId.present ? data.sprintId.value : this.sprintId,
      decision: data.decision.present ? data.decision.value : this.decision,
      evidenceSummary: data.evidenceSummary.present
          ? data.evidenceSummary.value
          : this.evidenceSummary,
      nextApproach: data.nextApproach.present
          ? data.nextApproach.value
          : this.nextApproach,
      nextSprintId: data.nextSprintId.present
          ? data.nextSprintId.value
          : this.nextSprintId,
      replacementProjectId: data.replacementProjectId.present
          ? data.replacementProjectId.value
          : this.replacementProjectId,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SprintClosureRow(')
          ..write('id: $id, ')
          ..write('sprintId: $sprintId, ')
          ..write('decision: $decision, ')
          ..write('evidenceSummary: $evidenceSummary, ')
          ..write('nextApproach: $nextApproach, ')
          ..write('nextSprintId: $nextSprintId, ')
          ..write('replacementProjectId: $replacementProjectId, ')
          ..write('closedAt: $closedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sprintId,
    decision,
    evidenceSummary,
    nextApproach,
    nextSprintId,
    replacementProjectId,
    closedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SprintClosureRow &&
          other.id == this.id &&
          other.sprintId == this.sprintId &&
          other.decision == this.decision &&
          other.evidenceSummary == this.evidenceSummary &&
          other.nextApproach == this.nextApproach &&
          other.nextSprintId == this.nextSprintId &&
          other.replacementProjectId == this.replacementProjectId &&
          other.closedAt == this.closedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SprintClosuresCompanion extends UpdateCompanion<SprintClosureRow> {
  final Value<String> id;
  final Value<String> sprintId;
  final Value<String> decision;
  final Value<String?> evidenceSummary;
  final Value<String?> nextApproach;
  final Value<String?> nextSprintId;
  final Value<String?> replacementProjectId;
  final Value<DateTime> closedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SprintClosuresCompanion({
    this.id = const Value.absent(),
    this.sprintId = const Value.absent(),
    this.decision = const Value.absent(),
    this.evidenceSummary = const Value.absent(),
    this.nextApproach = const Value.absent(),
    this.nextSprintId = const Value.absent(),
    this.replacementProjectId = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SprintClosuresCompanion.insert({
    required String id,
    required String sprintId,
    required String decision,
    this.evidenceSummary = const Value.absent(),
    this.nextApproach = const Value.absent(),
    this.nextSprintId = const Value.absent(),
    this.replacementProjectId = const Value.absent(),
    required DateTime closedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sprintId = Value(sprintId),
       decision = Value(decision),
       closedAt = Value(closedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SprintClosureRow> custom({
    Expression<String>? id,
    Expression<String>? sprintId,
    Expression<String>? decision,
    Expression<String>? evidenceSummary,
    Expression<String>? nextApproach,
    Expression<String>? nextSprintId,
    Expression<String>? replacementProjectId,
    Expression<DateTime>? closedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sprintId != null) 'sprint_id': sprintId,
      if (decision != null) 'decision': decision,
      if (evidenceSummary != null) 'evidence_summary': evidenceSummary,
      if (nextApproach != null) 'next_approach': nextApproach,
      if (nextSprintId != null) 'next_sprint_id': nextSprintId,
      if (replacementProjectId != null)
        'replacement_project_id': replacementProjectId,
      if (closedAt != null) 'closed_at': closedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SprintClosuresCompanion copyWith({
    Value<String>? id,
    Value<String>? sprintId,
    Value<String>? decision,
    Value<String?>? evidenceSummary,
    Value<String?>? nextApproach,
    Value<String?>? nextSprintId,
    Value<String?>? replacementProjectId,
    Value<DateTime>? closedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SprintClosuresCompanion(
      id: id ?? this.id,
      sprintId: sprintId ?? this.sprintId,
      decision: decision ?? this.decision,
      evidenceSummary: evidenceSummary ?? this.evidenceSummary,
      nextApproach: nextApproach ?? this.nextApproach,
      nextSprintId: nextSprintId ?? this.nextSprintId,
      replacementProjectId: replacementProjectId ?? this.replacementProjectId,
      closedAt: closedAt ?? this.closedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sprintId.present) {
      map['sprint_id'] = Variable<String>(sprintId.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (evidenceSummary.present) {
      map['evidence_summary'] = Variable<String>(evidenceSummary.value);
    }
    if (nextApproach.present) {
      map['next_approach'] = Variable<String>(nextApproach.value);
    }
    if (nextSprintId.present) {
      map['next_sprint_id'] = Variable<String>(nextSprintId.value);
    }
    if (replacementProjectId.present) {
      map['replacement_project_id'] = Variable<String>(
        replacementProjectId.value,
      );
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SprintClosuresCompanion(')
          ..write('id: $id, ')
          ..write('sprintId: $sprintId, ')
          ..write('decision: $decision, ')
          ..write('evidenceSummary: $evidenceSummary, ')
          ..write('nextApproach: $nextApproach, ')
          ..write('nextSprintId: $nextSprintId, ')
          ..write('replacementProjectId: $replacementProjectId, ')
          ..write('closedAt: $closedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $IdeasTable ideas = $IdeasTable(this);
  late final $RestartCapsulesTable restartCapsules = $RestartCapsulesTable(
    this,
  );
  late final $DailyCheckInsTable dailyCheckIns = $DailyCheckInsTable(this);
  late final $SprintsTable sprints = $SprintsTable(this);
  late final $DailyPlansTable dailyPlans = $DailyPlansTable(this);
  late final $DailyActionsTable dailyActions = $DailyActionsTable(this);
  late final $ShipRecordsTable shipRecords = $ShipRecordsTable(this);
  late final $GuideDocumentsTable guideDocuments = $GuideDocumentsTable(this);
  late final $PdfBookmarksTable pdfBookmarks = $PdfBookmarksTable(this);
  late final $PdfNotesTable pdfNotes = $PdfNotesTable(this);
  late final $MetricEntriesTable metricEntries = $MetricEntriesTable(this);
  late final $WeeklyReviewsTable weeklyReviews = $WeeklyReviewsTable(this);
  late final $NotificationPreferencesTable notificationPreferences =
      $NotificationPreferencesTable(this);
  late final $SprintClosuresTable sprintClosures = $SprintClosuresTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    ideas,
    restartCapsules,
    dailyCheckIns,
    sprints,
    dailyPlans,
    dailyActions,
    shipRecords,
    guideDocuments,
    pdfBookmarks,
    pdfNotes,
    metricEntries,
    weeklyReviews,
    notificationPreferences,
    sprintClosures,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ideas', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('restart_capsules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sprints', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sprints',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('daily_plans', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('daily_actions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ship_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('guide_documents', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'guide_documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pdf_bookmarks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'guide_documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pdf_notes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('metric_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weekly_reviews', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sprints',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weekly_reviews', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sprints',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sprint_closures', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sprints',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sprint_closures', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sprint_closures', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required String id,
      required String name,
      required String shortGoal,
      Value<String?> whyChosen,
      Value<String?> successDefinition,
      Value<int?> targetRevenueMinor,
      required String status,
      Value<String?> iconKey,
      Value<String?> accentKey,
      Value<String?> primaryGuideDocumentId,
      Value<DateTime?> startDate,
      Value<DateTime?> reviewDate,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> shortGoal,
      Value<String?> whyChosen,
      Value<String?> successDefinition,
      Value<int?> targetRevenueMinor,
      Value<String> status,
      Value<String?> iconKey,
      Value<String?> accentKey,
      Value<String?> primaryGuideDocumentId,
      Value<DateTime?> startDate,
      Value<DateTime?> reviewDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, ProjectRow> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IdeasTable, List<IdeaRow>> _ideasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ideas,
    aliasName: 'projects__id__ideas__converted_project_id',
  );

  $$IdeasTableProcessedTableManager get ideasRefs {
    final manager = $$IdeasTableTableManager($_db, $_db.ideas).filter(
      (f) => f.convertedProjectId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_ideasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RestartCapsulesTable, List<RestartCapsuleRow>>
  _restartCapsulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.restartCapsules,
    aliasName: 'projects__id__restart_capsules__project_id',
  );

  $$RestartCapsulesTableProcessedTableManager get restartCapsulesRefs {
    final manager = $$RestartCapsulesTableTableManager(
      $_db,
      $_db.restartCapsules,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _restartCapsulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SprintsTable, List<SprintRow>> _sprintsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sprints,
    aliasName: 'projects__id__sprints__project_id',
  );

  $$SprintsTableProcessedTableManager get sprintsRefs {
    final manager = $$SprintsTableTableManager(
      $_db,
      $_db.sprints,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sprintsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GuideDocumentsTable, List<GuideDocumentRow>>
  _guideDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.guideDocuments,
    aliasName: 'projects__id__guide_documents__project_id',
  );

  $$GuideDocumentsTableProcessedTableManager get guideDocumentsRefs {
    final manager = $$GuideDocumentsTableTableManager(
      $_db,
      $_db.guideDocuments,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_guideDocumentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MetricEntriesTable, List<MetricEntryRow>>
  _metricEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.metricEntries,
    aliasName: 'projects__id__metric_entries__project_id',
  );

  $$MetricEntriesTableProcessedTableManager get metricEntriesRefs {
    final manager = $$MetricEntriesTableTableManager(
      $_db,
      $_db.metricEntries,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_metricEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeeklyReviewsTable, List<WeeklyReviewRow>>
  _weeklyReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weeklyReviews,
    aliasName: 'projects__id__weekly_reviews__project_id',
  );

  $$WeeklyReviewsTableProcessedTableManager get weeklyReviewsRefs {
    final manager = $$WeeklyReviewsTableTableManager(
      $_db,
      $_db.weeklyReviews,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weeklyReviewsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SprintClosuresTable, List<SprintClosureRow>>
  _sprintClosuresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sprintClosures,
    aliasName: 'projects__id__sprint_closures__replacement_project_id',
  );

  $$SprintClosuresTableProcessedTableManager get sprintClosuresRefs {
    final manager = $$SprintClosuresTableTableManager($_db, $_db.sprintClosures)
        .filter(
          (f) =>
              f.replacementProjectId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_sprintClosuresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortGoal => $composableBuilder(
    column: $table.shortGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whyChosen => $composableBuilder(
    column: $table.whyChosen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get successDefinition => $composableBuilder(
    column: $table.successDefinition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetRevenueMinor => $composableBuilder(
    column: $table.targetRevenueMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentKey => $composableBuilder(
    column: $table.accentKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryGuideDocumentId => $composableBuilder(
    column: $table.primaryGuideDocumentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ideasRefs(
    Expression<bool> Function($$IdeasTableFilterComposer f) f,
  ) {
    final $$IdeasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ideas,
      getReferencedColumn: (t) => t.convertedProjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IdeasTableFilterComposer(
            $db: $db,
            $table: $db.ideas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> restartCapsulesRefs(
    Expression<bool> Function($$RestartCapsulesTableFilterComposer f) f,
  ) {
    final $$RestartCapsulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.restartCapsules,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RestartCapsulesTableFilterComposer(
            $db: $db,
            $table: $db.restartCapsules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sprintsRefs(
    Expression<bool> Function($$SprintsTableFilterComposer f) f,
  ) {
    final $$SprintsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableFilterComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> guideDocumentsRefs(
    Expression<bool> Function($$GuideDocumentsTableFilterComposer f) f,
  ) {
    final $$GuideDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> metricEntriesRefs(
    Expression<bool> Function($$MetricEntriesTableFilterComposer f) f,
  ) {
    final $$MetricEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metricEntries,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetricEntriesTableFilterComposer(
            $db: $db,
            $table: $db.metricEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weeklyReviewsRefs(
    Expression<bool> Function($$WeeklyReviewsTableFilterComposer f) f,
  ) {
    final $$WeeklyReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklyReviews,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyReviewsTableFilterComposer(
            $db: $db,
            $table: $db.weeklyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sprintClosuresRefs(
    Expression<bool> Function($$SprintClosuresTableFilterComposer f) f,
  ) {
    final $$SprintClosuresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprintClosures,
      getReferencedColumn: (t) => t.replacementProjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintClosuresTableFilterComposer(
            $db: $db,
            $table: $db.sprintClosures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortGoal => $composableBuilder(
    column: $table.shortGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whyChosen => $composableBuilder(
    column: $table.whyChosen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get successDefinition => $composableBuilder(
    column: $table.successDefinition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetRevenueMinor => $composableBuilder(
    column: $table.targetRevenueMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentKey => $composableBuilder(
    column: $table.accentKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryGuideDocumentId => $composableBuilder(
    column: $table.primaryGuideDocumentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shortGoal =>
      $composableBuilder(column: $table.shortGoal, builder: (column) => column);

  GeneratedColumn<String> get whyChosen =>
      $composableBuilder(column: $table.whyChosen, builder: (column) => column);

  GeneratedColumn<String> get successDefinition => $composableBuilder(
    column: $table.successDefinition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetRevenueMinor => $composableBuilder(
    column: $table.targetRevenueMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get accentKey =>
      $composableBuilder(column: $table.accentKey, builder: (column) => column);

  GeneratedColumn<String> get primaryGuideDocumentId => $composableBuilder(
    column: $table.primaryGuideDocumentId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  Expression<T> ideasRefs<T extends Object>(
    Expression<T> Function($$IdeasTableAnnotationComposer a) f,
  ) {
    final $$IdeasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ideas,
      getReferencedColumn: (t) => t.convertedProjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IdeasTableAnnotationComposer(
            $db: $db,
            $table: $db.ideas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> restartCapsulesRefs<T extends Object>(
    Expression<T> Function($$RestartCapsulesTableAnnotationComposer a) f,
  ) {
    final $$RestartCapsulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.restartCapsules,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RestartCapsulesTableAnnotationComposer(
            $db: $db,
            $table: $db.restartCapsules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sprintsRefs<T extends Object>(
    Expression<T> Function($$SprintsTableAnnotationComposer a) f,
  ) {
    final $$SprintsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableAnnotationComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> guideDocumentsRefs<T extends Object>(
    Expression<T> Function($$GuideDocumentsTableAnnotationComposer a) f,
  ) {
    final $$GuideDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> metricEntriesRefs<T extends Object>(
    Expression<T> Function($$MetricEntriesTableAnnotationComposer a) f,
  ) {
    final $$MetricEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metricEntries,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetricEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.metricEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weeklyReviewsRefs<T extends Object>(
    Expression<T> Function($$WeeklyReviewsTableAnnotationComposer a) f,
  ) {
    final $$WeeklyReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklyReviews,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sprintClosuresRefs<T extends Object>(
    Expression<T> Function($$SprintClosuresTableAnnotationComposer a) f,
  ) {
    final $$SprintClosuresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprintClosures,
      getReferencedColumn: (t) => t.replacementProjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintClosuresTableAnnotationComposer(
            $db: $db,
            $table: $db.sprintClosures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          ProjectRow,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (ProjectRow, $$ProjectsTableReferences),
          ProjectRow,
          PrefetchHooks Function({
            bool ideasRefs,
            bool restartCapsulesRefs,
            bool sprintsRefs,
            bool guideDocumentsRefs,
            bool metricEntriesRefs,
            bool weeklyReviewsRefs,
            bool sprintClosuresRefs,
          })
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> shortGoal = const Value.absent(),
                Value<String?> whyChosen = const Value.absent(),
                Value<String?> successDefinition = const Value.absent(),
                Value<int?> targetRevenueMinor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<String?> accentKey = const Value.absent(),
                Value<String?> primaryGuideDocumentId = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> reviewDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                shortGoal: shortGoal,
                whyChosen: whyChosen,
                successDefinition: successDefinition,
                targetRevenueMinor: targetRevenueMinor,
                status: status,
                iconKey: iconKey,
                accentKey: accentKey,
                primaryGuideDocumentId: primaryGuideDocumentId,
                startDate: startDate,
                reviewDate: reviewDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String shortGoal,
                Value<String?> whyChosen = const Value.absent(),
                Value<String?> successDefinition = const Value.absent(),
                Value<int?> targetRevenueMinor = const Value.absent(),
                required String status,
                Value<String?> iconKey = const Value.absent(),
                Value<String?> accentKey = const Value.absent(),
                Value<String?> primaryGuideDocumentId = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> reviewDate = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                shortGoal: shortGoal,
                whyChosen: whyChosen,
                successDefinition: successDefinition,
                targetRevenueMinor: targetRevenueMinor,
                status: status,
                iconKey: iconKey,
                accentKey: accentKey,
                primaryGuideDocumentId: primaryGuideDocumentId,
                startDate: startDate,
                reviewDate: reviewDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ideasRefs = false,
                restartCapsulesRefs = false,
                sprintsRefs = false,
                guideDocumentsRefs = false,
                metricEntriesRefs = false,
                weeklyReviewsRefs = false,
                sprintClosuresRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ideasRefs) db.ideas,
                    if (restartCapsulesRefs) db.restartCapsules,
                    if (sprintsRefs) db.sprints,
                    if (guideDocumentsRefs) db.guideDocuments,
                    if (metricEntriesRefs) db.metricEntries,
                    if (weeklyReviewsRefs) db.weeklyReviews,
                    if (sprintClosuresRefs) db.sprintClosures,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ideasRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          IdeaRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._ideasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).ideasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.convertedProjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (restartCapsulesRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          RestartCapsuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._restartCapsulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).restartCapsulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sprintsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          SprintRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._sprintsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).sprintsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (guideDocumentsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          GuideDocumentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._guideDocumentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).guideDocumentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (metricEntriesRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          MetricEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._metricEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).metricEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weeklyReviewsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          WeeklyReviewRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._weeklyReviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).weeklyReviewsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sprintClosuresRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          SprintClosureRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._sprintClosuresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).sprintClosuresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.replacementProjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      ProjectRow,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (ProjectRow, $$ProjectsTableReferences),
      ProjectRow,
      PrefetchHooks Function({
        bool ideasRefs,
        bool restartCapsulesRefs,
        bool sprintsRefs,
        bool guideDocumentsRefs,
        bool metricEntriesRefs,
        bool weeklyReviewsRefs,
        bool sprintClosuresRefs,
      })
    >;
typedef $$IdeasTableCreateCompanionBuilder =
    IdeasCompanion Function({
      required String id,
      required String title,
      Value<String?> note,
      Value<String?> source,
      required String disposition,
      Value<String?> convertedProjectId,
      required DateTime capturedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$IdeasTableUpdateCompanionBuilder =
    IdeasCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> note,
      Value<String?> source,
      Value<String> disposition,
      Value<String?> convertedProjectId,
      Value<DateTime> capturedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$IdeasTableReferences
    extends BaseReferences<_$AppDatabase, $IdeasTable, IdeaRow> {
  $$IdeasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _convertedProjectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('ideas__converted_project_id__projects__id');

  $$ProjectsTableProcessedTableManager? get convertedProjectId {
    final $_column = $_itemColumn<String>('converted_project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_convertedProjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IdeasTableFilterComposer extends Composer<_$AppDatabase, $IdeasTable> {
  $$IdeasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get disposition => $composableBuilder(
    column: $table.disposition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get convertedProjectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.convertedProjectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IdeasTableOrderingComposer
    extends Composer<_$AppDatabase, $IdeasTable> {
  $$IdeasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get disposition => $composableBuilder(
    column: $table.disposition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get convertedProjectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.convertedProjectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IdeasTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdeasTable> {
  $$IdeasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get disposition => $composableBuilder(
    column: $table.disposition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get convertedProjectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.convertedProjectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IdeasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IdeasTable,
          IdeaRow,
          $$IdeasTableFilterComposer,
          $$IdeasTableOrderingComposer,
          $$IdeasTableAnnotationComposer,
          $$IdeasTableCreateCompanionBuilder,
          $$IdeasTableUpdateCompanionBuilder,
          (IdeaRow, $$IdeasTableReferences),
          IdeaRow,
          PrefetchHooks Function({bool convertedProjectId})
        > {
  $$IdeasTableTableManager(_$AppDatabase db, $IdeasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdeasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdeasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdeasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String> disposition = const Value.absent(),
                Value<String?> convertedProjectId = const Value.absent(),
                Value<DateTime> capturedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IdeasCompanion(
                id: id,
                title: title,
                note: note,
                source: source,
                disposition: disposition,
                convertedProjectId: convertedProjectId,
                capturedAt: capturedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> note = const Value.absent(),
                Value<String?> source = const Value.absent(),
                required String disposition,
                Value<String?> convertedProjectId = const Value.absent(),
                required DateTime capturedAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => IdeasCompanion.insert(
                id: id,
                title: title,
                note: note,
                source: source,
                disposition: disposition,
                convertedProjectId: convertedProjectId,
                capturedAt: capturedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$IdeasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({convertedProjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (convertedProjectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.convertedProjectId,
                                referencedTable: $$IdeasTableReferences
                                    ._convertedProjectIdTable(db),
                                referencedColumn: $$IdeasTableReferences
                                    ._convertedProjectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IdeasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IdeasTable,
      IdeaRow,
      $$IdeasTableFilterComposer,
      $$IdeasTableOrderingComposer,
      $$IdeasTableAnnotationComposer,
      $$IdeasTableCreateCompanionBuilder,
      $$IdeasTableUpdateCompanionBuilder,
      (IdeaRow, $$IdeasTableReferences),
      IdeaRow,
      PrefetchHooks Function({bool convertedProjectId})
    >;
typedef $$RestartCapsulesTableCreateCompanionBuilder =
    RestartCapsulesCompanion Function({
      required String id,
      required String projectId,
      Value<String?> lastKnownState,
      Value<String?> lastOutput,
      Value<String?> whatWorked,
      Value<String?> blocker,
      Value<String?> nextAction,
      Value<String?> parkedReason,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RestartCapsulesTableUpdateCompanionBuilder =
    RestartCapsulesCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String?> lastKnownState,
      Value<String?> lastOutput,
      Value<String?> whatWorked,
      Value<String?> blocker,
      Value<String?> nextAction,
      Value<String?> parkedReason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RestartCapsulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RestartCapsulesTable,
          RestartCapsuleRow
        > {
  $$RestartCapsulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('restart_capsules__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RestartCapsulesTableFilterComposer
    extends Composer<_$AppDatabase, $RestartCapsulesTable> {
  $$RestartCapsulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastKnownState => $composableBuilder(
    column: $table.lastKnownState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastOutput => $composableBuilder(
    column: $table.lastOutput,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatWorked => $composableBuilder(
    column: $table.whatWorked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blocker => $composableBuilder(
    column: $table.blocker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextAction => $composableBuilder(
    column: $table.nextAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parkedReason => $composableBuilder(
    column: $table.parkedReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RestartCapsulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RestartCapsulesTable> {
  $$RestartCapsulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastKnownState => $composableBuilder(
    column: $table.lastKnownState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastOutput => $composableBuilder(
    column: $table.lastOutput,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatWorked => $composableBuilder(
    column: $table.whatWorked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blocker => $composableBuilder(
    column: $table.blocker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextAction => $composableBuilder(
    column: $table.nextAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parkedReason => $composableBuilder(
    column: $table.parkedReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RestartCapsulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestartCapsulesTable> {
  $$RestartCapsulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lastKnownState => $composableBuilder(
    column: $table.lastKnownState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastOutput => $composableBuilder(
    column: $table.lastOutput,
    builder: (column) => column,
  );

  GeneratedColumn<String> get whatWorked => $composableBuilder(
    column: $table.whatWorked,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blocker =>
      $composableBuilder(column: $table.blocker, builder: (column) => column);

  GeneratedColumn<String> get nextAction => $composableBuilder(
    column: $table.nextAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parkedReason => $composableBuilder(
    column: $table.parkedReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RestartCapsulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RestartCapsulesTable,
          RestartCapsuleRow,
          $$RestartCapsulesTableFilterComposer,
          $$RestartCapsulesTableOrderingComposer,
          $$RestartCapsulesTableAnnotationComposer,
          $$RestartCapsulesTableCreateCompanionBuilder,
          $$RestartCapsulesTableUpdateCompanionBuilder,
          (RestartCapsuleRow, $$RestartCapsulesTableReferences),
          RestartCapsuleRow,
          PrefetchHooks Function({bool projectId})
        > {
  $$RestartCapsulesTableTableManager(
    _$AppDatabase db,
    $RestartCapsulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestartCapsulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestartCapsulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestartCapsulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String?> lastKnownState = const Value.absent(),
                Value<String?> lastOutput = const Value.absent(),
                Value<String?> whatWorked = const Value.absent(),
                Value<String?> blocker = const Value.absent(),
                Value<String?> nextAction = const Value.absent(),
                Value<String?> parkedReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RestartCapsulesCompanion(
                id: id,
                projectId: projectId,
                lastKnownState: lastKnownState,
                lastOutput: lastOutput,
                whatWorked: whatWorked,
                blocker: blocker,
                nextAction: nextAction,
                parkedReason: parkedReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                Value<String?> lastKnownState = const Value.absent(),
                Value<String?> lastOutput = const Value.absent(),
                Value<String?> whatWorked = const Value.absent(),
                Value<String?> blocker = const Value.absent(),
                Value<String?> nextAction = const Value.absent(),
                Value<String?> parkedReason = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RestartCapsulesCompanion.insert(
                id: id,
                projectId: projectId,
                lastKnownState: lastKnownState,
                lastOutput: lastOutput,
                whatWorked: whatWorked,
                blocker: blocker,
                nextAction: nextAction,
                parkedReason: parkedReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RestartCapsulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable:
                                    $$RestartCapsulesTableReferences
                                        ._projectIdTable(db),
                                referencedColumn:
                                    $$RestartCapsulesTableReferences
                                        ._projectIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RestartCapsulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RestartCapsulesTable,
      RestartCapsuleRow,
      $$RestartCapsulesTableFilterComposer,
      $$RestartCapsulesTableOrderingComposer,
      $$RestartCapsulesTableAnnotationComposer,
      $$RestartCapsulesTableCreateCompanionBuilder,
      $$RestartCapsulesTableUpdateCompanionBuilder,
      (RestartCapsuleRow, $$RestartCapsulesTableReferences),
      RestartCapsuleRow,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$DailyCheckInsTableCreateCompanionBuilder =
    DailyCheckInsCompanion Function({
      required String id,
      required DateTime checkInDate,
      required String energyLevel,
      required int availableMinutes,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DailyCheckInsTableUpdateCompanionBuilder =
    DailyCheckInsCompanion Function({
      Value<String> id,
      Value<DateTime> checkInDate,
      Value<String> energyLevel,
      Value<int> availableMinutes,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DailyCheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkInDate => $composableBuilder(
    column: $table.checkInDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableMinutes => $composableBuilder(
    column: $table.availableMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkInDate => $composableBuilder(
    column: $table.checkInDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableMinutes => $composableBuilder(
    column: $table.availableMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get checkInDate => $composableBuilder(
    column: $table.checkInDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get availableMinutes => $composableBuilder(
    column: $table.availableMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyCheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCheckInsTable,
          DailyCheckInRow,
          $$DailyCheckInsTableFilterComposer,
          $$DailyCheckInsTableOrderingComposer,
          $$DailyCheckInsTableAnnotationComposer,
          $$DailyCheckInsTableCreateCompanionBuilder,
          $$DailyCheckInsTableUpdateCompanionBuilder,
          (
            DailyCheckInRow,
            BaseReferences<_$AppDatabase, $DailyCheckInsTable, DailyCheckInRow>,
          ),
          DailyCheckInRow,
          PrefetchHooks Function()
        > {
  $$DailyCheckInsTableTableManager(_$AppDatabase db, $DailyCheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> checkInDate = const Value.absent(),
                Value<String> energyLevel = const Value.absent(),
                Value<int> availableMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsCompanion(
                id: id,
                checkInDate: checkInDate,
                energyLevel: energyLevel,
                availableMinutes: availableMinutes,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime checkInDate,
                required String energyLevel,
                required int availableMinutes,
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsCompanion.insert(
                id: id,
                checkInDate: checkInDate,
                energyLevel: energyLevel,
                availableMinutes: availableMinutes,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCheckInsTable,
      DailyCheckInRow,
      $$DailyCheckInsTableFilterComposer,
      $$DailyCheckInsTableOrderingComposer,
      $$DailyCheckInsTableAnnotationComposer,
      $$DailyCheckInsTableCreateCompanionBuilder,
      $$DailyCheckInsTableUpdateCompanionBuilder,
      (
        DailyCheckInRow,
        BaseReferences<_$AppDatabase, $DailyCheckInsTable, DailyCheckInRow>,
      ),
      DailyCheckInRow,
      PrefetchHooks Function()
    >;
typedef $$SprintsTableCreateCompanionBuilder =
    SprintsCompanion Function({
      required String id,
      required String projectId,
      required String name,
      Value<String?> hypothesis,
      required DateTime startDate,
      required DateTime endDate,
      Value<int?> targetOutputs,
      Value<String?> successCriteria,
      required String status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SprintsTableUpdateCompanionBuilder =
    SprintsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> name,
      Value<String?> hypothesis,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<int?> targetOutputs,
      Value<String?> successCriteria,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SprintsTableReferences
    extends BaseReferences<_$AppDatabase, $SprintsTable, SprintRow> {
  $$SprintsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('sprints__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DailyPlansTable, List<DailyPlanRow>>
  _dailyPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyPlans,
    aliasName: 'sprints__id__daily_plans__sprint_id',
  );

  $$DailyPlansTableProcessedTableManager get dailyPlansRefs {
    final manager = $$DailyPlansTableTableManager(
      $_db,
      $_db.dailyPlans,
    ).filter((f) => f.sprintId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeeklyReviewsTable, List<WeeklyReviewRow>>
  _weeklyReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weeklyReviews,
    aliasName: 'sprints__id__weekly_reviews__sprint_id',
  );

  $$WeeklyReviewsTableProcessedTableManager get weeklyReviewsRefs {
    final manager = $$WeeklyReviewsTableTableManager(
      $_db,
      $_db.weeklyReviews,
    ).filter((f) => f.sprintId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weeklyReviewsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SprintClosuresTable, List<SprintClosureRow>>
  _closuresForClosedSprintTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sprintClosures,
        aliasName: 'sprints__id__sprint_closures__sprint_id',
      );

  $$SprintClosuresTableProcessedTableManager get closuresForClosedSprint {
    final manager = $$SprintClosuresTableTableManager(
      $_db,
      $_db.sprintClosures,
    ).filter((f) => f.sprintId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _closuresForClosedSprintTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SprintClosuresTable, List<SprintClosureRow>>
  _closuresForNextSprintTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sprintClosures,
        aliasName: 'sprints__id__sprint_closures__next_sprint_id',
      );

  $$SprintClosuresTableProcessedTableManager get closuresForNextSprint {
    final manager = $$SprintClosuresTableTableManager(
      $_db,
      $_db.sprintClosures,
    ).filter((f) => f.nextSprintId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _closuresForNextSprintTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SprintsTableFilterComposer
    extends Composer<_$AppDatabase, $SprintsTable> {
  $$SprintsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hypothesis => $composableBuilder(
    column: $table.hypothesis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetOutputs => $composableBuilder(
    column: $table.targetOutputs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get successCriteria => $composableBuilder(
    column: $table.successCriteria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> dailyPlansRefs(
    Expression<bool> Function($$DailyPlansTableFilterComposer f) f,
  ) {
    final $$DailyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.sprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableFilterComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weeklyReviewsRefs(
    Expression<bool> Function($$WeeklyReviewsTableFilterComposer f) f,
  ) {
    final $$WeeklyReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklyReviews,
      getReferencedColumn: (t) => t.sprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyReviewsTableFilterComposer(
            $db: $db,
            $table: $db.weeklyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> closuresForClosedSprint(
    Expression<bool> Function($$SprintClosuresTableFilterComposer f) f,
  ) {
    final $$SprintClosuresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprintClosures,
      getReferencedColumn: (t) => t.sprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintClosuresTableFilterComposer(
            $db: $db,
            $table: $db.sprintClosures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> closuresForNextSprint(
    Expression<bool> Function($$SprintClosuresTableFilterComposer f) f,
  ) {
    final $$SprintClosuresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprintClosures,
      getReferencedColumn: (t) => t.nextSprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintClosuresTableFilterComposer(
            $db: $db,
            $table: $db.sprintClosures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SprintsTableOrderingComposer
    extends Composer<_$AppDatabase, $SprintsTable> {
  $$SprintsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hypothesis => $composableBuilder(
    column: $table.hypothesis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetOutputs => $composableBuilder(
    column: $table.targetOutputs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get successCriteria => $composableBuilder(
    column: $table.successCriteria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SprintsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SprintsTable> {
  $$SprintsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get hypothesis => $composableBuilder(
    column: $table.hypothesis,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get targetOutputs => $composableBuilder(
    column: $table.targetOutputs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get successCriteria => $composableBuilder(
    column: $table.successCriteria,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> dailyPlansRefs<T extends Object>(
    Expression<T> Function($$DailyPlansTableAnnotationComposer a) f,
  ) {
    final $$DailyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.sprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weeklyReviewsRefs<T extends Object>(
    Expression<T> Function($$WeeklyReviewsTableAnnotationComposer a) f,
  ) {
    final $$WeeklyReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklyReviews,
      getReferencedColumn: (t) => t.sprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> closuresForClosedSprint<T extends Object>(
    Expression<T> Function($$SprintClosuresTableAnnotationComposer a) f,
  ) {
    final $$SprintClosuresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprintClosures,
      getReferencedColumn: (t) => t.sprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintClosuresTableAnnotationComposer(
            $db: $db,
            $table: $db.sprintClosures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> closuresForNextSprint<T extends Object>(
    Expression<T> Function($$SprintClosuresTableAnnotationComposer a) f,
  ) {
    final $$SprintClosuresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sprintClosures,
      getReferencedColumn: (t) => t.nextSprintId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintClosuresTableAnnotationComposer(
            $db: $db,
            $table: $db.sprintClosures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SprintsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SprintsTable,
          SprintRow,
          $$SprintsTableFilterComposer,
          $$SprintsTableOrderingComposer,
          $$SprintsTableAnnotationComposer,
          $$SprintsTableCreateCompanionBuilder,
          $$SprintsTableUpdateCompanionBuilder,
          (SprintRow, $$SprintsTableReferences),
          SprintRow,
          PrefetchHooks Function({
            bool projectId,
            bool dailyPlansRefs,
            bool weeklyReviewsRefs,
            bool closuresForClosedSprint,
            bool closuresForNextSprint,
          })
        > {
  $$SprintsTableTableManager(_$AppDatabase db, $SprintsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SprintsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SprintsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SprintsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> hypothesis = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<int?> targetOutputs = const Value.absent(),
                Value<String?> successCriteria = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SprintsCompanion(
                id: id,
                projectId: projectId,
                name: name,
                hypothesis: hypothesis,
                startDate: startDate,
                endDate: endDate,
                targetOutputs: targetOutputs,
                successCriteria: successCriteria,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String name,
                Value<String?> hypothesis = const Value.absent(),
                required DateTime startDate,
                required DateTime endDate,
                Value<int?> targetOutputs = const Value.absent(),
                Value<String?> successCriteria = const Value.absent(),
                required String status,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SprintsCompanion.insert(
                id: id,
                projectId: projectId,
                name: name,
                hypothesis: hypothesis,
                startDate: startDate,
                endDate: endDate,
                targetOutputs: targetOutputs,
                successCriteria: successCriteria,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SprintsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                dailyPlansRefs = false,
                weeklyReviewsRefs = false,
                closuresForClosedSprint = false,
                closuresForNextSprint = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dailyPlansRefs) db.dailyPlans,
                    if (weeklyReviewsRefs) db.weeklyReviews,
                    if (closuresForClosedSprint) db.sprintClosures,
                    if (closuresForNextSprint) db.sprintClosures,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $$SprintsTableReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $$SprintsTableReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dailyPlansRefs)
                        await $_getPrefetchedData<
                          SprintRow,
                          $SprintsTable,
                          DailyPlanRow
                        >(
                          currentTable: table,
                          referencedTable: $$SprintsTableReferences
                              ._dailyPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SprintsTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sprintId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weeklyReviewsRefs)
                        await $_getPrefetchedData<
                          SprintRow,
                          $SprintsTable,
                          WeeklyReviewRow
                        >(
                          currentTable: table,
                          referencedTable: $$SprintsTableReferences
                              ._weeklyReviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SprintsTableReferences(
                                db,
                                table,
                                p0,
                              ).weeklyReviewsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sprintId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (closuresForClosedSprint)
                        await $_getPrefetchedData<
                          SprintRow,
                          $SprintsTable,
                          SprintClosureRow
                        >(
                          currentTable: table,
                          referencedTable: $$SprintsTableReferences
                              ._closuresForClosedSprintTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SprintsTableReferences(
                                db,
                                table,
                                p0,
                              ).closuresForClosedSprint,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sprintId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (closuresForNextSprint)
                        await $_getPrefetchedData<
                          SprintRow,
                          $SprintsTable,
                          SprintClosureRow
                        >(
                          currentTable: table,
                          referencedTable: $$SprintsTableReferences
                              ._closuresForNextSprintTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SprintsTableReferences(
                                db,
                                table,
                                p0,
                              ).closuresForNextSprint,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.nextSprintId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SprintsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SprintsTable,
      SprintRow,
      $$SprintsTableFilterComposer,
      $$SprintsTableOrderingComposer,
      $$SprintsTableAnnotationComposer,
      $$SprintsTableCreateCompanionBuilder,
      $$SprintsTableUpdateCompanionBuilder,
      (SprintRow, $$SprintsTableReferences),
      SprintRow,
      PrefetchHooks Function({
        bool projectId,
        bool dailyPlansRefs,
        bool weeklyReviewsRefs,
        bool closuresForClosedSprint,
        bool closuresForNextSprint,
      })
    >;
typedef $$DailyPlansTableCreateCompanionBuilder =
    DailyPlansCompanion Function({
      required String id,
      required String sprintId,
      required DateTime planDate,
      required String requiredOutcome,
      Value<String?> lowEnergyAction,
      Value<String?> linkedGuideDocumentId,
      Value<int?> linkedGuidePage,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DailyPlansTableUpdateCompanionBuilder =
    DailyPlansCompanion Function({
      Value<String> id,
      Value<String> sprintId,
      Value<DateTime> planDate,
      Value<String> requiredOutcome,
      Value<String?> lowEnergyAction,
      Value<String?> linkedGuideDocumentId,
      Value<int?> linkedGuidePage,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$DailyPlansTableReferences
    extends BaseReferences<_$AppDatabase, $DailyPlansTable, DailyPlanRow> {
  $$DailyPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SprintsTable _sprintIdTable(_$AppDatabase db) =>
      db.sprints.createAlias('daily_plans__sprint_id__sprints__id');

  $$SprintsTableProcessedTableManager get sprintId {
    final $_column = $_itemColumn<String>('sprint_id')!;

    final manager = $$SprintsTableTableManager(
      $_db,
      $_db.sprints,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sprintIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DailyActionsTable, List<DailyActionRow>>
  _dailyActionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyActions,
    aliasName: 'daily_plans__id__daily_actions__daily_plan_id',
  );

  $$DailyActionsTableProcessedTableManager get dailyActionsRefs {
    final manager = $$DailyActionsTableTableManager(
      $_db,
      $_db.dailyActions,
    ).filter((f) => f.dailyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyActionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShipRecordsTable, List<ShipRecordRow>>
  _shipRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shipRecords,
    aliasName: 'daily_plans__id__ship_records__daily_plan_id',
  );

  $$ShipRecordsTableProcessedTableManager get shipRecordsRefs {
    final manager = $$ShipRecordsTableTableManager(
      $_db,
      $_db.shipRecords,
    ).filter((f) => f.dailyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shipRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DailyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $DailyPlansTable> {
  $$DailyPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get planDate => $composableBuilder(
    column: $table.planDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requiredOutcome => $composableBuilder(
    column: $table.requiredOutcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lowEnergyAction => $composableBuilder(
    column: $table.lowEnergyAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedGuideDocumentId => $composableBuilder(
    column: $table.linkedGuideDocumentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get linkedGuidePage => $composableBuilder(
    column: $table.linkedGuidePage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SprintsTableFilterComposer get sprintId {
    final $$SprintsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableFilterComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> dailyActionsRefs(
    Expression<bool> Function($$DailyActionsTableFilterComposer f) f,
  ) {
    final $$DailyActionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyActions,
      getReferencedColumn: (t) => t.dailyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyActionsTableFilterComposer(
            $db: $db,
            $table: $db.dailyActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shipRecordsRefs(
    Expression<bool> Function($$ShipRecordsTableFilterComposer f) f,
  ) {
    final $$ShipRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shipRecords,
      getReferencedColumn: (t) => t.dailyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShipRecordsTableFilterComposer(
            $db: $db,
            $table: $db.shipRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyPlansTable> {
  $$DailyPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get planDate => $composableBuilder(
    column: $table.planDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requiredOutcome => $composableBuilder(
    column: $table.requiredOutcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lowEnergyAction => $composableBuilder(
    column: $table.lowEnergyAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedGuideDocumentId => $composableBuilder(
    column: $table.linkedGuideDocumentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get linkedGuidePage => $composableBuilder(
    column: $table.linkedGuidePage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SprintsTableOrderingComposer get sprintId {
    final $$SprintsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableOrderingComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyPlansTable> {
  $$DailyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get planDate =>
      $composableBuilder(column: $table.planDate, builder: (column) => column);

  GeneratedColumn<String> get requiredOutcome => $composableBuilder(
    column: $table.requiredOutcome,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lowEnergyAction => $composableBuilder(
    column: $table.lowEnergyAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedGuideDocumentId => $composableBuilder(
    column: $table.linkedGuideDocumentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get linkedGuidePage => $composableBuilder(
    column: $table.linkedGuidePage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SprintsTableAnnotationComposer get sprintId {
    final $$SprintsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableAnnotationComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> dailyActionsRefs<T extends Object>(
    Expression<T> Function($$DailyActionsTableAnnotationComposer a) f,
  ) {
    final $$DailyActionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyActions,
      getReferencedColumn: (t) => t.dailyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyActionsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shipRecordsRefs<T extends Object>(
    Expression<T> Function($$ShipRecordsTableAnnotationComposer a) f,
  ) {
    final $$ShipRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shipRecords,
      getReferencedColumn: (t) => t.dailyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShipRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.shipRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyPlansTable,
          DailyPlanRow,
          $$DailyPlansTableFilterComposer,
          $$DailyPlansTableOrderingComposer,
          $$DailyPlansTableAnnotationComposer,
          $$DailyPlansTableCreateCompanionBuilder,
          $$DailyPlansTableUpdateCompanionBuilder,
          (DailyPlanRow, $$DailyPlansTableReferences),
          DailyPlanRow,
          PrefetchHooks Function({
            bool sprintId,
            bool dailyActionsRefs,
            bool shipRecordsRefs,
          })
        > {
  $$DailyPlansTableTableManager(_$AppDatabase db, $DailyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sprintId = const Value.absent(),
                Value<DateTime> planDate = const Value.absent(),
                Value<String> requiredOutcome = const Value.absent(),
                Value<String?> lowEnergyAction = const Value.absent(),
                Value<String?> linkedGuideDocumentId = const Value.absent(),
                Value<int?> linkedGuidePage = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyPlansCompanion(
                id: id,
                sprintId: sprintId,
                planDate: planDate,
                requiredOutcome: requiredOutcome,
                lowEnergyAction: lowEnergyAction,
                linkedGuideDocumentId: linkedGuideDocumentId,
                linkedGuidePage: linkedGuidePage,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sprintId,
                required DateTime planDate,
                required String requiredOutcome,
                Value<String?> lowEnergyAction = const Value.absent(),
                Value<String?> linkedGuideDocumentId = const Value.absent(),
                Value<int?> linkedGuidePage = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyPlansCompanion.insert(
                id: id,
                sprintId: sprintId,
                planDate: planDate,
                requiredOutcome: requiredOutcome,
                lowEnergyAction: lowEnergyAction,
                linkedGuideDocumentId: linkedGuideDocumentId,
                linkedGuidePage: linkedGuidePage,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sprintId = false,
                dailyActionsRefs = false,
                shipRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dailyActionsRefs) db.dailyActions,
                    if (shipRecordsRefs) db.shipRecords,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sprintId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sprintId,
                                    referencedTable: $$DailyPlansTableReferences
                                        ._sprintIdTable(db),
                                    referencedColumn:
                                        $$DailyPlansTableReferences
                                            ._sprintIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dailyActionsRefs)
                        await $_getPrefetchedData<
                          DailyPlanRow,
                          $DailyPlansTable,
                          DailyActionRow
                        >(
                          currentTable: table,
                          referencedTable: $$DailyPlansTableReferences
                              ._dailyActionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyActionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shipRecordsRefs)
                        await $_getPrefetchedData<
                          DailyPlanRow,
                          $DailyPlansTable,
                          ShipRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$DailyPlansTableReferences
                              ._shipRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).shipRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DailyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyPlansTable,
      DailyPlanRow,
      $$DailyPlansTableFilterComposer,
      $$DailyPlansTableOrderingComposer,
      $$DailyPlansTableAnnotationComposer,
      $$DailyPlansTableCreateCompanionBuilder,
      $$DailyPlansTableUpdateCompanionBuilder,
      (DailyPlanRow, $$DailyPlansTableReferences),
      DailyPlanRow,
      PrefetchHooks Function({
        bool sprintId,
        bool dailyActionsRefs,
        bool shipRecordsRefs,
      })
    >;
typedef $$DailyActionsTableCreateCompanionBuilder =
    DailyActionsCompanion Function({
      required String id,
      required String dailyPlanId,
      required int position,
      required String label,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DailyActionsTableUpdateCompanionBuilder =
    DailyActionsCompanion Function({
      Value<String> id,
      Value<String> dailyPlanId,
      Value<int> position,
      Value<String> label,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$DailyActionsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyActionsTable, DailyActionRow> {
  $$DailyActionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyPlansTable _dailyPlanIdTable(_$AppDatabase db) => db.dailyPlans
      .createAlias('daily_actions__daily_plan_id__daily_plans__id');

  $$DailyPlansTableProcessedTableManager get dailyPlanId {
    final $_column = $_itemColumn<String>('daily_plan_id')!;

    final manager = $$DailyPlansTableTableManager(
      $_db,
      $_db.dailyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyActionsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyActionsTable> {
  $$DailyActionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyPlansTableFilterComposer get dailyPlanId {
    final $$DailyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyPlanId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableFilterComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyActionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyActionsTable> {
  $$DailyActionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyPlansTableOrderingComposer get dailyPlanId {
    final $$DailyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyPlanId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyActionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyActionsTable> {
  $$DailyActionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DailyPlansTableAnnotationComposer get dailyPlanId {
    final $$DailyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyPlanId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyActionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyActionsTable,
          DailyActionRow,
          $$DailyActionsTableFilterComposer,
          $$DailyActionsTableOrderingComposer,
          $$DailyActionsTableAnnotationComposer,
          $$DailyActionsTableCreateCompanionBuilder,
          $$DailyActionsTableUpdateCompanionBuilder,
          (DailyActionRow, $$DailyActionsTableReferences),
          DailyActionRow,
          PrefetchHooks Function({bool dailyPlanId})
        > {
  $$DailyActionsTableTableManager(_$AppDatabase db, $DailyActionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dailyPlanId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyActionsCompanion(
                id: id,
                dailyPlanId: dailyPlanId,
                position: position,
                label: label,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dailyPlanId,
                required int position,
                required String label,
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyActionsCompanion.insert(
                id: id,
                dailyPlanId: dailyPlanId,
                position: position,
                label: label,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyActionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyPlanId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyPlanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyPlanId,
                                referencedTable: $$DailyActionsTableReferences
                                    ._dailyPlanIdTable(db),
                                referencedColumn: $$DailyActionsTableReferences
                                    ._dailyPlanIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DailyActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyActionsTable,
      DailyActionRow,
      $$DailyActionsTableFilterComposer,
      $$DailyActionsTableOrderingComposer,
      $$DailyActionsTableAnnotationComposer,
      $$DailyActionsTableCreateCompanionBuilder,
      $$DailyActionsTableUpdateCompanionBuilder,
      (DailyActionRow, $$DailyActionsTableReferences),
      DailyActionRow,
      PrefetchHooks Function({bool dailyPlanId})
    >;
typedef $$ShipRecordsTableCreateCompanionBuilder =
    ShipRecordsCompanion Function({
      required String id,
      required String dailyPlanId,
      required String outputType,
      required String outputTitle,
      Value<String?> externalUrl,
      Value<String?> evidenceNote,
      Value<bool> isPartial,
      required DateTime shippedAt,
      Value<int> rowid,
    });
typedef $$ShipRecordsTableUpdateCompanionBuilder =
    ShipRecordsCompanion Function({
      Value<String> id,
      Value<String> dailyPlanId,
      Value<String> outputType,
      Value<String> outputTitle,
      Value<String?> externalUrl,
      Value<String?> evidenceNote,
      Value<bool> isPartial,
      Value<DateTime> shippedAt,
      Value<int> rowid,
    });

final class $$ShipRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ShipRecordsTable, ShipRecordRow> {
  $$ShipRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyPlansTable _dailyPlanIdTable(_$AppDatabase db) =>
      db.dailyPlans.createAlias('ship_records__daily_plan_id__daily_plans__id');

  $$DailyPlansTableProcessedTableManager get dailyPlanId {
    final $_column = $_itemColumn<String>('daily_plan_id')!;

    final manager = $$DailyPlansTableTableManager(
      $_db,
      $_db.dailyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShipRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ShipRecordsTable> {
  $$ShipRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outputType => $composableBuilder(
    column: $table.outputType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outputTitle => $composableBuilder(
    column: $table.outputTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalUrl => $composableBuilder(
    column: $table.externalUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidenceNote => $composableBuilder(
    column: $table.evidenceNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPartial => $composableBuilder(
    column: $table.isPartial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get shippedAt => $composableBuilder(
    column: $table.shippedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyPlansTableFilterComposer get dailyPlanId {
    final $$DailyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyPlanId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableFilterComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShipRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShipRecordsTable> {
  $$ShipRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outputType => $composableBuilder(
    column: $table.outputType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outputTitle => $composableBuilder(
    column: $table.outputTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalUrl => $composableBuilder(
    column: $table.externalUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidenceNote => $composableBuilder(
    column: $table.evidenceNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPartial => $composableBuilder(
    column: $table.isPartial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get shippedAt => $composableBuilder(
    column: $table.shippedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyPlansTableOrderingComposer get dailyPlanId {
    final $$DailyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyPlanId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShipRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShipRecordsTable> {
  $$ShipRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get outputType => $composableBuilder(
    column: $table.outputType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outputTitle => $composableBuilder(
    column: $table.outputTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalUrl => $composableBuilder(
    column: $table.externalUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get evidenceNote => $composableBuilder(
    column: $table.evidenceNote,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPartial =>
      $composableBuilder(column: $table.isPartial, builder: (column) => column);

  GeneratedColumn<DateTime> get shippedAt =>
      $composableBuilder(column: $table.shippedAt, builder: (column) => column);

  $$DailyPlansTableAnnotationComposer get dailyPlanId {
    final $$DailyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyPlanId,
      referencedTable: $db.dailyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShipRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShipRecordsTable,
          ShipRecordRow,
          $$ShipRecordsTableFilterComposer,
          $$ShipRecordsTableOrderingComposer,
          $$ShipRecordsTableAnnotationComposer,
          $$ShipRecordsTableCreateCompanionBuilder,
          $$ShipRecordsTableUpdateCompanionBuilder,
          (ShipRecordRow, $$ShipRecordsTableReferences),
          ShipRecordRow,
          PrefetchHooks Function({bool dailyPlanId})
        > {
  $$ShipRecordsTableTableManager(_$AppDatabase db, $ShipRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShipRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShipRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShipRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dailyPlanId = const Value.absent(),
                Value<String> outputType = const Value.absent(),
                Value<String> outputTitle = const Value.absent(),
                Value<String?> externalUrl = const Value.absent(),
                Value<String?> evidenceNote = const Value.absent(),
                Value<bool> isPartial = const Value.absent(),
                Value<DateTime> shippedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShipRecordsCompanion(
                id: id,
                dailyPlanId: dailyPlanId,
                outputType: outputType,
                outputTitle: outputTitle,
                externalUrl: externalUrl,
                evidenceNote: evidenceNote,
                isPartial: isPartial,
                shippedAt: shippedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dailyPlanId,
                required String outputType,
                required String outputTitle,
                Value<String?> externalUrl = const Value.absent(),
                Value<String?> evidenceNote = const Value.absent(),
                Value<bool> isPartial = const Value.absent(),
                required DateTime shippedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShipRecordsCompanion.insert(
                id: id,
                dailyPlanId: dailyPlanId,
                outputType: outputType,
                outputTitle: outputTitle,
                externalUrl: externalUrl,
                evidenceNote: evidenceNote,
                isPartial: isPartial,
                shippedAt: shippedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShipRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyPlanId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyPlanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyPlanId,
                                referencedTable: $$ShipRecordsTableReferences
                                    ._dailyPlanIdTable(db),
                                referencedColumn: $$ShipRecordsTableReferences
                                    ._dailyPlanIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShipRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShipRecordsTable,
      ShipRecordRow,
      $$ShipRecordsTableFilterComposer,
      $$ShipRecordsTableOrderingComposer,
      $$ShipRecordsTableAnnotationComposer,
      $$ShipRecordsTableCreateCompanionBuilder,
      $$ShipRecordsTableUpdateCompanionBuilder,
      (ShipRecordRow, $$ShipRecordsTableReferences),
      ShipRecordRow,
      PrefetchHooks Function({bool dailyPlanId})
    >;
typedef $$GuideDocumentsTableCreateCompanionBuilder =
    GuideDocumentsCompanion Function({
      required String id,
      required String originalFileName,
      required String displayTitle,
      required String storedRelativePath,
      required int fileSizeBytes,
      Value<String?> checksum,
      Value<String?> projectId,
      required String category,
      Value<String?> description,
      Value<String?> whenToRead,
      Value<bool> isPinned,
      required int pageCount,
      Value<int> lastReadPage,
      Value<DateTime?> lastOpenedAt,
      required DateTime importedAt,
      required DateTime updatedAt,
      Value<bool> cleanupNeeded,
      Value<int> rowid,
    });
typedef $$GuideDocumentsTableUpdateCompanionBuilder =
    GuideDocumentsCompanion Function({
      Value<String> id,
      Value<String> originalFileName,
      Value<String> displayTitle,
      Value<String> storedRelativePath,
      Value<int> fileSizeBytes,
      Value<String?> checksum,
      Value<String?> projectId,
      Value<String> category,
      Value<String?> description,
      Value<String?> whenToRead,
      Value<bool> isPinned,
      Value<int> pageCount,
      Value<int> lastReadPage,
      Value<DateTime?> lastOpenedAt,
      Value<DateTime> importedAt,
      Value<DateTime> updatedAt,
      Value<bool> cleanupNeeded,
      Value<int> rowid,
    });

final class $$GuideDocumentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $GuideDocumentsTable, GuideDocumentRow> {
  $$GuideDocumentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('guide_documents__project_id__projects__id');

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<String>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PdfBookmarksTable, List<PdfBookmarkRow>>
  _pdfBookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfBookmarks,
    aliasName: 'guide_documents__id__pdf_bookmarks__document_id',
  );

  $$PdfBookmarksTableProcessedTableManager get pdfBookmarksRefs {
    final manager = $$PdfBookmarksTableTableManager(
      $_db,
      $_db.pdfBookmarks,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pdfBookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PdfNotesTable, List<PdfNoteRow>>
  _pdfNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pdfNotes,
    aliasName: 'guide_documents__id__pdf_notes__document_id',
  );

  $$PdfNotesTableProcessedTableManager get pdfNotesRefs {
    final manager = $$PdfNotesTableTableManager(
      $_db,
      $_db.pdfNotes,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pdfNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GuideDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $GuideDocumentsTable> {
  $$GuideDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storedRelativePath => $composableBuilder(
    column: $table.storedRelativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whenToRead => $composableBuilder(
    column: $table.whenToRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReadPage => $composableBuilder(
    column: $table.lastReadPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cleanupNeeded => $composableBuilder(
    column: $table.cleanupNeeded,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pdfBookmarksRefs(
    Expression<bool> Function($$PdfBookmarksTableFilterComposer f) f,
  ) {
    final $$PdfBookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfBookmarks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfBookmarksTableFilterComposer(
            $db: $db,
            $table: $db.pdfBookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pdfNotesRefs(
    Expression<bool> Function($$PdfNotesTableFilterComposer f) f,
  ) {
    final $$PdfNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfNotes,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfNotesTableFilterComposer(
            $db: $db,
            $table: $db.pdfNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GuideDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $GuideDocumentsTable> {
  $$GuideDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storedRelativePath => $composableBuilder(
    column: $table.storedRelativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whenToRead => $composableBuilder(
    column: $table.whenToRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReadPage => $composableBuilder(
    column: $table.lastReadPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cleanupNeeded => $composableBuilder(
    column: $table.cleanupNeeded,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GuideDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GuideDocumentsTable> {
  $$GuideDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get storedRelativePath => $composableBuilder(
    column: $table.storedRelativePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get whenToRead => $composableBuilder(
    column: $table.whenToRead,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<int> get lastReadPage => $composableBuilder(
    column: $table.lastReadPage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get cleanupNeeded => $composableBuilder(
    column: $table.cleanupNeeded,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pdfBookmarksRefs<T extends Object>(
    Expression<T> Function($$PdfBookmarksTableAnnotationComposer a) f,
  ) {
    final $$PdfBookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfBookmarks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfBookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfBookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pdfNotesRefs<T extends Object>(
    Expression<T> Function($$PdfNotesTableAnnotationComposer a) f,
  ) {
    final $$PdfNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pdfNotes,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PdfNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.pdfNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GuideDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GuideDocumentsTable,
          GuideDocumentRow,
          $$GuideDocumentsTableFilterComposer,
          $$GuideDocumentsTableOrderingComposer,
          $$GuideDocumentsTableAnnotationComposer,
          $$GuideDocumentsTableCreateCompanionBuilder,
          $$GuideDocumentsTableUpdateCompanionBuilder,
          (GuideDocumentRow, $$GuideDocumentsTableReferences),
          GuideDocumentRow,
          PrefetchHooks Function({
            bool projectId,
            bool pdfBookmarksRefs,
            bool pdfNotesRefs,
          })
        > {
  $$GuideDocumentsTableTableManager(
    _$AppDatabase db,
    $GuideDocumentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GuideDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GuideDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GuideDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> originalFileName = const Value.absent(),
                Value<String> displayTitle = const Value.absent(),
                Value<String> storedRelativePath = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> whenToRead = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<int> pageCount = const Value.absent(),
                Value<int> lastReadPage = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> cleanupNeeded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GuideDocumentsCompanion(
                id: id,
                originalFileName: originalFileName,
                displayTitle: displayTitle,
                storedRelativePath: storedRelativePath,
                fileSizeBytes: fileSizeBytes,
                checksum: checksum,
                projectId: projectId,
                category: category,
                description: description,
                whenToRead: whenToRead,
                isPinned: isPinned,
                pageCount: pageCount,
                lastReadPage: lastReadPage,
                lastOpenedAt: lastOpenedAt,
                importedAt: importedAt,
                updatedAt: updatedAt,
                cleanupNeeded: cleanupNeeded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String originalFileName,
                required String displayTitle,
                required String storedRelativePath,
                required int fileSizeBytes,
                Value<String?> checksum = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                required String category,
                Value<String?> description = const Value.absent(),
                Value<String?> whenToRead = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                required int pageCount,
                Value<int> lastReadPage = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                required DateTime importedAt,
                required DateTime updatedAt,
                Value<bool> cleanupNeeded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GuideDocumentsCompanion.insert(
                id: id,
                originalFileName: originalFileName,
                displayTitle: displayTitle,
                storedRelativePath: storedRelativePath,
                fileSizeBytes: fileSizeBytes,
                checksum: checksum,
                projectId: projectId,
                category: category,
                description: description,
                whenToRead: whenToRead,
                isPinned: isPinned,
                pageCount: pageCount,
                lastReadPage: lastReadPage,
                lastOpenedAt: lastOpenedAt,
                importedAt: importedAt,
                updatedAt: updatedAt,
                cleanupNeeded: cleanupNeeded,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GuideDocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                pdfBookmarksRefs = false,
                pdfNotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pdfBookmarksRefs) db.pdfBookmarks,
                    if (pdfNotesRefs) db.pdfNotes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$GuideDocumentsTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$GuideDocumentsTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pdfBookmarksRefs)
                        await $_getPrefetchedData<
                          GuideDocumentRow,
                          $GuideDocumentsTable,
                          PdfBookmarkRow
                        >(
                          currentTable: table,
                          referencedTable: $$GuideDocumentsTableReferences
                              ._pdfBookmarksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GuideDocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfBookmarksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pdfNotesRefs)
                        await $_getPrefetchedData<
                          GuideDocumentRow,
                          $GuideDocumentsTable,
                          PdfNoteRow
                        >(
                          currentTable: table,
                          referencedTable: $$GuideDocumentsTableReferences
                              ._pdfNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GuideDocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).pdfNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GuideDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GuideDocumentsTable,
      GuideDocumentRow,
      $$GuideDocumentsTableFilterComposer,
      $$GuideDocumentsTableOrderingComposer,
      $$GuideDocumentsTableAnnotationComposer,
      $$GuideDocumentsTableCreateCompanionBuilder,
      $$GuideDocumentsTableUpdateCompanionBuilder,
      (GuideDocumentRow, $$GuideDocumentsTableReferences),
      GuideDocumentRow,
      PrefetchHooks Function({
        bool projectId,
        bool pdfBookmarksRefs,
        bool pdfNotesRefs,
      })
    >;
typedef $$PdfBookmarksTableCreateCompanionBuilder =
    PdfBookmarksCompanion Function({
      required String id,
      required String documentId,
      required int pageNumber,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PdfBookmarksTableUpdateCompanionBuilder =
    PdfBookmarksCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> pageNumber,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PdfBookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $PdfBookmarksTable, PdfBookmarkRow> {
  $$PdfBookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GuideDocumentsTable _documentIdTable(_$AppDatabase db) => db
      .guideDocuments
      .createAlias('pdf_bookmarks__document_id__guide_documents__id');

  $$GuideDocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$GuideDocumentsTableTableManager(
      $_db,
      $_db.guideDocuments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfBookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $PdfBookmarksTable> {
  $$PdfBookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GuideDocumentsTableFilterComposer get documentId {
    final $$GuideDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfBookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfBookmarksTable> {
  $$PdfBookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GuideDocumentsTableOrderingComposer get documentId {
    final $$GuideDocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfBookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfBookmarksTable> {
  $$PdfBookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GuideDocumentsTableAnnotationComposer get documentId {
    final $$GuideDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfBookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfBookmarksTable,
          PdfBookmarkRow,
          $$PdfBookmarksTableFilterComposer,
          $$PdfBookmarksTableOrderingComposer,
          $$PdfBookmarksTableAnnotationComposer,
          $$PdfBookmarksTableCreateCompanionBuilder,
          $$PdfBookmarksTableUpdateCompanionBuilder,
          (PdfBookmarkRow, $$PdfBookmarksTableReferences),
          PdfBookmarkRow,
          PrefetchHooks Function({bool documentId})
        > {
  $$PdfBookmarksTableTableManager(_$AppDatabase db, $PdfBookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfBookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfBookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfBookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PdfBookmarksCompanion(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int pageNumber,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PdfBookmarksCompanion.insert(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfBookmarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$PdfBookmarksTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$PdfBookmarksTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfBookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfBookmarksTable,
      PdfBookmarkRow,
      $$PdfBookmarksTableFilterComposer,
      $$PdfBookmarksTableOrderingComposer,
      $$PdfBookmarksTableAnnotationComposer,
      $$PdfBookmarksTableCreateCompanionBuilder,
      $$PdfBookmarksTableUpdateCompanionBuilder,
      (PdfBookmarkRow, $$PdfBookmarksTableReferences),
      PdfBookmarkRow,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$PdfNotesTableCreateCompanionBuilder =
    PdfNotesCompanion Function({
      required String id,
      required String documentId,
      required int pageNumber,
      required String content,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PdfNotesTableUpdateCompanionBuilder =
    PdfNotesCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> pageNumber,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PdfNotesTableReferences
    extends BaseReferences<_$AppDatabase, $PdfNotesTable, PdfNoteRow> {
  $$PdfNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GuideDocumentsTable _documentIdTable(_$AppDatabase db) => db
      .guideDocuments
      .createAlias('pdf_notes__document_id__guide_documents__id');

  $$GuideDocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$GuideDocumentsTableTableManager(
      $_db,
      $_db.guideDocuments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PdfNotesTableFilterComposer
    extends Composer<_$AppDatabase, $PdfNotesTable> {
  $$PdfNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GuideDocumentsTableFilterComposer get documentId {
    final $$GuideDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfNotesTable> {
  $$PdfNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GuideDocumentsTableOrderingComposer get documentId {
    final $$GuideDocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfNotesTable> {
  $$PdfNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GuideDocumentsTableAnnotationComposer get documentId {
    final $$GuideDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.guideDocuments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuideDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.guideDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PdfNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfNotesTable,
          PdfNoteRow,
          $$PdfNotesTableFilterComposer,
          $$PdfNotesTableOrderingComposer,
          $$PdfNotesTableAnnotationComposer,
          $$PdfNotesTableCreateCompanionBuilder,
          $$PdfNotesTableUpdateCompanionBuilder,
          (PdfNoteRow, $$PdfNotesTableReferences),
          PdfNoteRow,
          PrefetchHooks Function({bool documentId})
        > {
  $$PdfNotesTableTableManager(_$AppDatabase db, $PdfNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PdfNotesCompanion(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int pageNumber,
                required String content,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PdfNotesCompanion.insert(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PdfNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$PdfNotesTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$PdfNotesTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PdfNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfNotesTable,
      PdfNoteRow,
      $$PdfNotesTableFilterComposer,
      $$PdfNotesTableOrderingComposer,
      $$PdfNotesTableAnnotationComposer,
      $$PdfNotesTableCreateCompanionBuilder,
      $$PdfNotesTableUpdateCompanionBuilder,
      (PdfNoteRow, $$PdfNotesTableReferences),
      PdfNoteRow,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$MetricEntriesTableCreateCompanionBuilder =
    MetricEntriesCompanion Function({
      required String id,
      required String projectId,
      required DateTime entryDate,
      Value<int> outputsCount,
      Value<int?> views,
      Value<int?> clicks,
      Value<int?> orders,
      Value<int?> revenueMinor,
      Value<int?> workMinutes,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MetricEntriesTableUpdateCompanionBuilder =
    MetricEntriesCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<DateTime> entryDate,
      Value<int> outputsCount,
      Value<int?> views,
      Value<int?> clicks,
      Value<int?> orders,
      Value<int?> revenueMinor,
      Value<int?> workMinutes,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MetricEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $MetricEntriesTable, MetricEntryRow> {
  $$MetricEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('metric_entries__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MetricEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MetricEntriesTable> {
  $$MetricEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputsCount => $composableBuilder(
    column: $table.outputsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get views => $composableBuilder(
    column: $table.views,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clicks => $composableBuilder(
    column: $table.clicks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orders => $composableBuilder(
    column: $table.orders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revenueMinor => $composableBuilder(
    column: $table.revenueMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workMinutes => $composableBuilder(
    column: $table.workMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetricEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetricEntriesTable> {
  $$MetricEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputsCount => $composableBuilder(
    column: $table.outputsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get views => $composableBuilder(
    column: $table.views,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clicks => $composableBuilder(
    column: $table.clicks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orders => $composableBuilder(
    column: $table.orders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revenueMinor => $composableBuilder(
    column: $table.revenueMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workMinutes => $composableBuilder(
    column: $table.workMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetricEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetricEntriesTable> {
  $$MetricEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  GeneratedColumn<int> get outputsCount => $composableBuilder(
    column: $table.outputsCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get views =>
      $composableBuilder(column: $table.views, builder: (column) => column);

  GeneratedColumn<int> get clicks =>
      $composableBuilder(column: $table.clicks, builder: (column) => column);

  GeneratedColumn<int> get orders =>
      $composableBuilder(column: $table.orders, builder: (column) => column);

  GeneratedColumn<int> get revenueMinor => $composableBuilder(
    column: $table.revenueMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get workMinutes => $composableBuilder(
    column: $table.workMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetricEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetricEntriesTable,
          MetricEntryRow,
          $$MetricEntriesTableFilterComposer,
          $$MetricEntriesTableOrderingComposer,
          $$MetricEntriesTableAnnotationComposer,
          $$MetricEntriesTableCreateCompanionBuilder,
          $$MetricEntriesTableUpdateCompanionBuilder,
          (MetricEntryRow, $$MetricEntriesTableReferences),
          MetricEntryRow,
          PrefetchHooks Function({bool projectId})
        > {
  $$MetricEntriesTableTableManager(_$AppDatabase db, $MetricEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetricEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetricEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetricEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<DateTime> entryDate = const Value.absent(),
                Value<int> outputsCount = const Value.absent(),
                Value<int?> views = const Value.absent(),
                Value<int?> clicks = const Value.absent(),
                Value<int?> orders = const Value.absent(),
                Value<int?> revenueMinor = const Value.absent(),
                Value<int?> workMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetricEntriesCompanion(
                id: id,
                projectId: projectId,
                entryDate: entryDate,
                outputsCount: outputsCount,
                views: views,
                clicks: clicks,
                orders: orders,
                revenueMinor: revenueMinor,
                workMinutes: workMinutes,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required DateTime entryDate,
                Value<int> outputsCount = const Value.absent(),
                Value<int?> views = const Value.absent(),
                Value<int?> clicks = const Value.absent(),
                Value<int?> orders = const Value.absent(),
                Value<int?> revenueMinor = const Value.absent(),
                Value<int?> workMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MetricEntriesCompanion.insert(
                id: id,
                projectId: projectId,
                entryDate: entryDate,
                outputsCount: outputsCount,
                views: views,
                clicks: clicks,
                orders: orders,
                revenueMinor: revenueMinor,
                workMinutes: workMinutes,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MetricEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$MetricEntriesTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$MetricEntriesTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MetricEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetricEntriesTable,
      MetricEntryRow,
      $$MetricEntriesTableFilterComposer,
      $$MetricEntriesTableOrderingComposer,
      $$MetricEntriesTableAnnotationComposer,
      $$MetricEntriesTableCreateCompanionBuilder,
      $$MetricEntriesTableUpdateCompanionBuilder,
      (MetricEntryRow, $$MetricEntriesTableReferences),
      MetricEntryRow,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$WeeklyReviewsTableCreateCompanionBuilder =
    WeeklyReviewsCompanion Function({
      required String id,
      required String projectId,
      Value<String?> sprintId,
      required DateTime weekStart,
      required DateTime weekEnd,
      Value<String?> shippedSummary,
      Value<String?> importantResult,
      Value<String?> workedWell,
      Value<String?> wasteOrBlocker,
      required String decision,
      Value<String?> nextWeekFocus,
      Value<DateTime?> decisionAppliedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WeeklyReviewsTableUpdateCompanionBuilder =
    WeeklyReviewsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String?> sprintId,
      Value<DateTime> weekStart,
      Value<DateTime> weekEnd,
      Value<String?> shippedSummary,
      Value<String?> importantResult,
      Value<String?> workedWell,
      Value<String?> wasteOrBlocker,
      Value<String> decision,
      Value<String?> nextWeekFocus,
      Value<DateTime?> decisionAppliedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WeeklyReviewsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReviewRow> {
  $$WeeklyReviewsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('weekly_reviews__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SprintsTable _sprintIdTable(_$AppDatabase db) =>
      db.sprints.createAlias('weekly_reviews__sprint_id__sprints__id');

  $$SprintsTableProcessedTableManager? get sprintId {
    final $_column = $_itemColumn<String>('sprint_id');
    if ($_column == null) return null;
    final manager = $$SprintsTableTableManager(
      $_db,
      $_db.sprints,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sprintIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeeklyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekEnd => $composableBuilder(
    column: $table.weekEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shippedSummary => $composableBuilder(
    column: $table.shippedSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importantResult => $composableBuilder(
    column: $table.importantResult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workedWell => $composableBuilder(
    column: $table.workedWell,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wasteOrBlocker => $composableBuilder(
    column: $table.wasteOrBlocker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextWeekFocus => $composableBuilder(
    column: $table.nextWeekFocus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get decisionAppliedAt => $composableBuilder(
    column: $table.decisionAppliedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SprintsTableFilterComposer get sprintId {
    final $$SprintsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableFilterComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekEnd => $composableBuilder(
    column: $table.weekEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shippedSummary => $composableBuilder(
    column: $table.shippedSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importantResult => $composableBuilder(
    column: $table.importantResult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workedWell => $composableBuilder(
    column: $table.workedWell,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wasteOrBlocker => $composableBuilder(
    column: $table.wasteOrBlocker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextWeekFocus => $composableBuilder(
    column: $table.nextWeekFocus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get decisionAppliedAt => $composableBuilder(
    column: $table.decisionAppliedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SprintsTableOrderingComposer get sprintId {
    final $$SprintsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableOrderingComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<DateTime> get weekEnd =>
      $composableBuilder(column: $table.weekEnd, builder: (column) => column);

  GeneratedColumn<String> get shippedSummary => $composableBuilder(
    column: $table.shippedSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importantResult => $composableBuilder(
    column: $table.importantResult,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workedWell => $composableBuilder(
    column: $table.workedWell,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wasteOrBlocker => $composableBuilder(
    column: $table.wasteOrBlocker,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<String> get nextWeekFocus => $composableBuilder(
    column: $table.nextWeekFocus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get decisionAppliedAt => $composableBuilder(
    column: $table.decisionAppliedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SprintsTableAnnotationComposer get sprintId {
    final $$SprintsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableAnnotationComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyReviewsTable,
          WeeklyReviewRow,
          $$WeeklyReviewsTableFilterComposer,
          $$WeeklyReviewsTableOrderingComposer,
          $$WeeklyReviewsTableAnnotationComposer,
          $$WeeklyReviewsTableCreateCompanionBuilder,
          $$WeeklyReviewsTableUpdateCompanionBuilder,
          (WeeklyReviewRow, $$WeeklyReviewsTableReferences),
          WeeklyReviewRow,
          PrefetchHooks Function({bool projectId, bool sprintId})
        > {
  $$WeeklyReviewsTableTableManager(_$AppDatabase db, $WeeklyReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String?> sprintId = const Value.absent(),
                Value<DateTime> weekStart = const Value.absent(),
                Value<DateTime> weekEnd = const Value.absent(),
                Value<String?> shippedSummary = const Value.absent(),
                Value<String?> importantResult = const Value.absent(),
                Value<String?> workedWell = const Value.absent(),
                Value<String?> wasteOrBlocker = const Value.absent(),
                Value<String> decision = const Value.absent(),
                Value<String?> nextWeekFocus = const Value.absent(),
                Value<DateTime?> decisionAppliedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsCompanion(
                id: id,
                projectId: projectId,
                sprintId: sprintId,
                weekStart: weekStart,
                weekEnd: weekEnd,
                shippedSummary: shippedSummary,
                importantResult: importantResult,
                workedWell: workedWell,
                wasteOrBlocker: wasteOrBlocker,
                decision: decision,
                nextWeekFocus: nextWeekFocus,
                decisionAppliedAt: decisionAppliedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                Value<String?> sprintId = const Value.absent(),
                required DateTime weekStart,
                required DateTime weekEnd,
                Value<String?> shippedSummary = const Value.absent(),
                Value<String?> importantResult = const Value.absent(),
                Value<String?> workedWell = const Value.absent(),
                Value<String?> wasteOrBlocker = const Value.absent(),
                required String decision,
                Value<String?> nextWeekFocus = const Value.absent(),
                Value<DateTime?> decisionAppliedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsCompanion.insert(
                id: id,
                projectId: projectId,
                sprintId: sprintId,
                weekStart: weekStart,
                weekEnd: weekEnd,
                shippedSummary: shippedSummary,
                importantResult: importantResult,
                workedWell: workedWell,
                wasteOrBlocker: wasteOrBlocker,
                decision: decision,
                nextWeekFocus: nextWeekFocus,
                decisionAppliedAt: decisionAppliedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeeklyReviewsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, sprintId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$WeeklyReviewsTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$WeeklyReviewsTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (sprintId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sprintId,
                                referencedTable: $$WeeklyReviewsTableReferences
                                    ._sprintIdTable(db),
                                referencedColumn: $$WeeklyReviewsTableReferences
                                    ._sprintIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeeklyReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyReviewsTable,
      WeeklyReviewRow,
      $$WeeklyReviewsTableFilterComposer,
      $$WeeklyReviewsTableOrderingComposer,
      $$WeeklyReviewsTableAnnotationComposer,
      $$WeeklyReviewsTableCreateCompanionBuilder,
      $$WeeklyReviewsTableUpdateCompanionBuilder,
      (WeeklyReviewRow, $$WeeklyReviewsTableReferences),
      WeeklyReviewRow,
      PrefetchHooks Function({bool projectId, bool sprintId})
    >;
typedef $$NotificationPreferencesTableCreateCompanionBuilder =
    NotificationPreferencesCompanion Function({
      Value<int> id,
      Value<bool> morningEnabled,
      Value<bool> afterWorkEnabled,
      Value<bool> eveningEnabled,
      Value<int> morningMinutes,
      Value<int> afterWorkMinutes,
      Value<int> eveningMinutes,
      Value<String> timeZoneId,
      required DateTime updatedAt,
    });
typedef $$NotificationPreferencesTableUpdateCompanionBuilder =
    NotificationPreferencesCompanion Function({
      Value<int> id,
      Value<bool> morningEnabled,
      Value<bool> afterWorkEnabled,
      Value<bool> eveningEnabled,
      Value<int> morningMinutes,
      Value<int> afterWorkMinutes,
      Value<int> eveningMinutes,
      Value<String> timeZoneId,
      Value<DateTime> updatedAt,
    });

class $$NotificationPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get morningEnabled => $composableBuilder(
    column: $table.morningEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get afterWorkEnabled => $composableBuilder(
    column: $table.afterWorkEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get eveningEnabled => $composableBuilder(
    column: $table.eveningEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get morningMinutes => $composableBuilder(
    column: $table.morningMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get afterWorkMinutes => $composableBuilder(
    column: $table.afterWorkMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get eveningMinutes => $composableBuilder(
    column: $table.eveningMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeZoneId => $composableBuilder(
    column: $table.timeZoneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get morningEnabled => $composableBuilder(
    column: $table.morningEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get afterWorkEnabled => $composableBuilder(
    column: $table.afterWorkEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get eveningEnabled => $composableBuilder(
    column: $table.eveningEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get morningMinutes => $composableBuilder(
    column: $table.morningMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get afterWorkMinutes => $composableBuilder(
    column: $table.afterWorkMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eveningMinutes => $composableBuilder(
    column: $table.eveningMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeZoneId => $composableBuilder(
    column: $table.timeZoneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get morningEnabled => $composableBuilder(
    column: $table.morningEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get afterWorkEnabled => $composableBuilder(
    column: $table.afterWorkEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get eveningEnabled => $composableBuilder(
    column: $table.eveningEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get morningMinutes => $composableBuilder(
    column: $table.morningMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get afterWorkMinutes => $composableBuilder(
    column: $table.afterWorkMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get eveningMinutes => $composableBuilder(
    column: $table.eveningMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeZoneId => $composableBuilder(
    column: $table.timeZoneId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationPreferencesTable,
          NotificationPreferenceRow,
          $$NotificationPreferencesTableFilterComposer,
          $$NotificationPreferencesTableOrderingComposer,
          $$NotificationPreferencesTableAnnotationComposer,
          $$NotificationPreferencesTableCreateCompanionBuilder,
          $$NotificationPreferencesTableUpdateCompanionBuilder,
          (
            NotificationPreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $NotificationPreferencesTable,
              NotificationPreferenceRow
            >,
          ),
          NotificationPreferenceRow,
          PrefetchHooks Function()
        > {
  $$NotificationPreferencesTableTableManager(
    _$AppDatabase db,
    $NotificationPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> morningEnabled = const Value.absent(),
                Value<bool> afterWorkEnabled = const Value.absent(),
                Value<bool> eveningEnabled = const Value.absent(),
                Value<int> morningMinutes = const Value.absent(),
                Value<int> afterWorkMinutes = const Value.absent(),
                Value<int> eveningMinutes = const Value.absent(),
                Value<String> timeZoneId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NotificationPreferencesCompanion(
                id: id,
                morningEnabled: morningEnabled,
                afterWorkEnabled: afterWorkEnabled,
                eveningEnabled: eveningEnabled,
                morningMinutes: morningMinutes,
                afterWorkMinutes: afterWorkMinutes,
                eveningMinutes: eveningMinutes,
                timeZoneId: timeZoneId,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> morningEnabled = const Value.absent(),
                Value<bool> afterWorkEnabled = const Value.absent(),
                Value<bool> eveningEnabled = const Value.absent(),
                Value<int> morningMinutes = const Value.absent(),
                Value<int> afterWorkMinutes = const Value.absent(),
                Value<int> eveningMinutes = const Value.absent(),
                Value<String> timeZoneId = const Value.absent(),
                required DateTime updatedAt,
              }) => NotificationPreferencesCompanion.insert(
                id: id,
                morningEnabled: morningEnabled,
                afterWorkEnabled: afterWorkEnabled,
                eveningEnabled: eveningEnabled,
                morningMinutes: morningMinutes,
                afterWorkMinutes: afterWorkMinutes,
                eveningMinutes: eveningMinutes,
                timeZoneId: timeZoneId,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationPreferencesTable,
      NotificationPreferenceRow,
      $$NotificationPreferencesTableFilterComposer,
      $$NotificationPreferencesTableOrderingComposer,
      $$NotificationPreferencesTableAnnotationComposer,
      $$NotificationPreferencesTableCreateCompanionBuilder,
      $$NotificationPreferencesTableUpdateCompanionBuilder,
      (
        NotificationPreferenceRow,
        BaseReferences<
          _$AppDatabase,
          $NotificationPreferencesTable,
          NotificationPreferenceRow
        >,
      ),
      NotificationPreferenceRow,
      PrefetchHooks Function()
    >;
typedef $$SprintClosuresTableCreateCompanionBuilder =
    SprintClosuresCompanion Function({
      required String id,
      required String sprintId,
      required String decision,
      Value<String?> evidenceSummary,
      Value<String?> nextApproach,
      Value<String?> nextSprintId,
      Value<String?> replacementProjectId,
      required DateTime closedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SprintClosuresTableUpdateCompanionBuilder =
    SprintClosuresCompanion Function({
      Value<String> id,
      Value<String> sprintId,
      Value<String> decision,
      Value<String?> evidenceSummary,
      Value<String?> nextApproach,
      Value<String?> nextSprintId,
      Value<String?> replacementProjectId,
      Value<DateTime> closedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SprintClosuresTableReferences
    extends
        BaseReferences<_$AppDatabase, $SprintClosuresTable, SprintClosureRow> {
  $$SprintClosuresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SprintsTable _sprintIdTable(_$AppDatabase db) =>
      db.sprints.createAlias('sprint_closures__sprint_id__sprints__id');

  $$SprintsTableProcessedTableManager get sprintId {
    final $_column = $_itemColumn<String>('sprint_id')!;

    final manager = $$SprintsTableTableManager(
      $_db,
      $_db.sprints,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sprintIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SprintsTable _nextSprintIdTable(_$AppDatabase db) =>
      db.sprints.createAlias('sprint_closures__next_sprint_id__sprints__id');

  $$SprintsTableProcessedTableManager? get nextSprintId {
    final $_column = $_itemColumn<String>('next_sprint_id');
    if ($_column == null) return null;
    final manager = $$SprintsTableTableManager(
      $_db,
      $_db.sprints,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nextSprintIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProjectsTable _replacementProjectIdTable(_$AppDatabase db) => db
      .projects
      .createAlias('sprint_closures__replacement_project_id__projects__id');

  $$ProjectsTableProcessedTableManager? get replacementProjectId {
    final $_column = $_itemColumn<String>('replacement_project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _replacementProjectIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SprintClosuresTableFilterComposer
    extends Composer<_$AppDatabase, $SprintClosuresTable> {
  $$SprintClosuresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidenceSummary => $composableBuilder(
    column: $table.evidenceSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextApproach => $composableBuilder(
    column: $table.nextApproach,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SprintsTableFilterComposer get sprintId {
    final $$SprintsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableFilterComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SprintsTableFilterComposer get nextSprintId {
    final $$SprintsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextSprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableFilterComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableFilterComposer get replacementProjectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacementProjectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SprintClosuresTableOrderingComposer
    extends Composer<_$AppDatabase, $SprintClosuresTable> {
  $$SprintClosuresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidenceSummary => $composableBuilder(
    column: $table.evidenceSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextApproach => $composableBuilder(
    column: $table.nextApproach,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SprintsTableOrderingComposer get sprintId {
    final $$SprintsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableOrderingComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SprintsTableOrderingComposer get nextSprintId {
    final $$SprintsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextSprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableOrderingComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableOrderingComposer get replacementProjectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacementProjectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SprintClosuresTableAnnotationComposer
    extends Composer<_$AppDatabase, $SprintClosuresTable> {
  $$SprintClosuresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<String> get evidenceSummary => $composableBuilder(
    column: $table.evidenceSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nextApproach => $composableBuilder(
    column: $table.nextApproach,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SprintsTableAnnotationComposer get sprintId {
    final $$SprintsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableAnnotationComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SprintsTableAnnotationComposer get nextSprintId {
    final $$SprintsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextSprintId,
      referencedTable: $db.sprints,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SprintsTableAnnotationComposer(
            $db: $db,
            $table: $db.sprints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableAnnotationComposer get replacementProjectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacementProjectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SprintClosuresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SprintClosuresTable,
          SprintClosureRow,
          $$SprintClosuresTableFilterComposer,
          $$SprintClosuresTableOrderingComposer,
          $$SprintClosuresTableAnnotationComposer,
          $$SprintClosuresTableCreateCompanionBuilder,
          $$SprintClosuresTableUpdateCompanionBuilder,
          (SprintClosureRow, $$SprintClosuresTableReferences),
          SprintClosureRow,
          PrefetchHooks Function({
            bool sprintId,
            bool nextSprintId,
            bool replacementProjectId,
          })
        > {
  $$SprintClosuresTableTableManager(
    _$AppDatabase db,
    $SprintClosuresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SprintClosuresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SprintClosuresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SprintClosuresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sprintId = const Value.absent(),
                Value<String> decision = const Value.absent(),
                Value<String?> evidenceSummary = const Value.absent(),
                Value<String?> nextApproach = const Value.absent(),
                Value<String?> nextSprintId = const Value.absent(),
                Value<String?> replacementProjectId = const Value.absent(),
                Value<DateTime> closedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SprintClosuresCompanion(
                id: id,
                sprintId: sprintId,
                decision: decision,
                evidenceSummary: evidenceSummary,
                nextApproach: nextApproach,
                nextSprintId: nextSprintId,
                replacementProjectId: replacementProjectId,
                closedAt: closedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sprintId,
                required String decision,
                Value<String?> evidenceSummary = const Value.absent(),
                Value<String?> nextApproach = const Value.absent(),
                Value<String?> nextSprintId = const Value.absent(),
                Value<String?> replacementProjectId = const Value.absent(),
                required DateTime closedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SprintClosuresCompanion.insert(
                id: id,
                sprintId: sprintId,
                decision: decision,
                evidenceSummary: evidenceSummary,
                nextApproach: nextApproach,
                nextSprintId: nextSprintId,
                replacementProjectId: replacementProjectId,
                closedAt: closedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SprintClosuresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sprintId = false,
                nextSprintId = false,
                replacementProjectId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sprintId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sprintId,
                                    referencedTable:
                                        $$SprintClosuresTableReferences
                                            ._sprintIdTable(db),
                                    referencedColumn:
                                        $$SprintClosuresTableReferences
                                            ._sprintIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (nextSprintId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.nextSprintId,
                                    referencedTable:
                                        $$SprintClosuresTableReferences
                                            ._nextSprintIdTable(db),
                                    referencedColumn:
                                        $$SprintClosuresTableReferences
                                            ._nextSprintIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (replacementProjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.replacementProjectId,
                                    referencedTable:
                                        $$SprintClosuresTableReferences
                                            ._replacementProjectIdTable(db),
                                    referencedColumn:
                                        $$SprintClosuresTableReferences
                                            ._replacementProjectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SprintClosuresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SprintClosuresTable,
      SprintClosureRow,
      $$SprintClosuresTableFilterComposer,
      $$SprintClosuresTableOrderingComposer,
      $$SprintClosuresTableAnnotationComposer,
      $$SprintClosuresTableCreateCompanionBuilder,
      $$SprintClosuresTableUpdateCompanionBuilder,
      (SprintClosureRow, $$SprintClosuresTableReferences),
      SprintClosureRow,
      PrefetchHooks Function({
        bool sprintId,
        bool nextSprintId,
        bool replacementProjectId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$IdeasTableTableManager get ideas =>
      $$IdeasTableTableManager(_db, _db.ideas);
  $$RestartCapsulesTableTableManager get restartCapsules =>
      $$RestartCapsulesTableTableManager(_db, _db.restartCapsules);
  $$DailyCheckInsTableTableManager get dailyCheckIns =>
      $$DailyCheckInsTableTableManager(_db, _db.dailyCheckIns);
  $$SprintsTableTableManager get sprints =>
      $$SprintsTableTableManager(_db, _db.sprints);
  $$DailyPlansTableTableManager get dailyPlans =>
      $$DailyPlansTableTableManager(_db, _db.dailyPlans);
  $$DailyActionsTableTableManager get dailyActions =>
      $$DailyActionsTableTableManager(_db, _db.dailyActions);
  $$ShipRecordsTableTableManager get shipRecords =>
      $$ShipRecordsTableTableManager(_db, _db.shipRecords);
  $$GuideDocumentsTableTableManager get guideDocuments =>
      $$GuideDocumentsTableTableManager(_db, _db.guideDocuments);
  $$PdfBookmarksTableTableManager get pdfBookmarks =>
      $$PdfBookmarksTableTableManager(_db, _db.pdfBookmarks);
  $$PdfNotesTableTableManager get pdfNotes =>
      $$PdfNotesTableTableManager(_db, _db.pdfNotes);
  $$MetricEntriesTableTableManager get metricEntries =>
      $$MetricEntriesTableTableManager(_db, _db.metricEntries);
  $$WeeklyReviewsTableTableManager get weeklyReviews =>
      $$WeeklyReviewsTableTableManager(_db, _db.weeklyReviews);
  $$NotificationPreferencesTableTableManager get notificationPreferences =>
      $$NotificationPreferencesTableTableManager(
        _db,
        _db.notificationPreferences,
      );
  $$SprintClosuresTableTableManager get sprintClosures =>
      $$SprintClosuresTableTableManager(_db, _db.sprintClosures);
}
