// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetTaskCollection on Isar {
  IsarCollection<Task> get tasks => this.collection();
}

const TaskSchema = CollectionSchema(
  name: r'Task',
  id: 2998003626758701373,
  properties: {
    r'checked': PropertySchema(
      id: 0,
      name: r'checked',
      type: IsarType.bool,
    ),
    r'created': PropertySchema(
      id: 1,
      name: r'created',
      type: IsarType.dateTime,
    ),
    r'dateTimeReminders': PropertySchema(
      id: 2,
      name: r'dateTimeReminders',
      type: IsarType.objectList,
      target: r'DateTimeReminder',
    ),
    r'deadline': PropertySchema(
      id: 3,
      name: r'deadline',
      type: IsarType.dateTime,
    ),
    r'deadlineDateReminder': PropertySchema(
      id: 4,
      name: r'deadlineDateReminder',
      type: IsarType.object,
      target: r'DeadlineDateReminder',
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'edited': PropertySchema(
      id: 6,
      name: r'edited',
      type: IsarType.dateTime,
    ),
    r'estimation': PropertySchema(
      id: 7,
      name: r'estimation',
      type: IsarType.dateTime,
    ),
    r'interval': PropertySchema(
      id: 8,
      name: r'interval',
      type: IsarType.byte,
      enumMap: _TaskintervalEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 10,
      name: r'priority',
      type: IsarType.long,
    ),
    r'recurring': PropertySchema(
      id: 11,
      name: r'recurring',
      type: IsarType.bool,
    ),
    r'recurringDays': PropertySchema(
      id: 12,
      name: r'recurringDays',
      type: IsarType.object,
      target: r'RecurringDays',
    ),
    r'recurringIntervalCount': PropertySchema(
      id: 13,
      name: r'recurringIntervalCount',
      type: IsarType.long,
    ),
    r'recurringStartDate': PropertySchema(
      id: 14,
      name: r'recurringStartDate',
      type: IsarType.dateTime,
    ),
    r'spent': PropertySchema(
      id: 15,
      name: r'spent',
      type: IsarType.dateTime,
    ),
    r'startDateReminder': PropertySchema(
      id: 16,
      name: r'startDateReminder',
      type: IsarType.object,
      target: r'StartDateReminder',
    ),
    r'subTasks': PropertySchema(
      id: 17,
      name: r'subTasks',
      type: IsarType.objectList,
      target: r'SubTask',
    )
  },
  estimateSize: _taskEstimateSize,
  serialize: _taskSerialize,
  deserialize: _taskDeserialize,
  deserializeProp: _taskDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'DateTimeReminder': DateTimeReminderSchema,
    r'SubTask': SubTaskSchema,
    r'RecurringDays': RecurringDaysSchema,
    r'StartDateReminder': StartDateReminderSchema,
    r'DeadlineDateReminder': DeadlineDateReminderSchema
  },
  getId: _taskGetId,
  getLinks: _taskGetLinks,
  attach: _taskAttach,
  version: '3.0.5',
);

