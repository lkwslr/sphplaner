// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leistungskontrolle.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLeistungskontrolleCollection on Isar {
  IsarCollection<Leistungskontrolle> get leistungskontrolles =>
      this.collection();
}

const LeistungskontrolleSchema = CollectionSchema(
  name: r'Leistungskontrolle',
  id: 149614841950714747,
  properties: {
    r'art': PropertySchema(
      id: 0,
      name: r'art',
      type: IsarType.string,
    ),
    r'datum': PropertySchema(
      id: 1,
      name: r'datum',
      type: IsarType.dateTime,
    ),
    r'stunden': PropertySchema(
      id: 2,
      name: r'stunden',
      type: IsarType.longList,
    ),
    r'synced': PropertySchema(
      id: 3,
      name: r'synced',
      type: IsarType.bool,
    )
  },
  estimateSize: _leistungskontrolleEstimateSize,
  serialize: _leistungskontrolleSerialize,
  deserialize: _leistungskontrolleDeserialize,
  deserializeProp: _leistungskontrolleDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'lerngruppe': LinkSchema(
      id: 4298525671460558670,
      name: r'lerngruppe',
      target: r'Lerngruppe',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _leistungskontrolleGetId,
  getLinks: _leistungskontrolleGetLinks,
  attach: _leistungskontrolleAttach,
  version: '3.1.8',
);

int _leistungskontrolleEstimateSize(
  Leistungskontrolle object,
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
    final value = object.stunden;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _leistungskontrolleSerialize(
  Leistungskontrolle object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.art);
  writer.writeDateTime(offsets[1], object.datum);
  writer.writeLongList(offsets[2], object.stunden);
  writer.writeBool(offsets[3], object.synced);
}

Leistungskontrolle _leistungskontrolleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Leistungskontrolle();
  object.art = reader.readStringOrNull(offsets[0]);
  object.datum = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.stunden = reader.readLongList(offsets[2]);
  object.synced = reader.readBool(offsets[3]);
  return object;
}

P _leistungskontrolleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongList(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _leistungskontrolleGetId(Leistungskontrolle object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _leistungskontrolleGetLinks(
    Leistungskontrolle object) {
  return [object.lerngruppe];
}

void _leistungskontrolleAttach(
    IsarCollection<dynamic> col, Id id, Leistungskontrolle object) {
  object.id = id;
  object.lerngruppe
      .attach(col, col.isar.collection<Lerngruppe>(), r'lerngruppe', id);
}

extension LeistungskontrolleQueryWhereSort
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QWhere> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LeistungskontrolleQueryWhere
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QWhereClause> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterWhereClause>
      idBetween(
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

extension LeistungskontrolleQueryFilter
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QFilterCondition> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'art',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'art',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artEqualTo(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artGreaterThan(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artLessThan(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artBetween(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artStartsWith(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artEndsWith(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'art',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'art',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'art',
        value: '',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      artIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'art',
        value: '',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      datumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'datum',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      datumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'datum',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      datumEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datum',
        value: value,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      datumGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'datum',
        value: value,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      datumLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'datum',
        value: value,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      datumBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'datum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      stundenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stunden',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      stundenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stunden',
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      stundenElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stunden',
        value: value,
      ));
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      stundenIsEmpty() {
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
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

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      syncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }
}

extension LeistungskontrolleQueryObject
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QFilterCondition> {}

extension LeistungskontrolleQueryLinks
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QFilterCondition> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      lerngruppe(FilterQuery<Lerngruppe> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lerngruppe');
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterFilterCondition>
      lerngruppeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lerngruppe', 0, true, 0, true);
    });
  }
}

extension LeistungskontrolleQuerySortBy
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QSortBy> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      sortByArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      sortByArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.desc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      sortByDatum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      sortByDatumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.desc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension LeistungskontrolleQuerySortThenBy
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QSortThenBy> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenByArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenByArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'art', Sort.desc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenByDatum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenByDatumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datum', Sort.desc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QAfterSortBy>
      thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension LeistungskontrolleQueryWhereDistinct
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QDistinct> {
  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QDistinct> distinctByArt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'art', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QDistinct>
      distinctByDatum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datum');
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QDistinct>
      distinctByStunden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stunden');
    });
  }

  QueryBuilder<Leistungskontrolle, Leistungskontrolle, QDistinct>
      distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }
}

extension LeistungskontrolleQueryProperty
    on QueryBuilder<Leistungskontrolle, Leistungskontrolle, QQueryProperty> {
  QueryBuilder<Leistungskontrolle, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Leistungskontrolle, String?, QQueryOperations> artProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'art');
    });
  }

  QueryBuilder<Leistungskontrolle, DateTime?, QQueryOperations>
      datumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datum');
    });
  }

  QueryBuilder<Leistungskontrolle, List<int>?, QQueryOperations>
      stundenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stunden');
    });
  }

  QueryBuilder<Leistungskontrolle, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }
}
