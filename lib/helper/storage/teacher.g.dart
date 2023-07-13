// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTeacherCollection on Isar {
  IsarCollection<Teacher> get teachers => this.collection();
}

const TeacherSchema = CollectionSchema(
  name: r'Teacher',
  id: 356616661396274803,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameShort': PropertySchema(
      id: 1,
      name: r'nameShort',
      type: IsarType.string,
    )
  },
  estimateSize: _teacherEstimateSize,
  serialize: _teacherSerialize,
  deserialize: _teacherDeserialize,
  deserializeProp: _teacherDeserializeProp,
  idName: r'id',
  indexes: {
    r'nameShort': IndexSchema(
      id: -7672634351627745356,
      name: r'nameShort',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nameShort',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _teacherGetId,
  getLinks: _teacherGetLinks,
  attach: _teacherAttach,
  version: '3.1.0+1',
);

int _teacherEstimateSize(
  Teacher object,
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
  {
    final value = object.nameShort;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _teacherSerialize(
  Teacher object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.nameShort);
}

Teacher _teacherDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Teacher();
  object.id = id;
  object.name = reader.readStringOrNull(offsets[0]);
  object.nameShort = reader.readStringOrNull(offsets[1]);
  return object;
}

P _teacherDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _teacherGetId(Teacher object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _teacherGetLinks(Teacher object) {
  return [];
}

void _teacherAttach(IsarCollection<dynamic> col, Id id, Teacher object) {
  object.id = id;
}

extension TeacherByIndex on IsarCollection<Teacher> {
  Future<Teacher?> getByNameShort(String? nameShort) {
    return getByIndex(r'nameShort', [nameShort]);
  }

  Teacher? getByNameShortSync(String? nameShort) {
    return getByIndexSync(r'nameShort', [nameShort]);
  }

  Future<bool> deleteByNameShort(String? nameShort) {
    return deleteByIndex(r'nameShort', [nameShort]);
  }

  bool deleteByNameShortSync(String? nameShort) {
    return deleteByIndexSync(r'nameShort', [nameShort]);
  }

  Future<List<Teacher?>> getAllByNameShort(List<String?> nameShortValues) {
    final values = nameShortValues.map((e) => [e]).toList();
    return getAllByIndex(r'nameShort', values);
  }

  List<Teacher?> getAllByNameShortSync(List<String?> nameShortValues) {
    final values = nameShortValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'nameShort', values);
  }

  Future<int> deleteAllByNameShort(List<String?> nameShortValues) {
    final values = nameShortValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'nameShort', values);
  }

  int deleteAllByNameShortSync(List<String?> nameShortValues) {
    final values = nameShortValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'nameShort', values);
  }

  Future<Id> putByNameShort(Teacher object) {
    return putByIndex(r'nameShort', object);
  }

  Id putByNameShortSync(Teacher object, {bool saveLinks = true}) {
    return putByIndexSync(r'nameShort', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNameShort(List<Teacher> objects) {
    return putAllByIndex(r'nameShort', objects);
  }

  List<Id> putAllByNameShortSync(List<Teacher> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'nameShort', objects, saveLinks: saveLinks);
  }
}

extension TeacherQueryWhereSort on QueryBuilder<Teacher, Teacher, QWhere> {
  QueryBuilder<Teacher, Teacher, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TeacherQueryWhere on QueryBuilder<Teacher, Teacher, QWhereClause> {
  QueryBuilder<Teacher, Teacher, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> idBetween(
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

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> nameShortIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameShort',
        value: [null],
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> nameShortIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameShort',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> nameShortEqualTo(
      String? nameShort) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameShort',
        value: [nameShort],
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterWhereClause> nameShortNotEqualTo(
      String? nameShort) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameShort',
              lower: [],
              upper: [nameShort],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameShort',
              lower: [nameShort],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameShort',
              lower: [nameShort],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameShort',
              lower: [],
              upper: [nameShort],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TeacherQueryFilter
    on QueryBuilder<Teacher, Teacher, QFilterCondition> {
  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameShort',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameShort',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameShort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameShort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameShort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameShort',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameShort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameShort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameShort',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameShort',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameShort',
        value: '',
      ));
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterFilterCondition> nameShortIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameShort',
        value: '',
      ));
    });
  }
}

extension TeacherQueryObject
    on QueryBuilder<Teacher, Teacher, QFilterCondition> {}

extension TeacherQueryLinks
    on QueryBuilder<Teacher, Teacher, QFilterCondition> {}

extension TeacherQuerySortBy on QueryBuilder<Teacher, Teacher, QSortBy> {
  QueryBuilder<Teacher, Teacher, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> sortByNameShort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameShort', Sort.asc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> sortByNameShortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameShort', Sort.desc);
    });
  }
}

extension TeacherQuerySortThenBy
    on QueryBuilder<Teacher, Teacher, QSortThenBy> {
  QueryBuilder<Teacher, Teacher, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> thenByNameShort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameShort', Sort.asc);
    });
  }

  QueryBuilder<Teacher, Teacher, QAfterSortBy> thenByNameShortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameShort', Sort.desc);
    });
  }
}

extension TeacherQueryWhereDistinct
    on QueryBuilder<Teacher, Teacher, QDistinct> {
  QueryBuilder<Teacher, Teacher, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Teacher, Teacher, QDistinct> distinctByNameShort(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameShort', caseSensitive: caseSensitive);
    });
  }
}

extension TeacherQueryProperty
    on QueryBuilder<Teacher, Teacher, QQueryProperty> {
  QueryBuilder<Teacher, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Teacher, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Teacher, String?, QQueryOperations> nameShortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameShort');
    });
  }
}
