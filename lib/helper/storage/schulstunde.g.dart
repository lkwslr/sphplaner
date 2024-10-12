// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schulstunde.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSchulstundeCollection on Isar {
  IsarCollection<Schulstunde> get schulstundes => this.collection();
}

const SchulstundeSchema = CollectionSchema(
  name: r'Schulstunde',
  id: -8746364280638709370,
  properties: {
    r'raum': PropertySchema(
      id: 0,
      name: r'raum',
      type: IsarType.string,
    ),
    r'stunde': PropertySchema(
      id: 1,
      name: r'stunde',
      type: IsarType.long,
    ),
    r'synced': PropertySchema(
      id: 2,
      name: r'synced',
      type: IsarType.bool,
    ),
    r'wochentag': PropertySchema(
      id: 3,
      name: r'wochentag',
      type: IsarType.long,
    )
  },
  estimateSize: _schulstundeEstimateSize,
  serialize: _schulstundeSerialize,
  deserialize: _schulstundeDeserialize,
  deserializeProp: _schulstundeDeserializeProp,
  idName: r'id',
  indexes: {
    r'wochentag_stunde': IndexSchema(
      id: -4309486715543224863,
      name: r'wochentag_stunde',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'wochentag',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'stunde',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'fach': LinkSchema(
      id: -4649081637623691187,
      name: r'fach',
      target: r'Lerngruppe',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _schulstundeGetId,
  getLinks: _schulstundeGetLinks,
  attach: _schulstundeAttach,
  version: '3.1.8',
);

int _schulstundeEstimateSize(
  Schulstunde object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.raum;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _schulstundeSerialize(
  Schulstunde object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.raum);
  writer.writeLong(offsets[1], object.stunde);
  writer.writeBool(offsets[2], object.synced);
  writer.writeLong(offsets[3], object.wochentag);
}

Schulstunde _schulstundeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Schulstunde();
  object.id = id;
  object.raum = reader.readStringOrNull(offsets[0]);
  object.stunde = reader.readLongOrNull(offsets[1]);
  object.synced = reader.readBool(offsets[2]);
  object.wochentag = reader.readLongOrNull(offsets[3]);
  return object;
}

P _schulstundeDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _schulstundeGetId(Schulstunde object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _schulstundeGetLinks(Schulstunde object) {
  return [object.fach];
}

void _schulstundeAttach(
    IsarCollection<dynamic> col, Id id, Schulstunde object) {
  object.id = id;
  object.fach.attach(col, col.isar.collection<Lerngruppe>(), r'fach', id);
}

extension SchulstundeByIndex on IsarCollection<Schulstunde> {
  Future<Schulstunde?> getByWochentagStunde(int? wochentag, int? stunde) {
    return getByIndex(r'wochentag_stunde', [wochentag, stunde]);
  }

  Schulstunde? getByWochentagStundeSync(int? wochentag, int? stunde) {
    return getByIndexSync(r'wochentag_stunde', [wochentag, stunde]);
  }

  Future<bool> deleteByWochentagStunde(int? wochentag, int? stunde) {
    return deleteByIndex(r'wochentag_stunde', [wochentag, stunde]);
  }

  bool deleteByWochentagStundeSync(int? wochentag, int? stunde) {
    return deleteByIndexSync(r'wochentag_stunde', [wochentag, stunde]);
  }

  Future<List<Schulstunde?>> getAllByWochentagStunde(
      List<int?> wochentagValues, List<int?> stundeValues) {
    final len = wochentagValues.length;
    assert(stundeValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([wochentagValues[i], stundeValues[i]]);
    }

    return getAllByIndex(r'wochentag_stunde', values);
  }

  List<Schulstunde?> getAllByWochentagStundeSync(
      List<int?> wochentagValues, List<int?> stundeValues) {
    final len = wochentagValues.length;
    assert(stundeValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([wochentagValues[i], stundeValues[i]]);
    }

    return getAllByIndexSync(r'wochentag_stunde', values);
  }

  Future<int> deleteAllByWochentagStunde(
      List<int?> wochentagValues, List<int?> stundeValues) {
    final len = wochentagValues.length;
    assert(stundeValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([wochentagValues[i], stundeValues[i]]);
    }

    return deleteAllByIndex(r'wochentag_stunde', values);
  }

  int deleteAllByWochentagStundeSync(
      List<int?> wochentagValues, List<int?> stundeValues) {
    final len = wochentagValues.length;
    assert(stundeValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([wochentagValues[i], stundeValues[i]]);
    }

    return deleteAllByIndexSync(r'wochentag_stunde', values);
  }

  Future<Id> putByWochentagStunde(Schulstunde object) {
    return putByIndex(r'wochentag_stunde', object);
  }

  Id putByWochentagStundeSync(Schulstunde object, {bool saveLinks = true}) {
    return putByIndexSync(r'wochentag_stunde', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWochentagStunde(List<Schulstunde> objects) {
    return putAllByIndex(r'wochentag_stunde', objects);
  }

  List<Id> putAllByWochentagStundeSync(List<Schulstunde> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'wochentag_stunde', objects,
        saveLinks: saveLinks);
  }
}

extension SchulstundeQueryWhereSort
    on QueryBuilder<Schulstunde, Schulstunde, QWhere> {
  QueryBuilder<Schulstunde, Schulstunde, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhere> anyWochentagStunde() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'wochentag_stunde'),
      );
    });
  }
}