int _taskEstimateSize(
  Task object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dateTimeReminders.length * 3;
  {
    final offsets = allOffsets[DateTimeReminder]!;
    for (var i = 0; i < object.dateTimeReminders.length; i++) {
      final value = object.dateTimeReminders[i];
      bytesCount +=
          DateTimeReminderSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 +
      DeadlineDateReminderSchema.estimateSize(object.deadlineDateReminder,
          allOffsets[DeadlineDateReminder]!, allOffsets);
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 +
      RecurringDaysSchema.estimateSize(
          object.recurringDays, allOffsets[RecurringDays]!, allOffsets);
  bytesCount += 3 +
      StartDateReminderSchema.estimateSize(
          object.startDateReminder, allOffsets[StartDateReminder]!, allOffsets);
  bytesCount += 3 + object.subTasks.length * 3;
  {
    final offsets = allOffsets[SubTask]!;
    for (var i = 0; i < object.subTasks.length; i++) {
      final value = object.subTasks[i];
      bytesCount += SubTaskSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _taskSerialize(
  Task object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.checked);
  writer.writeDateTime(offsets[1], object.created);
  writer.writeObjectList<DateTimeReminder>(
    offsets[2],
    allOffsets,
    DateTimeReminderSchema.serialize,
    object.dateTimeReminders,
  );
  writer.writeDateTime(offsets[3], object.deadline);
  writer.writeObject<DeadlineDateReminder>(
    offsets[4],
    allOffsets,
    DeadlineDateReminderSchema.serialize,
    object.deadlineDateReminder,
  );
  writer.writeString(offsets[5], object.description);
  writer.writeDateTime(offsets[6], object.edited);
  writer.writeDateTime(offsets[7], object.estimation);
  writer.writeByte(offsets[8], object.interval.index);
  writer.writeString(offsets[9], object.name);
  writer.writeLong(offsets[10], object.priority);
  writer.writeBool(offsets[11], object.recurring);
  writer.writeObject<RecurringDays>(
    offsets[12],
    allOffsets,
    RecurringDaysSchema.serialize,
    object.recurringDays,
  );
  writer.writeLong(offsets[13], object.recurringIntervalCount);
  writer.writeDateTime(offsets[14], object.recurringStartDate);
  writer.writeDateTime(offsets[15], object.spent);
  writer.writeObject<StartDateReminder>(
    offsets[16],
    allOffsets,
    StartDateReminderSchema.serialize,
    object.startDateReminder,
  );
  writer.writeObjectList<SubTask>(
    offsets[17],
    allOffsets,
    SubTaskSchema.serialize,
    object.subTasks,
  );
}

Task _taskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Task(
    created: reader.readDateTime(offsets[1]),
    dateTimeReminders: reader.readObjectList<DateTimeReminder>(
          offsets[2],
          DateTimeReminderSchema.deserialize,
          allOffsets,
          DateTimeReminder(),
        ) ??
        [],
    deadline: reader.readDateTimeOrNull(offsets[3]),
    description: reader.readString(offsets[5]),
    edited: reader.readDateTime(offsets[6]),
    estimation: reader.readDateTimeOrNull(offsets[7]),
    name: reader.readString(offsets[9]),
    priority: reader.readLong(offsets[10]),
    recurringDays: reader.readObjectOrNull<RecurringDays>(
          offsets[12],
          RecurringDaysSchema.deserialize,
          allOffsets,
        ) ??
        RecurringDays(),
    spent: reader.readDateTimeOrNull(offsets[15]),
    subTasks: reader.readObjectList<SubTask>(
          offsets[17],
          SubTaskSchema.deserialize,
          allOffsets,
          SubTask(),
        ) ??
        [],
  );
  object.checked = reader.readBool(offsets[0]);
  object.deadlineDateReminder = reader.readObjectOrNull<DeadlineDateReminder>(
        offsets[4],
        DeadlineDateReminderSchema.deserialize,
        allOffsets,
      ) ??
      DeadlineDateReminder();
  object.id = id;
  object.interval =
      _TaskintervalValueEnumMap[reader.readByteOrNull(offsets[8])] ??
          RecurringInterval.minute;
  object.recurring = reader.readBool(offsets[11]);
  object.recurringIntervalCount = reader.readLong(offsets[13]);
  object.recurringStartDate = reader.readDateTimeOrNull(offsets[14]);
  object.startDateReminder = reader.readObjectOrNull<StartDateReminder>(
        offsets[16],
        StartDateReminderSchema.deserialize,
        allOffsets,
      ) ??
      StartDateReminder();
  return object;
}

P _taskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readObjectList<DateTimeReminder>(
            offset,
            DateTimeReminderSchema.deserialize,
            allOffsets,
            DateTimeReminder(),
          ) ??
          []) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<DeadlineDateReminder>(
            offset,
            DeadlineDateReminderSchema.deserialize,
            allOffsets,
          ) ??
          DeadlineDateReminder()) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (_TaskintervalValueEnumMap[reader.readByteOrNull(offset)] ??
          RecurringInterval.minute) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readObjectOrNull<RecurringDays>(
            offset,
            RecurringDaysSchema.deserialize,
            allOffsets,
          ) ??
          RecurringDays()) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 15:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 16:
      return (reader.readObjectOrNull<StartDateReminder>(
            offset,
            StartDateReminderSchema.deserialize,
            allOffsets,
          ) ??
          StartDateReminder()) as P;
    case 17:
      return (reader.readObjectList<SubTask>(
            offset,
            SubTaskSchema.deserialize,
            allOffsets,
            SubTask(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TaskintervalEnumValueMap = {
  'minute': 0,
  'hour': 1,
  'day': 2,
  'week': 3,
  'month': 4,
  'year': 5,
};
const _TaskintervalValueEnumMap = {
  0: RecurringInterval.minute,
  1: RecurringInterval.hour,
  2: RecurringInterval.day,
  3: RecurringInterval.week,
  4: RecurringInterval.month,
  5: RecurringInterval.year,
};

Id _taskGetId(Task object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskGetLinks(Task object) {
  return [];
}

void _taskAttach(IsarCollection<dynamic> col, Id id, Task object) {
  object.id = id;
}

extension TaskQueryWhereSort on QueryBuilder<Task, Task, QWhere> {
  QueryBuilder<Task, Task, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TaskQueryWhere on QueryBuilder<Task, Task, QWhereClause> {
  QueryBuilder<Task, Task, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Task, Task, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskQueryFilter on QueryBuilder<Task, Task, QFilterCondition> {
  QueryBuilder<Task, Task, QAfterFilterCondition> checkedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checked',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> createdEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> createdGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> createdLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> createdBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      dateTimeRemindersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dateTimeReminders',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> dateTimeRemindersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dateTimeReminders',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      dateTimeRemindersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dateTimeReminders',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      dateTimeRemindersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dateTimeReminders',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      dateTimeRemindersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dateTimeReminders',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      dateTimeRemindersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dateTimeReminders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> editedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edited',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> editedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'edited',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> editedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'edited',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> editedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'edited',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> estimationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'estimation',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> estimationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'estimation',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> estimationEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimation',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> estimationGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimation',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> estimationLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimation',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> estimationBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> intervalEqualTo(
      RecurringInterval value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> intervalGreaterThan(
    RecurringInterval value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> intervalLessThan(
    RecurringInterval value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> intervalBetween(
    RecurringInterval lower,
    RecurringInterval upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> priorityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> priorityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> priorityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> priorityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurring',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringIntervalCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringIntervalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      recurringIntervalCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringIntervalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      recurringIntervalCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringIntervalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringIntervalCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringIntervalCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringStartDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringStartDate',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition>
      recurringStartDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringStartDate',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringStartDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringStartDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringStartDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringStartDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringStartDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> spentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spent',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> spentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spent',
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> spentEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spent',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> spentGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spent',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> spentLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spent',
        value: value,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> spentBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TaskQueryObject on QueryBuilder<Task, Task, QFilterCondition> {
  QueryBuilder<Task, Task, QAfterFilterCondition> dateTimeRemindersElement(
      FilterQuery<DateTimeReminder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dateTimeReminders');
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> deadlineDateReminder(
      FilterQuery<DeadlineDateReminder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'deadlineDateReminder');
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> recurringDays(
      FilterQuery<RecurringDays> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'recurringDays');
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> startDateReminder(
      FilterQuery<StartDateReminder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'startDateReminder');
    });
  }

  QueryBuilder<Task, Task, QAfterFilterCondition> subTasksElement(
      FilterQuery<SubTask> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'subTasks');
    });
  }
}

extension TaskQueryLinks on QueryBuilder<Task, Task, QFilterCondition> {}

extension TaskQuerySortBy on QueryBuilder<Task, Task, QSortBy> {
  QueryBuilder<Task, Task, QAfterSortBy> sortByChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEstimation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimation', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByEstimationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimation', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRecurring() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurring', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRecurringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurring', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRecurringIntervalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringIntervalCount', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRecurringIntervalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringIntervalCount', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRecurringStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringStartDate', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortByRecurringStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringStartDate', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortBySpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spent', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> sortBySpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spent', Sort.desc);
    });
  }
}

extension TaskQuerySortThenBy on QueryBuilder<Task, Task, QSortThenBy> {
  QueryBuilder<Task, Task, QAfterSortBy> thenByChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEstimation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimation', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByEstimationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimation', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRecurring() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurring', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRecurringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurring', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRecurringIntervalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringIntervalCount', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRecurringIntervalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringIntervalCount', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRecurringStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringStartDate', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenByRecurringStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringStartDate', Sort.desc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenBySpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spent', Sort.asc);
    });
  }

  QueryBuilder<Task, Task, QAfterSortBy> thenBySpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spent', Sort.desc);
    });
  }
}

