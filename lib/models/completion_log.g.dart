// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompletionLogCollection on Isar {
  IsarCollection<CompletionLog> get completionLogs => this.collection();
}

const CompletionLogSchema = CollectionSchema(
  name: r'CompletionLog',
  id: -7890849017743339507,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'moodScore': PropertySchema(
      id: 1,
      name: r'moodScore',
      type: IsarType.long,
    ),
    r'stackUid': PropertySchema(
      id: 2,
      name: r'stackUid',
      type: IsarType.string,
    )
  },
  estimateSize: _completionLogEstimateSize,
  serialize: _completionLogSerialize,
  deserialize: _completionLogDeserialize,
  deserializeProp: _completionLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _completionLogGetId,
  getLinks: _completionLogGetLinks,
  attach: _completionLogAttach,
  version: '3.1.0+1',
);

int _completionLogEstimateSize(
  CompletionLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.stackUid.length * 3;
  return bytesCount;
}

void _completionLogSerialize(
  CompletionLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeLong(offsets[1], object.moodScore);
  writer.writeString(offsets[2], object.stackUid);
}

CompletionLog _completionLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompletionLog();
  object.completedAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.moodScore = reader.readLong(offsets[1]);
  object.stackUid = reader.readString(offsets[2]);
  return object;
}

P _completionLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _completionLogGetId(CompletionLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _completionLogGetLinks(CompletionLog object) {
  return [];
}

void _completionLogAttach(
    IsarCollection<dynamic> col, Id id, CompletionLog object) {
  object.id = id;
}

extension CompletionLogQueryWhereSort
    on QueryBuilder<CompletionLog, CompletionLog, QWhere> {
  QueryBuilder<CompletionLog, CompletionLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompletionLogQueryWhere
    on QueryBuilder<CompletionLog, CompletionLog, QWhereClause> {
  QueryBuilder<CompletionLog, CompletionLog, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CompletionLog, CompletionLog, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterWhereClause> idBetween(
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

extension CompletionLogQueryFilter
    on QueryBuilder<CompletionLog, CompletionLog, QFilterCondition> {
  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      completedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      completedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      completedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
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

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      moodScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodScore',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      moodScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodScore',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      moodScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodScore',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      moodScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stackUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stackUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stackUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stackUid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stackUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stackUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stackUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stackUid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stackUid',
        value: '',
      ));
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterFilterCondition>
      stackUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stackUid',
        value: '',
      ));
    });
  }
}

extension CompletionLogQueryObject
    on QueryBuilder<CompletionLog, CompletionLog, QFilterCondition> {}

extension CompletionLogQueryLinks
    on QueryBuilder<CompletionLog, CompletionLog, QFilterCondition> {}

extension CompletionLogQuerySortBy
    on QueryBuilder<CompletionLog, CompletionLog, QSortBy> {
  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> sortByMoodScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy>
      sortByMoodScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.desc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> sortByStackUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackUid', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy>
      sortByStackUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackUid', Sort.desc);
    });
  }
}

extension CompletionLogQuerySortThenBy
    on QueryBuilder<CompletionLog, CompletionLog, QSortThenBy> {
  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> thenByMoodScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy>
      thenByMoodScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.desc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy> thenByStackUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackUid', Sort.asc);
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QAfterSortBy>
      thenByStackUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackUid', Sort.desc);
    });
  }
}

extension CompletionLogQueryWhereDistinct
    on QueryBuilder<CompletionLog, CompletionLog, QDistinct> {
  QueryBuilder<CompletionLog, CompletionLog, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QDistinct> distinctByMoodScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodScore');
    });
  }

  QueryBuilder<CompletionLog, CompletionLog, QDistinct> distinctByStackUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stackUid', caseSensitive: caseSensitive);
    });
  }
}

extension CompletionLogQueryProperty
    on QueryBuilder<CompletionLog, CompletionLog, QQueryProperty> {
  QueryBuilder<CompletionLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompletionLog, DateTime, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<CompletionLog, int, QQueryOperations> moodScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodScore');
    });
  }

  QueryBuilder<CompletionLog, String, QQueryOperations> stackUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stackUid');
    });
  }
}
