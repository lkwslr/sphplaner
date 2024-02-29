// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHomeworkCollection on Isar {
  IsarCollection<Homework> get homeworks => this.collection();
}

const HomeworkSchema = CollectionSchema(
  name: r'Homework',
  id: -6707939081481351317,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'due': PropertySchema(
      id: 1,
      name: r'due',
      type: IsarType.long,
    ),
    r'finished': PropertySchema(
      id: 2,
      name: r'finished',
      type: IsarType.bool,
    ),
    r'online': PropertySchema(
      id: 3,
      name: r'online',
      type: IsarType.bool,
    ),
    r'onlineIdentifier': PropertySchema(
      id: 4,
      name: r'onlineIdentifier',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _homeworkEstimateSize,
  serialize: _homeworkSerialize,
  deserialize: _homeworkDeserialize,
  deserializeProp: _homeworkDeserializeProp,
  idName: r'id',
  indexes: {
    r'onlineIdentifier': IndexSchema(
      id: -5919514136883663529,
      name: r'onlineIdentifier',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'onlineIdentifier',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'subject': LinkSchema(
      id: -6400455214299485423,
      name: r'subject',
      target: r'Subject',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _homeworkGetId,
  getLinks: _homeworkGetLinks,
  attach: _homeworkAttach,
  version: '3.1.0+1',
);

int _homeworkEstimateSize(
  Homework object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.onlineIdentifier;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _homeworkSerialize(
  Homework object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeLong(offsets[1], object.due);
  writer.writeBool(offsets[2], object.finished);
  writer.writeBool(offsets[3], object.online);
  writer.writeString(offsets[4], object.onlineIdentifier);
  writer.writeString(offsets[5], object.title);
}

Homework _homeworkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Homework();
  object.description = reader.readStringOrNull(offsets[0]);
  object.due = reader.readLongOrNull(offsets[1]);
  object.finished = reader.readBool(offsets[2]);
  object.id = id;
  object.online = reader.readBool(offsets[3]);
  object.onlineIdentifier = reader.readStringOrNull(offsets[4]);
  object.title = reader.readStringOrNull(offsets[5]);
  return object;
}

P _homeworkDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _homeworkGetId(Homework object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _homeworkGetLinks(Homework object) {
  return [object.subject];
}

void _homeworkAttach(IsarCollection<dynamic> col, Id id, Homework object) {
  object.id = id;
  object.subject.attach(col, col.isar.collection<Subject>(), r'subject', id);
}

extension HomeworkByIndex on IsarCollection<Homework> {
  Future<Homework?> getByOnlineIdentifier(String? onlineIdentifier) {
    return getByIndex(r'onlineIdentifier', [onlineIdentifier]);
  }

  Homework? getByOnlineIdentifierSync(String? onlineIdentifier) {
    return getByIndexSync(r'onlineIdentifier', [onlineIdentifier]);
  }

  Future<bool> deleteByOnlineIdentifier(String? onlineIdentifier) {
    return deleteByIndex(r'onlineIdentifier', [onlineIdentifier]);
  }

  bool deleteByOnlineIdentifierSync(String? onlineIdentifier) {
    return deleteByIndexSync(r'onlineIdentifier', [onlineIdentifier]);
  }

  Future<List<Homework?>> getAllByOnlineIdentifier(
      List<String?> onlineIdentifierValues) {
    final values = onlineIdentifierValues.map((e) => [e]).toList();
    return getAllByIndex(r'onlineIdentifier', values);
  }

  List<Homework?> getAllByOnlineIdentifierSync(
      List<String?> onlineIdentifierValues) {
    final values = onlineIdentifierValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'onlineIdentifier', values);
  }

  Future<int> deleteAllByOnlineIdentifier(
      List<String?> onlineIdentifierValues) {
    final values = onlineIdentifierValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'onlineIdentifier', values);
  }

  int deleteAllByOnlineIdentifierSync(List<String?> onlineIdentifierValues) {
    final values = onlineIdentifierValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'onlineIdentifier', values);
  }

  Future<Id> putByOnlineIdentifier(Homework object) {
    return putByIndex(r'onlineIdentifier', object);
  }

  Id putByOnlineIdentifierSync(Homework object, {bool saveLinks = true}) {
    return putByIndexSync(r'onlineIdentifier', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByOnlineIdentifier(List<Homework> objects) {
    return putAllByIndex(r'onlineIdentifier', objects);
  }

  List<Id> putAllByOnlineIdentifierSync(List<Homework> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'onlineIdentifier', objects,
        saveLinks: saveLinks);
  }
}

extension HomeworkQueryWhereSort on QueryBuilder<Homework, Homework, QWhere> {
  QueryBuilder<Homework, Homework, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HomeworkQueryWhere on QueryBuilder<Homework, Homework, QWhereClause> {
  QueryBuilder<Homework, Homework, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Homework, Homework, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Homework, Homework, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Homework, Homework, QAfterWhereClause> idBetween(
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

  QueryBuilder<Homework, Homework, QAfterWhereClause> onlineIdentifierIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'onlineIdentifier',
        value: [null],
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterWhereClause>
      onlineIdentifierIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'onlineIdentifier',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterWhereClause> onlineIdentifierEqualTo(
      String? onlineIdentifier) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'onlineIdentifier',
        value: [onlineIdentifier],
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterWhereClause>
      onlineIdentifierNotEqualTo(String? onlineIdentifier) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onlineIdentifier',
              lower: [],
              upper: [onlineIdentifier],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onlineIdentifier',
              lower: [onlineIdentifier],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onlineIdentifier',
              lower: [onlineIdentifier],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onlineIdentifier',
              lower: [],
              upper: [onlineIdentifier],
              includeUpper: false,
            ));
      }
    });
  }
}