extension TaskQueryWhereDistinct on QueryBuilder<Task, Task, QDistinct> {
  QueryBuilder<Task, Task, QDistinct> distinctByChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checked');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deadline');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edited');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByEstimation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimation');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interval');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByRecurring() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurring');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByRecurringIntervalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringIntervalCount');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctByRecurringStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringStartDate');
    });
  }

  QueryBuilder<Task, Task, QDistinct> distinctBySpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spent');
    });
  }
}

extension TaskQueryProperty on QueryBuilder<Task, Task, QQueryProperty> {
  QueryBuilder<Task, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> checkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checked');
    });
  }

  QueryBuilder<Task, DateTime, QQueryOperations> createdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created');
    });
  }

  QueryBuilder<Task, List<DateTimeReminder>, QQueryOperations>
      dateTimeRemindersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTimeReminders');
    });
  }

  QueryBuilder<Task, DateTime?, QQueryOperations> deadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deadline');
    });
  }

  QueryBuilder<Task, DeadlineDateReminder, QQueryOperations>
      deadlineDateReminderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deadlineDateReminder');
    });
  }

  QueryBuilder<Task, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Task, DateTime, QQueryOperations> editedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edited');
    });
  }

  QueryBuilder<Task, DateTime?, QQueryOperations> estimationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimation');
    });
  }

  QueryBuilder<Task, RecurringInterval, QQueryOperations> intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interval');
    });
  }

  QueryBuilder<Task, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Task, int, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<Task, bool, QQueryOperations> recurringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurring');
    });
  }

  QueryBuilder<Task, RecurringDays, QQueryOperations> recurringDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringDays');
    });
  }

  QueryBuilder<Task, int, QQueryOperations> recurringIntervalCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringIntervalCount');
    });
  }

  QueryBuilder<Task, DateTime?, QQueryOperations> recurringStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringStartDate');
    });
  }

  QueryBuilder<Task, DateTime?, QQueryOperations> spentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spent');
    });
  }

  QueryBuilder<Task, StartDateReminder, QQueryOperations>
      startDateReminderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDateReminder');
    });
  }

  QueryBuilder<Task, List<SubTask>, QQueryOperations> subTasksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subTasks');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const SubTaskSchema = Schema(
  name: r'SubTask',
  id: -8959948632899078842,
  properties: {
    r'checked': PropertySchema(
      id: 0,
      name: r'checked',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _subTaskEstimateSize,
  serialize: _subTaskSerialize,
  deserialize: _subTaskDeserialize,
  deserializeProp: _subTaskDeserializeProp,
);

int _subTaskEstimateSize(
  SubTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _subTaskSerialize(
  SubTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.checked);
  writer.writeString(offsets[1], object.name);
}

SubTask _subTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubTask();
  object.checked = reader.readBool(offsets[0]);
  object.name = reader.readStringOrNull(offsets[1]);
  return object;
}

