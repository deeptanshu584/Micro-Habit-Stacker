// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_stack.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHabitStackCollection on Isar {
  IsarCollection<HabitStack> get habitStacks => this.collection();
}

const HabitStackSchema = CollectionSchema(
  name: r'HabitStack',
  id: 1833030079260519367,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'colorIndex': PropertySchema(
      id: 1,
      name: r'colorIndex',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'emoji': PropertySchema(
      id: 3,
      name: r'emoji',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 4,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'newHabit': PropertySchema(
      id: 5,
      name: r'newHabit',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 6,
      name: r'order',
      type: IsarType.long,
    ),
    r'reminderHour': PropertySchema(
      id: 7,
      name: r'reminderHour',
      type: IsarType.long,
    ),
    r'reminderMinute': PropertySchema(
      id: 8,
      name: r'reminderMinute',
      type: IsarType.long,
    ),
    r'streakFreezeEnabled': PropertySchema(
      id: 9,
      name: r'streakFreezeEnabled',
      type: IsarType.bool,
    ),
    r'triggerHabit': PropertySchema(
      id: 10,
      name: r'triggerHabit',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 11,
      name: r'uid',
      type: IsarType.string,
    )
  },
  estimateSize: _habitStackEstimateSize,
  serialize: _habitStackSerialize,
  deserialize: _habitStackDeserialize,
  deserializeProp: _habitStackDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _habitStackGetId,
  getLinks: _habitStackGetLinks,
  attach: _habitStackAttach,
  version: '3.1.0+1',
);

int _habitStackEstimateSize(
  HabitStack object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.emoji.length * 3;
  bytesCount += 3 + object.newHabit.length * 3;
  bytesCount += 3 + object.triggerHabit.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _habitStackSerialize(
  HabitStack object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeLong(offsets[1], object.colorIndex);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.emoji);
  writer.writeBool(offsets[4], object.isActive);
  writer.writeString(offsets[5], object.newHabit);
  writer.writeLong(offsets[6], object.order);
  writer.writeLong(offsets[7], object.reminderHour);
  writer.writeLong(offsets[8], object.reminderMinute);
  writer.writeBool(offsets[9], object.streakFreezeEnabled);
  writer.writeString(offsets[10], object.triggerHabit);
  writer.writeString(offsets[11], object.uid);
}

HabitStack _habitStackDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HabitStack();
  object.category = reader.readString(offsets[0]);
  object.colorIndex = reader.readLong(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.emoji = reader.readString(offsets[3]);
  object.id = id;
  object.isActive = reader.readBool(offsets[4]);
  object.newHabit = reader.readString(offsets[5]);
  object.order = reader.readLong(offsets[6]);
  object.reminderHour = reader.readLong(offsets[7]);
  object.reminderMinute = reader.readLong(offsets[8]);
  object.streakFreezeEnabled = reader.readBool(offsets[9]);
  object.triggerHabit = reader.readString(offsets[10]);
  object.uid = reader.readString(offsets[11]);
  return object;
}

P _habitStackDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _habitStackGetId(HabitStack object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _habitStackGetLinks(HabitStack object) {
  return [];
}

void _habitStackAttach(IsarCollection<dynamic> col, Id id, HabitStack object) {
  object.id = id;
}

extension HabitStackQueryWhereSort
    on QueryBuilder<HabitStack, HabitStack, QWhere> {
  QueryBuilder<HabitStack, HabitStack, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HabitStackQueryWhere
    on QueryBuilder<HabitStack, HabitStack, QWhereClause> {
  QueryBuilder<HabitStack, HabitStack, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<HabitStack, HabitStack, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterWhereClause> idBetween(
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

extension HabitStackQueryFilter
    on QueryBuilder<HabitStack, HabitStack, QFilterCondition> {
  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> colorIndexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      colorIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      colorIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> colorIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emoji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emoji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> emojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emoji',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      emojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emoji',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> newHabitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      newHabitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> newHabitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> newHabitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newHabit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      newHabitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> newHabitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> newHabitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> newHabitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newHabit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      newHabitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newHabit',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      newHabitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newHabit',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> orderEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderMinuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderMinuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      reminderMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      streakFreezeEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakFreezeEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggerHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'triggerHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'triggerHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'triggerHabit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'triggerHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'triggerHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'triggerHabit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'triggerHabit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggerHabit',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition>
      triggerHabitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'triggerHabit',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }
}

extension HabitStackQueryObject
    on QueryBuilder<HabitStack, HabitStack, QFilterCondition> {}

extension HabitStackQueryLinks
    on QueryBuilder<HabitStack, HabitStack, QFilterCondition> {}

extension HabitStackQuerySortBy
    on QueryBuilder<HabitStack, HabitStack, QSortBy> {
  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByColorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorIndex', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByColorIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorIndex', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByNewHabit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newHabit', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByNewHabitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newHabit', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderHour', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByReminderHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderHour', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByReminderMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinute', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy>
      sortByReminderMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinute', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy>
      sortByStreakFreezeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakFreezeEnabled', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy>
      sortByStreakFreezeEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakFreezeEnabled', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByTriggerHabit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerHabit', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByTriggerHabitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerHabit', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension HabitStackQuerySortThenBy
    on QueryBuilder<HabitStack, HabitStack, QSortThenBy> {
  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByColorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorIndex', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByColorIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorIndex', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByNewHabit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newHabit', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByNewHabitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newHabit', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderHour', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByReminderHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderHour', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByReminderMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinute', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy>
      thenByReminderMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinute', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy>
      thenByStreakFreezeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakFreezeEnabled', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy>
      thenByStreakFreezeEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakFreezeEnabled', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByTriggerHabit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerHabit', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByTriggerHabitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerHabit', Sort.desc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension HabitStackQueryWhereDistinct
    on QueryBuilder<HabitStack, HabitStack, QDistinct> {
  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByColorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorIndex');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByEmoji(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emoji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByNewHabit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newHabit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderHour');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByReminderMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderMinute');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct>
      distinctByStreakFreezeEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakFreezeEnabled');
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByTriggerHabit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'triggerHabit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitStack, HabitStack, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension HabitStackQueryProperty
    on QueryBuilder<HabitStack, HabitStack, QQueryProperty> {
  QueryBuilder<HabitStack, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HabitStack, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<HabitStack, int, QQueryOperations> colorIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorIndex');
    });
  }

  QueryBuilder<HabitStack, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<HabitStack, String, QQueryOperations> emojiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emoji');
    });
  }

  QueryBuilder<HabitStack, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<HabitStack, String, QQueryOperations> newHabitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newHabit');
    });
  }

  QueryBuilder<HabitStack, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<HabitStack, int, QQueryOperations> reminderHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderHour');
    });
  }

  QueryBuilder<HabitStack, int, QQueryOperations> reminderMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderMinute');
    });
  }

  QueryBuilder<HabitStack, bool, QQueryOperations>
      streakFreezeEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakFreezeEnabled');
    });
  }

  QueryBuilder<HabitStack, String, QQueryOperations> triggerHabitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'triggerHabit');
    });
  }

  QueryBuilder<HabitStack, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
