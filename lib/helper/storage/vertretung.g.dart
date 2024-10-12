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
    r'art': PropertySchema(
      id: 0,
      name: r'art',
      type: IsarType.string,
    ),
    r'datum': PropertySchema(
      id: 1,
      name: r'datum',
      type: IsarType.string,
    ),
    r'fach': PropertySchema(
      id: 2,
      name: r'fach',
      type: IsarType.string,
    ),
    r'hinweis': PropertySchema(
      id: 3,
      name: r'hinweis',
      type: IsarType.string,
    ),
    r'kurs': PropertySchema(
      id: 4,
      name: r'kurs',
      type: IsarType.string,
    ),
    r'lehrkraft': PropertySchema(
      id: 5,
      name: r'lehrkraft',
      type: IsarType.string,
    ),
    r'placeholder': PropertySchema(
      id: 6,
      name: r'placeholder',
      type: IsarType.bool,
    ),
    r'raum': PropertySchema(
      id: 7,
      name: r'raum',
      type: IsarType.string,
    ),
    r'stunden': PropertySchema(
      id: 8,
      name: r'stunden',
      type: IsarType.longList,
    ),
    r'vertretungsFach': PropertySchema(
      id: 9,
      name: r'vertretungsFach',
      type: IsarType.string,
    ),
    r'vertretungsLehrkraft': PropertySchema(
      id: 10,
      name: r'vertretungsLehrkraft',
      type: IsarType.string,
    ),
    r'vertretungsRaum': PropertySchema(
      id: 11,
      name: r'vertretungsRaum',
      type: IsarType.string,
    ),
    r'wochentag': PropertySchema(
      id: 12,
      name: r'wochentag',
      type: IsarType.long,
    )
  },
  estimateSize: _vertretungEstimateSize,
  serialize: _vertretungSerialize,
  deserialize: _vertretungDeserialize,
  deserializeProp: _vertretungDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'lerngruppe': LinkSchema(
      id: -7100061387903415292,
      name: r'lerngruppe',
      target: r'Lerngruppe',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _vertretungGetId,
  getLinks: _vertretungGetLinks,
  attach: _vertretungAttach,
  version: '3.1.8',
);

int _vertretungEstimateSize(
  Vertretung object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.art;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.datum;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fach;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.hinweis;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.kurs;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lehrkraft;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.raum;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.stunden.length * 8;
  {
    final value = object.vertretungsFach;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vertretungsLehrkraft;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vertretungsRaum;
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
  writer.writeString(offsets[0], object.art);
  writer.writeString(offsets[1], object.datum);
  writer.writeString(offsets[2], object.fach);
  writer.writeString(offsets[3], object.hinweis);
  writer.writeString(offsets[4], object.kurs);
  writer.writeString(offsets[5], object.lehrkraft);
  writer.writeBool(offsets[6], object.placeholder);
  writer.writeString(offsets[7], object.raum);
  writer.writeLongList(offsets[8], object.stunden);
  writer.writeString(offsets[9], object.vertretungsFach);
  writer.writeString(offsets[10], object.vertretungsLehrkraft);
  writer.writeString(offsets[11], object.vertretungsRaum);
  writer.writeLong(offsets[12], object.wochentag);
}

Vertretung _vertretungDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Vertretung();
  object.art = reader.readStringOrNull(offsets[0]);
  object.datum = reader.readStringOrNull(offsets[1]);
  object.fach = reader.readStringOrNull(offsets[2]);
  object.hinweis = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.kurs = reader.readStringOrNull(offsets[4]);
  object.lehrkraft = reader.readStringOrNull(offsets[5]);
  object.placeholder = reader.readBool(offsets[6]);
  object.raum = reader.readStringOrNull(offsets[7]);
  object.stunden = reader.readLongList(offsets[8]) ?? [];
  object.vertretungsFach = reader.readStringOrNull(offsets[9]);
  object.vertretungsLehrkraft = reader.readStringOrNull(offsets[10]);
  object.vertretungsRaum = reader.readStringOrNull(offsets[11]);
  object.wochentag = reader.readLongOrNull(offsets[12]);
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
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongList(offset) ?? []) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vertretungGetId(Vertretung object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vertretungGetLinks(Vertretung object) {
  return [object.lerngruppe];
}

void _vertretungAttach(IsarCollection<dynamic> col, Id id, Vertretung object) {
  object.id = id;
  object.lerngruppe
      .attach(col, col.isar.collection<Lerngruppe>(), r'lerngruppe', id);
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
}

extension VertretungQueryFilter
    on QueryBuilder<Vertretung, Vertretung, QFilterCondition> {
  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'art',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'art',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'art',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'art',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'art',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> artIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'art',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'datum',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'datum',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'datum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'datum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'datum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'datum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'datum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'datum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'datum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> datumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datum',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      datumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'datum',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fach',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fach',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fach',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fach',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fach',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> fachIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fach',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hinweis',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      hinweisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hinweis',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hinweis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      hinweisGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hinweis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hinweis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hinweis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hinweis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hinweis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hinweis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hinweis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> hinweisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hinweis',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      hinweisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hinweis',
        value: '',
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kurs',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kurs',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kurs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kurs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kurs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kurs',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> kursIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kurs',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lehrkraftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lehrkraft',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lehrkraftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lehrkraft',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lehrkraftEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lehrkraftGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lehrkraftLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lehrkraftBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lehrkraft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lehrkraftStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lehrkraftEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lehrkraftContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lehrkraftMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lehrkraft',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lehrkraftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lehrkraft',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lehrkraftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lehrkraft',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      placeholderEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'placeholder',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'raum',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'raum',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumEqualTo(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumGreaterThan(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumLessThan(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumBetween(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumStartsWith(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumEndsWith(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumContains(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumMatches(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'raum',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> raumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'raum',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stunden',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stunden',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stunden',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stunden',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stunden',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> stundenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stunden',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stunden',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stunden',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stunden',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      stundenLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stunden',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vertretungsFach',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vertretungsFach',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vertretungsFach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vertretungsFach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vertretungsFach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vertretungsFach',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vertretungsFach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vertretungsFach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vertretungsFach',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vertretungsFach',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vertretungsFach',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsFachIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vertretungsFach',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vertretungsLehrkraft',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vertretungsLehrkraft',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vertretungsLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vertretungsLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vertretungsLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vertretungsLehrkraft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vertretungsLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vertretungsLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vertretungsLehrkraft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vertretungsLehrkraft',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vertretungsLehrkraft',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsLehrkraftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vertretungsLehrkraft',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vertretungsRaum',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vertretungsRaum',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vertretungsRaum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vertretungsRaum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vertretungsRaum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vertretungsRaum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vertretungsRaum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vertretungsRaum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vertretungsRaum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vertretungsRaum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vertretungsRaum',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      vertretungsRaumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vertretungsRaum',
        value: '',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      wochentagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wochentag',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      wochentagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wochentag',
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> wochentagEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wochentag',
        value: value,
      ));
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> wochentagLessThan(
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

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> wochentagBetween(
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

extension VertretungQueryObject
    on QueryBuilder<Vertretung, Vertretung, QFilterCondition> {}

extension VertretungQueryLinks
    on QueryBuilder<Vertretung, Vertretung, QFilterCondition> {
  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition> lerngruppe(
      FilterQuery<Lerngruppe> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lerngruppe');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterFilterCondition>
      lerngruppeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppe', 0, true, 0, true);
    });
  }
}