P _subTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SubTaskQueryFilter
    on QueryBuilder<SubTask, SubTask, QFilterCondition> {
  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> checkedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checked',
        value: value,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SubTask, SubTask, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension SubTaskQueryObject
    on QueryBuilder<SubTask, SubTask, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const RecurringDaysSchema = Schema(
  name: r'RecurringDays',
  id: -2315156000938318056,
  properties: {
    r'recurringFriday': PropertySchema(
      id: 0,
      name: r'recurringFriday',
      type: IsarType.bool,
    ),
    r'recurringMonday': PropertySchema(
      id: 1,
      name: r'recurringMonday',
      type: IsarType.bool,
    ),
    r'recurringSaturday': PropertySchema(
      id: 2,
      name: r'recurringSaturday',
      type: IsarType.bool,
    ),
    r'recurringSunday': PropertySchema(
      id: 3,
      name: r'recurringSunday',
      type: IsarType.bool,
    ),
    r'recurringThursday': PropertySchema(
      id: 4,
      name: r'recurringThursday',
      type: IsarType.bool,
    ),
    r'recurringTuesday': PropertySchema(
      id: 5,
      name: r'recurringTuesday',
      type: IsarType.bool,
    ),
    r'recurringWednesday': PropertySchema(
      id: 6,
      name: r'recurringWednesday',
      type: IsarType.bool,
    )
  },
  estimateSize: _recurringDaysEstimateSize,
  serialize: _recurringDaysSerialize,
  deserialize: _recurringDaysDeserialize,
  deserializeProp: _recurringDaysDeserializeProp,
);

int _recurringDaysEstimateSize(
  RecurringDays object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _recurringDaysSerialize(
  RecurringDays object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.recurringFriday);
  writer.writeBool(offsets[1], object.recurringMonday);
  writer.writeBool(offsets[2], object.recurringSaturday);
  writer.writeBool(offsets[3], object.recurringSunday);
  writer.writeBool(offsets[4], object.recurringThursday);
  writer.writeBool(offsets[5], object.recurringTuesday);
  writer.writeBool(offsets[6], object.recurringWednesday);
}

RecurringDays _recurringDaysDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurringDays();
  object.recurringFriday = reader.readBool(offsets[0]);
  object.recurringMonday = reader.readBool(offsets[1]);
  object.recurringSaturday = reader.readBool(offsets[2]);
  object.recurringSunday = reader.readBool(offsets[3]);
  object.recurringThursday = reader.readBool(offsets[4]);
  object.recurringTuesday = reader.readBool(offsets[5]);
  object.recurringWednesday = reader.readBool(offsets[6]);
  return object;
}

