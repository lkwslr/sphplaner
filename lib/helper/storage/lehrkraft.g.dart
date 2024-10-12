// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lehrkraft.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLehrkraftCollection on Isar {
  IsarCollection<Lehrkraft> get lehrkrafts => this.collection();
}

const LehrkraftSchema = CollectionSchema(
  name: r'Lehrkraft',
  id: 294726277638354443,
  properties: {
    r'fullLehrkraft': PropertySchema(
      id: 0,
      name: r'fullLehrkraft',
      type: IsarType.string,
    ),
    r'kuerzel': PropertySchema(
      id: 1,
      name: r'kuerzel',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'synced': PropertySchema(
      id: 3,
      name: r'synced',
      type: IsarType.bool,
    )
  },
  estimateSize: _lehrkraftEstimateSize,
  serialize: _lehrkraftSerialize,
  deserialize: _lehrkraftDeserialize,
  deserializeProp: _lehrkraftDeserializeProp,
  idName: r'id',
  indexes: {
    r'kuerzel': IndexSchema(
      id: -2277106632904248205,
      name: r'kuerzel',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'kuerzel',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'lerngruppen': LinkSchema(
      id: 7442349979814691606,
      name: r'lerngruppen',
      target: r'Lerngruppe',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _lehrkraftGetId,
  getLinks: _lehrkraftGetLinks,
  attach: _lehrkraftAttach,
  version: '3.1.8',
);

int _lehrkraftEstimateSize(
  Lehrkraft object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fullLehrkraft;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.kuerzel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _lehrkraftSerialize(
  Lehrkraft object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fullLehrkraft);
  writer.writeString(offsets[1], object.kuerzel);
  writer.writeString(offsets[2], object.name);
  writer.writeBool(offsets[3], object.synced);
}

Lehrkraft _lehrkraftDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Lehrkraft();
  object.fullLehrkraft = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.kuerzel = reader.readStringOrNull(offsets[1]);
  object.name = reader.readStringOrNull(offsets[2]);
  object.synced = reader.readBool(offsets[3]);
  return object;
}

P _lehrkraftDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _lehrkraftGetId(Lehrkraft object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lehrkraftGetLinks(Lehrkraft object) {
  return [object.lerngruppen];
}

void _lehrkraftAttach(IsarCollection<dynamic> col, Id id, Lehrkraft object) {
  object.id = id;
  object.lerngruppen
      .attach(col, col.isar.collection<Lerngruppe>(), r'lerngruppen', id);
}

extension LehrkraftByIndex on IsarCollection<Lehrkraft> {
  Future<Lehrkraft?> getByKuerzel(String? kuerzel) {
    return getByIndex(r'kuerzel', [kuerzel]);
  }

  Lehrkraft? getByKuerzelSync(String? kuerzel) {
    return getByIndexSync(r'kuerzel', [kuerzel]);
  }

  Future<bool> deleteByKuerzel(String? kuerzel) {
    return deleteByIndex(r'kuerzel', [kuerzel]);
  }

  bool deleteByKuerzelSync(String? kuerzel) {
    return deleteByIndexSync(r'kuerzel', [kuerzel]);
  }

  Future<List<Lehrkraft?>> getAllByKuerzel(List<String?> kuerzelValues) {
    final values = kuerzelValues.map((e) => [e]).toList();
    return getAllByIndex(r'kuerzel', values);
  }

  List<Lehrkraft?> getAllByKuerzelSync(List<String?> kuerzelValues) {
    final values = kuerzelValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'kuerzel', values);
  }

  Future<int> deleteAllByKuerzel(List<String?> kuerzelValues) {
    final values = kuerzelValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'kuerzel', values);
  }

  int deleteAllByKuerzelSync(List<String?> kuerzelValues) {
    final values = kuerzelValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'kuerzel', values);
  }

  Future<Id> putByKuerzel(Lehrkraft object) {
    return putByIndex(r'kuerzel', object);
  }

  Id putByKuerzelSync(Lehrkraft object, {bool saveLinks = true}) {
    return putByIndexSync(r'kuerzel', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByKuerzel(List<Lehrkraft> objects) {
    return putAllByIndex(r'kuerzel', objects);
  }

  List<Id> putAllByKuerzelSync(List<Lehrkraft> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'kuerzel', objects, saveLinks: saveLinks);
  }
}

extension LehrkraftQueryWhereSort
    on QueryBuilder<Lehrkraft, Lehrkraft, QWhere> {
  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LehrkraftQueryWhere
    on QueryBuilder<Lehrkraft, Lehrkraft, QWhereClause> {
  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> idBetween(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> kuerzelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'kuerzel',
        value: [null],
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> kuerzelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'kuerzel',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> kuerzelEqualTo(
      String? kuerzel) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'kuerzel',
        value: [kuerzel],
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterWhereClause> kuerzelNotEqualTo(
      String? kuerzel) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kuerzel',
              lower: [],
              upper: [kuerzel],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kuerzel',
              lower: [kuerzel],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kuerzel',
              lower: [kuerzel],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'kuerzel',
              lower: [],
              upper: [kuerzel],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LehrkraftQueryFilter
    on QueryBuilder<Lehrkraft, Lehrkraft, QFilterCondition> {
  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullLehrkraft',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullLehrkraft',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullLehrkraft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullLehrkraft',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullLehrkraft',
        value: '',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      fullLehrkraftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullLehrkraft',
        value: '',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kuerzel',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kuerzel',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kuerzel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kuerzel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kuerzel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kuerzel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kuerzel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kuerzel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kuerzel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kuerzel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> kuerzelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kuerzel',
        value: '',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      kuerzelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kuerzel',
        value: '',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> syncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }
}

extension LehrkraftQueryObject
    on QueryBuilder<Lehrkraft, Lehrkraft, QFilterCondition> {}

extension LehrkraftQueryLinks
    on QueryBuilder<Lehrkraft, Lehrkraft, QFilterCondition> {
  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition> lerngruppen(
      FilterQuery<Lerngruppe> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lerngruppen');
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      lerngruppenLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppen', length, true, length, true);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      lerngruppenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppen', 0, true, 0, true);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      lerngruppenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppen', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      lerngruppenLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppen', 0, true, length, include);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      lerngruppenLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppen', length, include, 999999, true);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterFilterCondition>
      lerngruppenLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'lerngruppen', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LehrkraftQuerySortBy on QueryBuilder<Lehrkraft, Lehrkraft, QSortBy> {
  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortByFullLehrkraft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullLehrkraft', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortByFullLehrkraftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullLehrkraft', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortByKuerzel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kuerzel', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortByKuerzelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kuerzel', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension LehrkraftQuerySortThenBy
    on QueryBuilder<Lehrkraft, Lehrkraft, QSortThenBy> {
  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByFullLehrkraft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullLehrkraft', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByFullLehrkraftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullLehrkraft', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByKuerzel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kuerzel', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByKuerzelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kuerzel', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QAfterSortBy> thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension LehrkraftQueryWhereDistinct
    on QueryBuilder<Lehrkraft, Lehrkraft, QDistinct> {
  QueryBuilder<Lehrkraft, Lehrkraft, QDistinct> distinctByFullLehrkraft(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullLehrkraft',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QDistinct> distinctByKuerzel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kuerzel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lehrkraft, Lehrkraft, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }
}

extension LehrkraftQueryProperty
    on QueryBuilder<Lehrkraft, Lehrkraft, QQueryProperty> {
  QueryBuilder<Lehrkraft, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Lehrkraft, String?, QQueryOperations> fullLehrkraftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullLehrkraft');
    });
  }

  QueryBuilder<Lehrkraft, String?, QQueryOperations> kuerzelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kuerzel');
    });
  }

  QueryBuilder<Lehrkraft, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Lehrkraft, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }
}
