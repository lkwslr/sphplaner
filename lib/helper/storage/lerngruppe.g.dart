// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lerngruppe.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLerngruppeCollection on Isar {
  IsarCollection<Lerngruppe> get lerngruppes => this.collection();
}

const LerngruppeSchema = CollectionSchema(
  name: r'Lerngruppe',
  id: -6537887012447810688,
  properties: {
    r'edited': PropertySchema(
      id: 0,
      name: r'edited',
      type: IsarType.bool,
    ),
    r'farbe': PropertySchema(
      id: 1,
      name: r'farbe',
      type: IsarType.long,
    ),
    r'fullName': PropertySchema(
      id: 2,
      name: r'fullName',
      type: IsarType.string,
    ),
    r'generatedName': PropertySchema(
      id: 3,
      name: r'generatedName',
      type: IsarType.string,
    ),
    r'gruppenId': PropertySchema(
      id: 4,
      name: r'gruppenId',
      type: IsarType.string,
    ),
    r'halbjahr': PropertySchema(
      id: 5,
      name: r'halbjahr',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'synced': PropertySchema(
      id: 7,
      name: r'synced',
      type: IsarType.bool,
    ),
    r'zweig': PropertySchema(
      id: 8,
      name: r'zweig',
      type: IsarType.string,
    )
  },
  estimateSize: _lerngruppeEstimateSize,
  serialize: _lerngruppeSerialize,
  deserialize: _lerngruppeDeserialize,
  deserializeProp: _lerngruppeDeserializeProp,
  idName: r'id',
  indexes: {
    r'gruppenId': IndexSchema(
      id: 776481632215938901,
      name: r'gruppenId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'gruppenId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'lehrkraft': LinkSchema(
      id: 4808385261236350467,
      name: r'lehrkraft',
      target: r'Lehrkraft',
      single: true,
    ),
    r'leistungskontrollen': LinkSchema(
      id: -2091736919034331370,
      name: r'leistungskontrollen',
      target: r'Leistungskontrolle',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _lerngruppeGetId,
  getLinks: _lerngruppeGetLinks,
  attach: _lerngruppeAttach,
  version: '3.1.8',
);

int _lerngruppeEstimateSize(
  Lerngruppe object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fullName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.generatedName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.gruppenId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.halbjahr;
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
  {
    final value = object.zweig;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _lerngruppeSerialize(
  Lerngruppe object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.edited);
  writer.writeLong(offsets[1], object.farbe);
  writer.writeString(offsets[2], object.fullName);
  writer.writeString(offsets[3], object.generatedName);
  writer.writeString(offsets[4], object.gruppenId);
  writer.writeString(offsets[5], object.halbjahr);
  writer.writeString(offsets[6], object.name);
  writer.writeBool(offsets[7], object.synced);
  writer.writeString(offsets[8], object.zweig);
}

Lerngruppe _lerngruppeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Lerngruppe();
  object.edited = reader.readBool(offsets[0]);
  object.farbe = reader.readLong(offsets[1]);
  object.fullName = reader.readStringOrNull(offsets[2]);
  object.generatedName = reader.readStringOrNull(offsets[3]);
  object.gruppenId = reader.readStringOrNull(offsets[4]);
  object.halbjahr = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[6]);
  object.synced = reader.readBool(offsets[7]);
  object.zweig = reader.readStringOrNull(offsets[8]);
  return object;
}

P _lerngruppeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _lerngruppeGetId(Lerngruppe object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lerngruppeGetLinks(Lerngruppe object) {
  return [object.lehrkraft, object.leistungskontrollen];
}

void _lerngruppeAttach(IsarCollection<dynamic> col, Id id, Lerngruppe object) {
  object.id = id;
  object.lehrkraft
      .attach(col, col.isar.collection<Lehrkraft>(), r'lehrkraft', id);
  object.leistungskontrollen.attach(col,
      col.isar.collection<Leistungskontrolle>(), r'leistungskontrollen', id);
}

extension LerngruppeByIndex on IsarCollection<Lerngruppe> {
  Future<Lerngruppe?> getByGruppenId(String? gruppenId) {
    return getByIndex(r'gruppenId', [gruppenId]);
  }

  Lerngruppe? getByGruppenIdSync(String? gruppenId) {
    return getByIndexSync(r'gruppenId', [gruppenId]);
  }

  Future<bool> deleteByGruppenId(String? gruppenId) {
    return deleteByIndex(r'gruppenId', [gruppenId]);
  }

  bool deleteByGruppenIdSync(String? gruppenId) {
    return deleteByIndexSync(r'gruppenId', [gruppenId]);
  }

  Future<List<Lerngruppe?>> getAllByGruppenId(List<String?> gruppenIdValues) {
    final values = gruppenIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'gruppenId', values);
  }

  List<Lerngruppe?> getAllByGruppenIdSync(List<String?> gruppenIdValues) {
    final values = gruppenIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'gruppenId', values);
  }

  Future<int> deleteAllByGruppenId(List<String?> gruppenIdValues) {
    final values = gruppenIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'gruppenId', values);
  }

  int deleteAllByGruppenIdSync(List<String?> gruppenIdValues) {
    final values = gruppenIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'gruppenId', values);
  }

  Future<Id> putByGruppenId(Lerngruppe object) {
    return putByIndex(r'gruppenId', object);
  }

  Id putByGruppenIdSync(Lerngruppe object, {bool saveLinks = true}) {
    return putByIndexSync(r'gruppenId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGruppenId(List<Lerngruppe> objects) {
    return putAllByIndex(r'gruppenId', objects);
  }

  List<Id> putAllByGruppenIdSync(List<Lerngruppe> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'gruppenId', objects, saveLinks: saveLinks);
  }
}