P _recurringDaysDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RecurringDaysQueryFilter
    on QueryBuilder<RecurringDays, RecurringDays, QFilterCondition> {
  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringFridayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringFriday',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringMondayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringMonday',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringSaturdayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringSaturday',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringSundayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringSunday',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringThursdayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringThursday',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringTuesdayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringTuesday',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringDays, RecurringDays, QAfterFilterCondition>
      recurringWednesdayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringWednesday',
        value: value,
      ));
    });
  }
}

extension RecurringDaysQueryObject
    on QueryBuilder<RecurringDays, RecurringDays, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const DateTimeReminderSchema = Schema(
  name: r'DateTimeReminder',
  id: 2493716622400866042,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'notificationId': PropertySchema(
      id: 1,
      name: r'notificationId',
      type: IsarType.long,
    )
  },
  estimateSize: _dateTimeReminderEstimateSize,
  serialize: _dateTimeReminderSerialize,
  deserialize: _dateTimeReminderDeserialize,
  deserializeProp: _dateTimeReminderDeserializeProp,
);

int _dateTimeReminderEstimateSize(
  DateTimeReminder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dateTimeReminderSerialize(
  DateTimeReminder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeLong(offsets[1], object.notificationId);
}

DateTimeReminder _dateTimeReminderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DateTimeReminder();
  object.dateTime = reader.readDateTimeOrNull(offsets[0]);
  object.notificationId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _dateTimeReminderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DateTimeReminderQueryFilter
    on QueryBuilder<DateTimeReminder, DateTimeReminder, QFilterCondition> {
  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      dateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      dateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      dateTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      dateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      notificationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      notificationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      notificationIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      notificationIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      notificationIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<DateTimeReminder, DateTimeReminder, QAfterFilterCondition>
      notificationIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DateTimeReminderQueryObject
    on QueryBuilder<DateTimeReminder, DateTimeReminder, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const StartDateReminderSchema = Schema(
  name: r'StartDateReminder',
  id: -2042481607383795564,
  properties: {
    r'enabled': PropertySchema(
      id: 0,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'notificationId': PropertySchema(
      id: 1,
      name: r'notificationId',
      type: IsarType.long,
    )
  },
  estimateSize: _startDateReminderEstimateSize,
  serialize: _startDateReminderSerialize,
  deserialize: _startDateReminderDeserialize,
  deserializeProp: _startDateReminderDeserializeProp,
);

int _startDateReminderEstimateSize(
  StartDateReminder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _startDateReminderSerialize(
  StartDateReminder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeLong(offsets[1], object.notificationId);
}

StartDateReminder _startDateReminderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StartDateReminder();
  object.enabled = reader.readBool(offsets[0]);
  object.notificationId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _startDateReminderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension StartDateReminderQueryFilter
    on QueryBuilder<StartDateReminder, StartDateReminder, QFilterCondition> {
  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      enabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      notificationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      notificationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      notificationIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      notificationIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      notificationIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<StartDateReminder, StartDateReminder, QAfterFilterCondition>
      notificationIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StartDateReminderQueryObject
    on QueryBuilder<StartDateReminder, StartDateReminder, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const DeadlineDateReminderSchema = Schema(
  name: r'DeadlineDateReminder',
  id: 8473797916135221178,
  properties: {
    r'enabled': PropertySchema(
      id: 0,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'notificationId': PropertySchema(
      id: 1,
      name: r'notificationId',
      type: IsarType.long,
    )
  },
  estimateSize: _deadlineDateReminderEstimateSize,
  serialize: _deadlineDateReminderSerialize,
  deserialize: _deadlineDateReminderDeserialize,
  deserializeProp: _deadlineDateReminderDeserializeProp,
);

int _deadlineDateReminderEstimateSize(
  DeadlineDateReminder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _deadlineDateReminderSerialize(
  DeadlineDateReminder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeLong(offsets[1], object.notificationId);
}

DeadlineDateReminder _deadlineDateReminderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeadlineDateReminder();
  object.enabled = reader.readBool(offsets[0]);
  object.notificationId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _deadlineDateReminderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DeadlineDateReminderQueryFilter on QueryBuilder<DeadlineDateReminder,
    DeadlineDateReminder, QFilterCondition> {
  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> enabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> notificationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> notificationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> notificationIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> notificationIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> notificationIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<DeadlineDateReminder, DeadlineDateReminder,
      QAfterFilterCondition> notificationIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeadlineDateReminderQueryObject on QueryBuilder<DeadlineDateReminder,
    DeadlineDateReminder, QFilterCondition> {}
