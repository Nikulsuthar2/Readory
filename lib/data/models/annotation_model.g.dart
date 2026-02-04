// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnnotationModelCollection on Isar {
  IsarCollection<AnnotationModel> get annotationModels => this.collection();
}

const AnnotationModelSchema = CollectionSchema(
  name: r'AnnotationModel',
  id: -4767716713824313336,
  properties: {
    r'bookHash': PropertySchema(
      id: 0,
      name: r'bookHash',
      type: IsarType.string,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.string,
    ),
    r'content': PropertySchema(
      id: 2,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'pageNumber': PropertySchema(
      id: 4,
      name: r'pageNumber',
      type: IsarType.long,
    ),
    r'rects': PropertySchema(
      id: 5,
      name: r'rects',
      type: IsarType.stringList,
    ),
    r'selectedText': PropertySchema(
      id: 6,
      name: r'selectedText',
      type: IsarType.string,
    )
  },
  estimateSize: _annotationModelEstimateSize,
  serialize: _annotationModelSerialize,
  deserialize: _annotationModelDeserialize,
  deserializeProp: _annotationModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'bookHash': IndexSchema(
      id: 9219731963688214696,
      name: r'bookHash',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'bookHash',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _annotationModelGetId,
  getLinks: _annotationModelGetLinks,
  attach: _annotationModelAttach,
  version: '3.1.0+1',
);

int _annotationModelEstimateSize(
  AnnotationModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bookHash.length * 3;
  bytesCount += 3 + object.color.length * 3;
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.rects.length * 3;
  {
    for (var i = 0; i < object.rects.length; i++) {
      final value = object.rects[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.selectedText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _annotationModelSerialize(
  AnnotationModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bookHash);
  writer.writeString(offsets[1], object.color);
  writer.writeString(offsets[2], object.content);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.pageNumber);
  writer.writeStringList(offsets[5], object.rects);
  writer.writeString(offsets[6], object.selectedText);
}

AnnotationModel _annotationModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnnotationModel();
  object.bookHash = reader.readString(offsets[0]);
  object.color = reader.readString(offsets[1]);
  object.content = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.id = id;
  object.pageNumber = reader.readLong(offsets[4]);
  object.rects = reader.readStringList(offsets[5]) ?? [];
  object.selectedText = reader.readStringOrNull(offsets[6]);
  return object;
}

P _annotationModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _annotationModelGetId(AnnotationModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _annotationModelGetLinks(AnnotationModel object) {
  return [];
}

void _annotationModelAttach(
    IsarCollection<dynamic> col, Id id, AnnotationModel object) {
  object.id = id;
}

extension AnnotationModelQueryWhereSort
    on QueryBuilder<AnnotationModel, AnnotationModel, QWhere> {
  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnnotationModelQueryWhere
    on QueryBuilder<AnnotationModel, AnnotationModel, QWhereClause> {
  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause>
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause>
      bookHashEqualTo(String bookHash) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'bookHash',
        value: [bookHash],
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterWhereClause>
      bookHashNotEqualTo(String bookHash) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookHash',
              lower: [],
              upper: [bookHash],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookHash',
              lower: [bookHash],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookHash',
              lower: [bookHash],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookHash',
              lower: [],
              upper: [bookHash],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AnnotationModelQueryFilter
    on QueryBuilder<AnnotationModel, AnnotationModel, QFilterCondition> {
  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookHash',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      bookHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookHash',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
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

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      pageNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      pageNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      pageNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      pageNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rects',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rects',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rects',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rects',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rects',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rects',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rects',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rects',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rects',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rects',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rects',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rects',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rects',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rects',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rects',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      rectsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rects',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedText',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedText',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selectedText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedText',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterFilterCondition>
      selectedTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedText',
        value: '',
      ));
    });
  }
}

extension AnnotationModelQueryObject
    on QueryBuilder<AnnotationModel, AnnotationModel, QFilterCondition> {}

extension AnnotationModelQueryLinks
    on QueryBuilder<AnnotationModel, AnnotationModel, QFilterCondition> {}

extension AnnotationModelQuerySortBy
    on QueryBuilder<AnnotationModel, AnnotationModel, QSortBy> {
  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByBookHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookHash', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByBookHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookHash', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortBySelectedText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedText', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      sortBySelectedTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedText', Sort.desc);
    });
  }
}

extension AnnotationModelQuerySortThenBy
    on QueryBuilder<AnnotationModel, AnnotationModel, QSortThenBy> {
  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByBookHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookHash', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByBookHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookHash', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenBySelectedText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedText', Sort.asc);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QAfterSortBy>
      thenBySelectedTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedText', Sort.desc);
    });
  }
}

extension AnnotationModelQueryWhereDistinct
    on QueryBuilder<AnnotationModel, AnnotationModel, QDistinct> {
  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct> distinctByBookHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct>
      distinctByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageNumber');
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct> distinctByRects() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rects');
    });
  }

  QueryBuilder<AnnotationModel, AnnotationModel, QDistinct>
      distinctBySelectedText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedText', caseSensitive: caseSensitive);
    });
  }
}

extension AnnotationModelQueryProperty
    on QueryBuilder<AnnotationModel, AnnotationModel, QQueryProperty> {
  QueryBuilder<AnnotationModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnnotationModel, String, QQueryOperations> bookHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookHash');
    });
  }

  QueryBuilder<AnnotationModel, String, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<AnnotationModel, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<AnnotationModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AnnotationModel, int, QQueryOperations> pageNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageNumber');
    });
  }

  QueryBuilder<AnnotationModel, List<String>, QQueryOperations>
      rectsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rects');
    });
  }

  QueryBuilder<AnnotationModel, String?, QQueryOperations>
      selectedTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedText');
    });
  }
}
