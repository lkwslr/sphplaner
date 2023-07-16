// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertretung.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVertretungCollection on Isar {
  IsarCollection<Vertretung> get vertretungs => this.collection();
}

const VertretungSchema = CollectionSchema(
  name: r'Vertretung',
  id: -3664050377336799535,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.string,
    ),
    r'dayOfWeek': PropertySchema(
      id: 1,
      name: r'dayOfWeek',
      type: IsarType.long,
    ),
    r'hour': PropertySchema(
      id: 2,
      name: r'hour',
      type: IsarType.long,
    ),
    r'note': PropertySchema(
      id: 3,
      name: r'note',
      type: IsarType.string,
    ),
    r'room': PropertySchema(
      id: 4,
      name: r'room',
      type: IsarType.string,
    ),
    r'teacher': PropertySchema(
      id: 5,
      name: r'teacher',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 6,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _vertretungEstimateSize,
  serialize: _vertretungSerialize,
  deserialize: _vertretungDeserialize,
  deserializeProp: _vertretungDeserializeProp,
  idName: r'id',
  indexes: {
    r'date_dayOfWeek_hour': IndexSchema(
      id: 2896883763141730327,
      name: r'date_dayOfWeek_hour',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'dayOfWeek',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'hour',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'subject': LinkSchema(
      id: -7159617878317990325,
      name: r'subject',
      target: r'Subject',
      single: true,
    ),
    r'user': LinkSchema(
      id: -2474590537616143110,
      name: r'user',
      target: r'User',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _vertretungGetId,
  getLinks: _vertretungGetLinks,
  attach: _vertretungAttach,
  version: '3.1.0+1',
);

int _vertretungEstimateSize(
  Vertretung object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.date;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.room;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.teacher;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _vertretungSerialize(
  Vertretung object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.date);
  writer.writeLong(offsets[1], object.dayOfWeek);
  writer.writeLong(offsets[2], object.hour);
  writer.writeString(offsets[3], object.note);
  writer.writeString(offsets[4], object.room);
  writer.writeString(offsets[5], object.teacher);
  writer.writeString(offsets[6], object.type);
}

Vertretung _vertretungDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Vertretung();
  object.date = reader.readStringOrNull(offsets[0]);
  object.dayOfWeek = reader.readLongOrNull(offsets[1]);
  object.hour = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.note = reader.readStringOrNull(offsets[3]);
  object.room = reader.readStringOrNull(offsets[4]);
  object.teacher = reader.readStringOrNull(offsets[5]);
  object.type = reader.readStringOrNull(offsets[6]);
  return object;
}

P _vertretungDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vertretungGetId(Vertretung object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vertretungGetLinks(Vertretung object) {
  return [object.subject, object.user];
}

void _vertretungAttach(IsarCollection<dynamic> col, Id id, Vertretung object) {
  object.id = id;
  object.subject.attach(col, col.isar.collection<Subject>(), r'subject', id);
  object.user.attach(col, col.isar.collection<User>(), r'user', id);
}

extension VertretungByIndex on IsarCollection<Vertretung> {
  Future<Vertretung?> getByDateDayOfWeekHour(
      String? date, int? dayOfWeek, int? hour) {
    return getByIndex(r'date_dayOfWeek_hour', [date, dayOfWeek, hour]);
  }

  Vertretung? getByDateDayOfWeekHourSync(
      String? date, int? dayOfWeek, int? hour) {
    return getByIndexSync(r'date_dayOfWeek_hour', [date, dayOfWeek, hour]);
  }

  Future<bool> deleteByDateDayOfWeekHour(
      String? date, int? dayOfWeek, int? hour) {
    return deleteByIndex(r'date_dayOfWeek_hour', [date, dayOfWeek, hour]);
  }

  bool deleteByDateDayOfWeekHourSync(String? date, int? dayOfWeek, int? hour) {
    return deleteByIndexSync(r'date_dayOfWeek_hour', [date, dayOfWeek, hour]);
  }

  Future<List<Vertretung?>> getAllByDateDayOfWeekHour(List<String?> dateValues,
      List<int?> dayOfWeekValues, List<int?> hourValues) {
    final len = dateValues.length;
    assert(dayOfWeekValues.length == len && hourValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([dateValues[i], dayOfWeekValues[i], hourValues[i]]);
    }

    return getAllByIndex(r'date_dayOfWeek_hour', values);
  }

  List<Vertretung?> getAllByDateDayOfWeekHourSync(List<String?> dateValues,
      List<int?> dayOfWeekValues, List<int?> hourValues) {
    final len = dateValues.length;
    assert(dayOfWeekValues.length == len && hourValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([dateValues[i], dayOfWeekValues[i], hourValues[i]]);
    }

    return getAllByIndexSync(r'date_dayOfWeek_hour', values);
  }

  Future<int> deleteAllByDateDayOfWeekHour(List<String?> dateValues,
      List<int?> dayOfWeekValues, List<int?> hourValues) {
    final len = dateValues.length;
    assert(dayOfWeekValues.length == len && hourValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([dateValues[i], dayOfWeekValues[i], hourValues[i]]);
    }

    return deleteAllByIndex(r'date_dayOfWeek_hour', values);
  }

  int deleteAllByDateDayOfWeekHourSync(List<String?> dateValues,
      List<int?> dayOfWeekValues, List<int?> hourValues) {
    final len = dateValues.length;
    assert(dayOfWeekValues.length == len && hourValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([dateValues[i], dayOfWeekValues[i], hourValues[i]]);
    }

    return deleteAllByIndexSync(r'date_dayOfWeek_hour', values);
  }

  Future<Id> putByDateDayOfWeekHour(Vertretung object) {
    return putByIndex(r'date_dayOfWeek_hour', object);
  }

  Id putByDateDayOfWeekHourSync(Vertretung object, {bool saveLinks = true}) {
    return putByIndexSync(r'date_dayOfWeek_hour', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDateDayOfWeekHour(List<Vertretung> objects) {
    return putAllByIndex(r'date_dayOfWeek_hour', objects);
  }

  List<Id> putAllByDateDayOfWeekHourSync(List<Vertretung> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date_dayOfWeek_hour', objects,
        saveLinks: saveLinks);
  }
}

extension VertretungQueryWhereSort
    on QueryBuilder<Vertretung, Vertretung, QWhere> {
  QueryBuilder<Vertretung, Vertretung, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VertretungQueryWhere
    on QueryBuilder<Vertretung, Vertretung, QWhereClause> {
  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause> idBetween(
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

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateIsNullAnyDayOfWeekHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date_dayOfWeek_hour',
        value: [null],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateIsNotNullAnyDayOfWeekHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToAnyDayOfWeekHour(String? date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date_dayOfWeek_hour',
        value: [date],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateNotEqualToAnyDayOfWeekHour(String? date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToDayOfWeekIsNullAnyHour(String? date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date_dayOfWeek_hour',
        value: [date, null],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToDayOfWeekIsNotNullAnyHour(String? date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, null],
        includeLower: false,
        upper: [
          date,
        ],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToAnyHour(String? date, int? dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date_dayOfWeek_hour',
        value: [date, dayOfWeek],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToDayOfWeekNotEqualToAnyHour(String? date, int? dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date],
              upper: [date, dayOfWeek],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date, dayOfWeek],
              includeLower: false,
              upper: [date],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date, dayOfWeek],
              includeLower: false,
              upper: [date],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date],
              upper: [date, dayOfWeek],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToDayOfWeekGreaterThanAnyHour(
    String? date,
    int? dayOfWeek, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, dayOfWeek],
        includeLower: include,
        upper: [date],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToDayOfWeekLessThanAnyHour(
    String? date,
    int? dayOfWeek, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date],
        upper: [date, dayOfWeek],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateEqualToDayOfWeekBetweenAnyHour(
    String? date,
    int? lowerDayOfWeek,
    int? upperDayOfWeek, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, lowerDayOfWeek],
        includeLower: includeLower,
        upper: [date, upperDayOfWeek],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToHourIsNull(String? date, int? dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date_dayOfWeek_hour',
        value: [date, dayOfWeek, null],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToHourIsNotNull(String? date, int? dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, dayOfWeek, null],
        includeLower: false,
        upper: [
          date,
          dayOfWeek,
        ],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekHourEqualTo(String? date, int? dayOfWeek, int? hour) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date_dayOfWeek_hour',
        value: [date, dayOfWeek, hour],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToHourNotEqualTo(
          String? date, int? dayOfWeek, int? hour) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date, dayOfWeek],
              upper: [date, dayOfWeek, hour],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date, dayOfWeek, hour],
              includeLower: false,
              upper: [date, dayOfWeek],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date, dayOfWeek, hour],
              includeLower: false,
              upper: [date, dayOfWeek],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date_dayOfWeek_hour',
              lower: [date, dayOfWeek],
              upper: [date, dayOfWeek, hour],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToHourGreaterThan(
    String? date,
    int? dayOfWeek,
    int? hour, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, dayOfWeek, hour],
        includeLower: include,
        upper: [date, dayOfWeek],
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToHourLessThan(
    String? date,
    int? dayOfWeek,
    int? hour, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, dayOfWeek],
        upper: [date, dayOfWeek, hour],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterWhereClause>
      dateDayOfWeekEqualToHourBetween(
    String? date,
    int? dayOfWeek,
    int? lowerHour,
    int? upperHour, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date_dayOfWeek_hour',
        lower: [date, dayOfWeek, lowerHour],
        includeLower: includeLower,
        upper: [date, dayOfWeek, upperHour],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VertretungQueryFilter
    on QueryBuilder<Vertretung, Vertretung, QFilterCondition> {
  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      dayOfWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayOfWeek',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      dayOfWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayOfWeek',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dayOfWeekEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      dayOfWeekGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dayOfWeekLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> dayOfWeekBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hourIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hour',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hourIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hour',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hourEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hourGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hourLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hourBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'room',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'room',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'room',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'room',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'room',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> roomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'room',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teacher',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      teacherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teacher',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      teacherGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teacher',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teacher',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> teacherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teacher',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      teacherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teacher',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension VertretungQueryObject
    on QueryBuilder<Vertretung, Vertretung, QFilterCondition> {}

extension VertretungQueryLinks
    on QueryBuilder<Vertretung, Vertretung, QFilterCondition> {
  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> subject(
      FilterQuery<Subject> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subject');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> subjectIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subject', 0, true, 0, true);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> user(
      FilterQuery<User> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }
}

extension VertretungQuerySortBy
    on QueryBuilder<Vertretung, Vertretung, QSortBy> {
  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByTeacher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teacher', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByTeacherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teacher', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension VertretungQuerySortThenBy
    on QueryBuilder<Vertretung, Vertretung, QSortThenBy> {
  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hour', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByTeacher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teacher', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByTeacherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teacher', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension VertretungQueryWhereDistinct
    on QueryBuilder<Vertretung, Vertretung, QDistinct> {
  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOfWeek');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hour');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByRoom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'room', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByTeacher(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teacher', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension VertretungQueryProperty
    on QueryBuilder<Vertretung, Vertretung, QQueryProperty> {
  QueryBuilder<Vertretung, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Vertretung, int?, QQueryOperations> dayOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOfWeek');
    });
  }

  QueryBuilder<Vertretung, int?, QQueryOperations> hourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hour');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'room');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> teacherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teacher');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