extension HomeworkQueryFilter
    on QueryBuilder<Homework, Homework, QFilterCondition> {
  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionLessThan(
    String? value, {
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionContains(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionMatches(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> dueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'due',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> dueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'due',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> dueEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'due',
        value: value,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> dueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'due',
        value: value,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> dueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'due',
        value: value,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> dueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'due',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> finishedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finished',
        value: value,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Homework, Homework, QAfterFilterCondition> onlineEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'online',
        value: value,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'onlineIdentifier',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'onlineIdentifier',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onlineIdentifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onlineIdentifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onlineIdentifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onlineIdentifier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'onlineIdentifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'onlineIdentifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'onlineIdentifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'onlineIdentifier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onlineIdentifier',
        value: '',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition>
      onlineIdentifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'onlineIdentifier',
        value: '',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension HomeworkQueryObject
    on QueryBuilder<Homework, Homework, QFilterCondition> {}

extension HomeworkQueryLinks
    on QueryBuilder<Homework, Homework, QFilterCondition> {
  QueryBuilder<Homework, Homework, QAfterFilterCondition> subject(
      FilterQuery<Subject> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subject');
    });
  }

  QueryBuilder<Homework, Homework, QAfterFilterCondition> subjectIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subject', 0, true, 0, true);
    });
  }
}

extension HomeworkQuerySortBy on QueryBuilder<Homework, Homework, QSortBy> {
  QueryBuilder<Homework, Homework, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finished', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finished', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByOnline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'online', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByOnlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'online', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByOnlineIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineIdentifier', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByOnlineIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineIdentifier', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension HomeworkQuerySortThenBy
    on QueryBuilder<Homework, Homework, QSortThenBy> {
  QueryBuilder<Homework, Homework, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'due', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finished', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finished', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByOnline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'online', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByOnlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'online', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByOnlineIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineIdentifier', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByOnlineIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineIdentifier', Sort.desc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Homework, Homework, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension HomeworkQueryWhereDistinct
    on QueryBuilder<Homework, Homework, QDistinct> {
  QueryBuilder<Homework, Homework, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Homework, Homework, QDistinct> distinctByDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'due');
    });
  }

  QueryBuilder<Homework, Homework, QDistinct> distinctByFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finished');
    });
  }

  QueryBuilder<Homework, Homework, QDistinct> distinctByOnline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'online');
    });
  }

  QueryBuilder<Homework, Homework, QDistinct> distinctByOnlineIdentifier(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onlineIdentifier',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Homework, Homework, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension HomeworkQueryProperty
    on QueryBuilder<Homework, Homework, QQueryProperty> {
  QueryBuilder<Homework, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Homework, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Homework, int?, QQueryOperations> dueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'due');
    });
  }

  QueryBuilder<Homework, bool, QQueryOperations> finishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finished');
    });
  }

  QueryBuilder<Homework, bool, QQueryOperations> onlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'online');
    });
  }

  QueryBuilder<Homework, String?, QQueryOperations> onlineIdentifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onlineIdentifier');
    });
  }

  QueryBuilder<Homework, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