extension SchulstundeQueryWhere
    on QueryBuilder<Schulstunde, Schulstunde, QWhereClause> {
  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause> idBetween(
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

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagIsNullAnyStunde() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'wochentag_stunde',
        value: [null],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagIsNotNullAnyStunde() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToAnyStunde(int? wochentag) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'wochentag_stunde',
        value: [wochentag],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagNotEqualToAnyStunde(int? wochentag) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [],
              upper: [wochentag],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [wochentag],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [wochentag],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [],
              upper: [wochentag],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagGreaterThanAnyStunde(
    int? wochentag, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [wochentag],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagLessThanAnyStunde(
    int? wochentag, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [],
        upper: [wochentag],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagBetweenAnyStunde(
    int? lowerWochentag,
    int? upperWochentag, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [lowerWochentag],
        includeLower: includeLower,
        upper: [upperWochentag],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToStundeIsNull(int? wochentag) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'wochentag_stunde',
        value: [wochentag, null],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToStundeIsNotNull(int? wochentag) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [wochentag, null],
        includeLower: false,
        upper: [
          wochentag,
        ],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagStundeEqualTo(int? wochentag, int? stunde) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'wochentag_stunde',
        value: [wochentag, stunde],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToStundeNotEqualTo(int? wochentag, int? stunde) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [wochentag],
              upper: [wochentag, stunde],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [wochentag, stunde],
              includeLower: false,
              upper: [wochentag],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [wochentag, stunde],
              includeLower: false,
              upper: [wochentag],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'wochentag_stunde',
              lower: [wochentag],
              upper: [wochentag, stunde],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToStundeGreaterThan(
    int? wochentag,
    int? stunde, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [wochentag, stunde],
        includeLower: include,
        upper: [wochentag],
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToStundeLessThan(
    int? wochentag,
    int? stunde, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [wochentag],
        upper: [wochentag, stunde],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterWhereClause>
      wochentagEqualToStundeBetween(
    int? wochentag,
    int? lowerStunde,
    int? upperStunde, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'wochentag_stunde',
        lower: [wochentag, lowerStunde],
        includeLower: includeLower,
        upper: [wochentag, upperStunde],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SchulstundeQueryFilter
    on QueryBuilder<Schulstunde, Schulstunde, QFilterCondition> {
  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'raum',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      raumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'raum',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'raum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'raum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'raum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'raum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'raum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'raum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'raum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'raum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> raumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'raum',
        value: '',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      raumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'raum',
        value: '',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> stundeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stunde',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      stundeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stunde',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> stundeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stunde',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      stundeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stunde',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> stundeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stunde',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> stundeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stunde',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> syncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      wochentagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wochentag',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      wochentagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wochentag',
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      wochentagEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wochentag',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      wochentagGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wochentag',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      wochentagLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wochentag',
        value: value,
      ));
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition>
      wochentagBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wochentag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SchulstundeQueryObject
    on QueryBuilder<Schulstunde, Schulstunde, QFilterCondition> {}

extension SchulstundeQueryLinks
    on QueryBuilder<Schulstunde, Schulstunde, QFilterCondition> {
  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> fach(
      FilterQuery<Lerngruppe> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'fach');
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterFilterCondition> fachIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'fach', 0, true, 0, true);
    });
  }
}

extension SchulstundeQuerySortBy
    on QueryBuilder<Schulstunde, Schulstunde, QSortBy> {
  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortByRaum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortByRaumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortByStunde() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stunde', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortByStundeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stunde', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortByWochentag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> sortByWochentagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.desc);
    });
  }
}

extension SchulstundeQuerySortThenBy
    on QueryBuilder<Schulstunde, Schulstunde, QSortThenBy> {
  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByRaum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByRaumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByStunde() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stunde', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByStundeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stunde', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByWochentag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.asc);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QAfterSortBy> thenByWochentagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.desc);
    });
  }
}

extension SchulstundeQueryWhereDistinct
    on QueryBuilder<Schulstunde, Schulstunde, QDistinct> {
  QueryBuilder<Schulstunde, Schulstunde, QDistinct> distinctByRaum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'raum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QDistinct> distinctByStunde() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stunde');
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }

  QueryBuilder<Schulstunde, Schulstunde, QDistinct> distinctByWochentag() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wochentag');
    });
  }
}

extension SchulstundeQueryProperty
    on QueryBuilder<Schulstunde, Schulstunde, QQueryProperty> {
  QueryBuilder<Schulstunde, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Schulstunde, String?, QQueryOperations> raumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'raum');
    });
  }

  QueryBuilder<Schulstunde, int?, QQueryOperations> stundeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stunde');
    });
  }

  QueryBuilder<Schulstunde, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }

  QueryBuilder<Schulstunde, int?, QQueryOperations> wochentagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wochentag');
    });
  }
}