extension LerngruppeQueryWhereSort
    on QueryBuilder<Lerngruppe, Lerngruppe, QWhere> {
  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LerngruppeQueryWhere
    on QueryBuilder<Lerngruppe, Lerngruppe, QWhereClause> {
  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> idBetween(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> gruppenIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'gruppenId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> gruppenIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'gruppenId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> gruppenIdEqualTo(
      String? gruppenId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'gruppenId',
        value: [gruppenId],
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterWhereClause> gruppenIdNotEqualTo(
      String? gruppenId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gruppenId',
              lower: [],
              upper: [gruppenId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gruppenId',
              lower: [gruppenId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gruppenId',
              lower: [gruppenId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gruppenId',
              lower: [],
              upper: [gruppenId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LerngruppeQueryFilter
    on QueryBuilder<Lerngruppe, Lerngruppe, QFilterCondition> {
  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> editedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edited',
        value: value,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> farbeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'farbe',
        value: value,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> farbeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'farbe',
        value: value,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> farbeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'farbe',
        value: value,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> farbeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'farbe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullName',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      fullNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullName',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      fullNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      fullNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> fullNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      fullNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullName',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      fullNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullName',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'generatedName',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'generatedName',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generatedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'generatedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'generatedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'generatedName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'generatedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'generatedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'generatedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'generatedName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generatedName',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      generatedNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'generatedName',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      gruppenIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gruppenId',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      gruppenIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gruppenId',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> gruppenIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gruppenId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      gruppenIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gruppenId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> gruppenIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gruppenId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> gruppenIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gruppenId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      gruppenIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gruppenId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> gruppenIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gruppenId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> gruppenIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gruppenId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> gruppenIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gruppenId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      gruppenIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gruppenId',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      gruppenIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gruppenId',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'halbjahr',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      halbjahrIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'halbjahr',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'halbjahr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      halbjahrGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'halbjahr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'halbjahr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'halbjahr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      halbjahrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'halbjahr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'halbjahr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'halbjahr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> halbjahrMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'halbjahr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      halbjahrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'halbjahr',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      halbjahrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'halbjahr',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> syncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zweig',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zweig',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zweig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zweig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zweig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zweig',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zweig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zweig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zweig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zweig',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> zweigIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zweig',
        value: '',
      ));
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      zweigIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zweig',
        value: '',
      ));
    });
  }
}

extension LerngruppeQueryObject
    on QueryBuilder<Lerngruppe, Lerngruppe, QFilterCondition> {}

extension LerngruppeQueryLinks
    on QueryBuilder<Lerngruppe, Lerngruppe, QFilterCondition> {
  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition> lehrkraft(
      FilterQuery<Lehrkraft> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lehrkraft');
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      lehrkraftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lehrkraft', 0, true, 0, true);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollen(FilterQuery<Leistungskontrolle> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'leistungskontrollen');
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollenLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'leistungskontrollen', length, true, length, true);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'leistungskontrollen', 0, true, 0, true);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'leistungskontrollen', 0, false, 999999, true);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollenLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'leistungskontrollen', 0, true, length, include);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollenLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'leistungskontrollen', length, include, 999999, true);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterFilterCondition>
      leistungskontrollenLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'leistungskontrollen', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LerngruppeQuerySortBy
    on QueryBuilder<Lerngruppe, Lerngruppe, QSortBy> {
  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByFarbe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farbe', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByFarbeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farbe', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByGeneratedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedName', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByGeneratedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedName', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByGruppenId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gruppenId', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByGruppenIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gruppenId', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByHalbjahr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halbjahr', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByHalbjahrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halbjahr', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByZweig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zweig', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> sortByZweigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zweig', Sort.desc);
    });
  }
}

extension LerngruppeQuerySortThenBy
    on QueryBuilder<Lerngruppe, Lerngruppe, QSortThenBy> {
  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edited', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByFarbe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farbe', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByFarbeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farbe', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByGeneratedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedName', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByGeneratedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedName', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByGruppenId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gruppenId', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByGruppenIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gruppenId', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByHalbjahr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halbjahr', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByHalbjahrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halbjahr', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByZweig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zweig', Sort.asc);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QAfterSortBy> thenByZweigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zweig', Sort.desc);
    });
  }
}

extension LerngruppeQueryWhereDistinct
    on QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> {
  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edited');
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByFarbe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'farbe');
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByFullName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByGeneratedName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generatedName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByGruppenId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gruppenId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByHalbjahr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'halbjahr', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }

  QueryBuilder<Lerngruppe, Lerngruppe, QDistinct> distinctByZweig(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zweig', caseSensitive: caseSensitive);
    });
  }
}

extension LerngruppeQueryProperty
    on QueryBuilder<Lerngruppe, Lerngruppe, QQueryProperty> {
  QueryBuilder<Lerngruppe, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Lerngruppe, bool, QQueryOperations> editedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edited');
    });
  }

  QueryBuilder<Lerngruppe, int, QQueryOperations> farbeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'farbe');
    });
  }

  QueryBuilder<Lerngruppe, String?, QQueryOperations> fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullName');
    });
  }

  QueryBuilder<Lerngruppe, String?, QQueryOperations> generatedNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generatedName');
    });
  }

  QueryBuilder<Lerngruppe, String?, QQueryOperations> gruppenIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gruppenId');
    });
  }

  QueryBuilder<Lerngruppe, String?, QQueryOperations> halbjahrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'halbjahr');
    });
  }

  QueryBuilder<Lerngruppe, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Lerngruppe, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }

  QueryBuilder<Lerngruppe, String?, QQueryOperations> zweigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zweig');
    });
  }
}