extension VertretungQuerySortBy
    on QueryBuilder<Vertretung, Vertretung, QSortBy> {
  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByDatum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByDatumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByFach() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fach', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByFachDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fach', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByHinweis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hinweis', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByHinweisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hinweis', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByKurs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kurs', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByKursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kurs', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByLehrkraft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lehrkraft', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByLehrkraftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lehrkraft', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByPlaceholder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'placeholder', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByPlaceholderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'placeholder', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByRaum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByRaumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByVertretungsFach() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsFach', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      sortByVertretungsFachDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsFach', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      sortByVertretungsLehrkraft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsLehrkraft', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      sortByVertretungsLehrkraftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsLehrkraft', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByVertretungsRaum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsRaum', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      sortByVertretungsRaumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsRaum', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByWochentag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> sortByWochentagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.desc);
    });
  }
}

extension VertretungQuerySortThenBy
    on QueryBuilder<Vertretung, Vertretung, QSortThenBy> {
  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByDatum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByDatumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByFach() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fach', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByFachDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fach', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByHinweis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hinweis', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByHinweisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hinweis', Sort.desc);
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

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByKurs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kurs', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByKursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kurs', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByLehrkraft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lehrkraft', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByLehrkraftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lehrkraft', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByPlaceholder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'placeholder', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByPlaceholderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'placeholder', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByRaum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByRaumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'raum', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByVertretungsFach() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsFach', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      thenByVertretungsFachDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsFach', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      thenByVertretungsLehrkraft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsLehrkraft', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      thenByVertretungsLehrkraftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsLehrkraft', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByVertretungsRaum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsRaum', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy>
      thenByVertretungsRaumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vertretungsRaum', Sort.desc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByWochentag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.asc);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QAfterSortBy> thenByWochentagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wochentag', Sort.desc);
    });
  }
}

extension VertretungQueryWhereDistinct
    on QueryBuilder<Vertretung, Vertretung, QDistinct> {
  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByArt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'art', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByDatum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByFach(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fach', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByHinweis(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hinweis', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByKurs(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kurs', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByLehrkraft(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lehrkraft', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByPlaceholder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'placeholder');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByRaum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'raum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByStunden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stunden');
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByVertretungsFach(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vertretungsFach',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct>
      distinctByVertretungsLehrkraft({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vertretungsLehrkraft',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByVertretungsRaum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vertretungsRaum',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vertretung, Vertretung, QDistinct> distinctByWochentag() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wochentag');
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

  QueryBuilder<Vertretung, String?, QQueryOperations> artProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'art');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> datumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datum');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> fachProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fach');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> hinweisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hinweis');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> kursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kurs');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> lehrkraftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lehrkraft');
    });
  }

  QueryBuilder<Vertretung, bool, QQueryOperations> placeholderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'placeholder');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations> raumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'raum');
    });
  }

  QueryBuilder<Vertretung, List<int>, QQueryOperations> stundenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stunden');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations>
      vertretungsFachProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vertretungsFach');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations>
      vertretungsLehrkraftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vertretungsLehrkraft');
    });
  }

  QueryBuilder<Vertretung, String?, QQueryOperations>
      vertretungsRaumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vertretungsRaum');
    });
  }

  QueryBuilder<Vertretung, int?, QQueryOperations> wochentagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wochentag');
    });
  }
}
