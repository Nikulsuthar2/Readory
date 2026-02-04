// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookModelCollection on Isar {
  IsarCollection<BookModel> get bookModels => this.collection();
}

const BookModelSchema = CollectionSchema(
  name: r'BookModel',
  id: -8798672064070329451,
  properties: {
    r'aspectRatio': PropertySchema(
      id: 0,
      name: r'aspectRatio',
      type: IsarType.double,
    ),
    r'author': PropertySchema(
      id: 1,
      name: r'author',
      type: IsarType.string,
    ),
    r'bookmarks': PropertySchema(
      id: 2,
      name: r'bookmarks',
      type: IsarType.longList,
    ),
    r'collections': PropertySchema(
      id: 3,
      name: r'collections',
      type: IsarType.stringList,
    ),
    r'coverPath': PropertySchema(
      id: 4,
      name: r'coverPath',
      type: IsarType.string,
    ),
    r'devicePath': PropertySchema(
      id: 5,
      name: r'devicePath',
      type: IsarType.string,
    ),
    r'fileHash': PropertySchema(
      id: 6,
      name: r'fileHash',
      type: IsarType.string,
    ),
    r'filePath': PropertySchema(
      id: 7,
      name: r'filePath',
      type: IsarType.string,
    ),
    r'format': PropertySchema(
      id: 8,
      name: r'format',
      type: IsarType.string,
      enumMap: _BookModelformatEnumValueMap,
    ),
    r'isDeleted': PropertySchema(
      id: 9,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'isFavorite': PropertySchema(
      id: 10,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 11,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'lastReadPage': PropertySchema(
      id: 12,
      name: r'lastReadPage',
      type: IsarType.long,
    ),
    r'lastReadTime': PropertySchema(
      id: 13,
      name: r'lastReadTime',
      type: IsarType.dateTime,
    ),
    r'progress': PropertySchema(
      id: 14,
      name: r'progress',
      type: IsarType.double,
    ),
    r'status': PropertySchema(
      id: 15,
      name: r'status',
      type: IsarType.string,
      enumMap: _BookModelstatusEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 16,
      name: r'title',
      type: IsarType.string,
    ),
    r'totalPages': PropertySchema(
      id: 17,
      name: r'totalPages',
      type: IsarType.long,
    )
  },
  estimateSize: _bookModelEstimateSize,
  serialize: _bookModelSerialize,
  deserialize: _bookModelDeserialize,
  deserializeProp: _bookModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'fileHash': IndexSchema(
      id: -5944002318434853925,
      name: r'fileHash',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'fileHash',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _bookModelGetId,
  getLinks: _bookModelGetLinks,
  attach: _bookModelAttach,
  version: '3.1.0+1',
);

int _bookModelEstimateSize(
  BookModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.author.length * 3;
  bytesCount += 3 + object.bookmarks.length * 8;
  bytesCount += 3 + object.collections.length * 3;
  {
    for (var i = 0; i < object.collections.length; i++) {
      final value = object.collections[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.coverPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.devicePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fileHash.length * 3;
  bytesCount += 3 + object.filePath.length * 3;
  bytesCount += 3 + object.format.name.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _bookModelSerialize(
  BookModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.aspectRatio);
  writer.writeString(offsets[1], object.author);
  writer.writeLongList(offsets[2], object.bookmarks);
  writer.writeStringList(offsets[3], object.collections);
  writer.writeString(offsets[4], object.coverPath);
  writer.writeString(offsets[5], object.devicePath);
  writer.writeString(offsets[6], object.fileHash);
  writer.writeString(offsets[7], object.filePath);
  writer.writeString(offsets[8], object.format.name);
  writer.writeBool(offsets[9], object.isDeleted);
  writer.writeBool(offsets[10], object.isFavorite);
  writer.writeBool(offsets[11], object.isSynced);
  writer.writeLong(offsets[12], object.lastReadPage);
  writer.writeDateTime(offsets[13], object.lastReadTime);
  writer.writeDouble(offsets[14], object.progress);
  writer.writeString(offsets[15], object.status.name);
  writer.writeString(offsets[16], object.title);
  writer.writeLong(offsets[17], object.totalPages);
}

BookModel _bookModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookModel();
  object.aspectRatio = reader.readDoubleOrNull(offsets[0]);
  object.author = reader.readString(offsets[1]);
  object.bookmarks = reader.readLongList(offsets[2]) ?? [];
  object.collections = reader.readStringList(offsets[3]) ?? [];
  object.coverPath = reader.readStringOrNull(offsets[4]);
  object.devicePath = reader.readStringOrNull(offsets[5]);
  object.fileHash = reader.readString(offsets[6]);
  object.filePath = reader.readString(offsets[7]);
  object.format =
      _BookModelformatValueEnumMap[reader.readStringOrNull(offsets[8])] ??
          BookFormat.pdf;
  object.id = id;
  object.isDeleted = reader.readBool(offsets[9]);
  object.isFavorite = reader.readBool(offsets[10]);
  object.isSynced = reader.readBool(offsets[11]);
  object.lastReadPage = reader.readLong(offsets[12]);
  object.lastReadTime = reader.readDateTime(offsets[13]);
  object.progress = reader.readDouble(offsets[14]);
  object.status =
      _BookModelstatusValueEnumMap[reader.readStringOrNull(offsets[15])] ??
          ReadingStatus.none;
  object.title = reader.readString(offsets[16]);
  object.totalPages = reader.readLong(offsets[17]);
  return object;
}

P _bookModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (_BookModelformatValueEnumMap[reader.readStringOrNull(offset)] ??
          BookFormat.pdf) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (_BookModelstatusValueEnumMap[reader.readStringOrNull(offset)] ??
          ReadingStatus.none) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BookModelformatEnumValueMap = {
  r'pdf': r'pdf',
  r'epub': r'epub',
};
const _BookModelformatValueEnumMap = {
  r'pdf': BookFormat.pdf,
  r'epub': BookFormat.epub,
};
const _BookModelstatusEnumValueMap = {
  r'none': r'none',
  r'reading': r'reading',
  r'completed': r'completed',
  r'wantToRead': r'wantToRead',
};
const _BookModelstatusValueEnumMap = {
  r'none': ReadingStatus.none,
  r'reading': ReadingStatus.reading,
  r'completed': ReadingStatus.completed,
  r'wantToRead': ReadingStatus.wantToRead,
};

Id _bookModelGetId(BookModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookModelGetLinks(BookModel object) {
  return [];
}

void _bookModelAttach(IsarCollection<dynamic> col, Id id, BookModel object) {
  object.id = id;
}

extension BookModelByIndex on IsarCollection<BookModel> {
  Future<BookModel?> getByFileHash(String fileHash) {
    return getByIndex(r'fileHash', [fileHash]);
  }

  BookModel? getByFileHashSync(String fileHash) {
    return getByIndexSync(r'fileHash', [fileHash]);
  }

  Future<bool> deleteByFileHash(String fileHash) {
    return deleteByIndex(r'fileHash', [fileHash]);
  }

  bool deleteByFileHashSync(String fileHash) {
    return deleteByIndexSync(r'fileHash', [fileHash]);
  }

  Future<List<BookModel?>> getAllByFileHash(List<String> fileHashValues) {
    final values = fileHashValues.map((e) => [e]).toList();
    return getAllByIndex(r'fileHash', values);
  }

  List<BookModel?> getAllByFileHashSync(List<String> fileHashValues) {
    final values = fileHashValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'fileHash', values);
  }

  Future<int> deleteAllByFileHash(List<String> fileHashValues) {
    final values = fileHashValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'fileHash', values);
  }

  int deleteAllByFileHashSync(List<String> fileHashValues) {
    final values = fileHashValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'fileHash', values);
  }

  Future<Id> putByFileHash(BookModel object) {
    return putByIndex(r'fileHash', object);
  }

  Id putByFileHashSync(BookModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'fileHash', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFileHash(List<BookModel> objects) {
    return putAllByIndex(r'fileHash', objects);
  }

  List<Id> putAllByFileHashSync(List<BookModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'fileHash', objects, saveLinks: saveLinks);
  }
}

extension BookModelQueryWhereSort
    on QueryBuilder<BookModel, BookModel, QWhere> {
  QueryBuilder<BookModel, BookModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookModelQueryWhere
    on QueryBuilder<BookModel, BookModel, QWhereClause> {
  QueryBuilder<BookModel, BookModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<BookModel, BookModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<BookModel, BookModel, QAfterWhereClause> fileHashEqualTo(
      String fileHash) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileHash',
        value: [fileHash],
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterWhereClause> fileHashNotEqualTo(
      String fileHash) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileHash',
              lower: [],
              upper: [fileHash],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileHash',
              lower: [fileHash],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileHash',
              lower: [fileHash],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileHash',
              lower: [],
              upper: [fileHash],
              includeUpper: false,
            ));
      }
    });
  }
}

extension BookModelQueryFilter
    on QueryBuilder<BookModel, BookModel, QFilterCondition> {
  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      aspectRatioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aspectRatio',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      aspectRatioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aspectRatio',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> aspectRatioEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aspectRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      aspectRatioGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aspectRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> aspectRatioLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aspectRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> aspectRatioBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aspectRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'author',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'author',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'author',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'author',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarks',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookmarks',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookmarks',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookmarks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> bookmarksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      bookmarksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collections',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collections',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collections',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collections',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      collectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverPath',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      coverPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverPath',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      coverPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> coverPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverPath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      coverPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverPath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'devicePath',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      devicePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'devicePath',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devicePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      devicePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'devicePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'devicePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'devicePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      devicePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'devicePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'devicePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'devicePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> devicePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'devicePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      devicePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devicePath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      devicePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'devicePath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> fileHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileHash',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      fileHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileHash',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'filePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'filePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'filePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> filePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filePath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      filePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'filePath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatEqualTo(
    BookFormat value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatGreaterThan(
    BookFormat value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatLessThan(
    BookFormat value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatBetween(
    BookFormat lower,
    BookFormat upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'format',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'format',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'format',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> formatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'format',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> isDeletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> isFavoriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> lastReadPageEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadPage',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      lastReadPageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadPage',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      lastReadPageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadPage',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> lastReadPageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadPage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> lastReadTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadTime',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      lastReadTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadTime',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      lastReadTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadTime',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> lastReadTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> progressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusEqualTo(
    ReadingStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusGreaterThan(
    ReadingStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusLessThan(
    ReadingStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusBetween(
    ReadingStatus lower,
    ReadingStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleEqualTo(
    String value, {
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleGreaterThan(
    String value, {
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleLessThan(
    String value, {
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleContains(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleMatches(
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

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> totalPagesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPages',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition>
      totalPagesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPages',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> totalPagesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPages',
        value: value,
      ));
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterFilterCondition> totalPagesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookModelQueryObject
    on QueryBuilder<BookModel, BookModel, QFilterCondition> {}

extension BookModelQueryLinks
    on QueryBuilder<BookModel, BookModel, QFilterCondition> {}

extension BookModelQuerySortBy on QueryBuilder<BookModel, BookModel, QSortBy> {
  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByAspectRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspectRatio', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByAspectRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspectRatio', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByCoverPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverPath', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByCoverPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverPath', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByDevicePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devicePath', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByDevicePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devicePath', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByFileHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByFileHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByLastReadPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadPage', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByLastReadPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadPage', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByLastReadTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadTime', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByLastReadTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadTime', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByTotalPages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPages', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> sortByTotalPagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPages', Sort.desc);
    });
  }
}

extension BookModelQuerySortThenBy
    on QueryBuilder<BookModel, BookModel, QSortThenBy> {
  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByAspectRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspectRatio', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByAspectRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aspectRatio', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByCoverPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverPath', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByCoverPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverPath', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByDevicePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devicePath', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByDevicePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devicePath', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByFileHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByFileHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByLastReadPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadPage', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByLastReadPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadPage', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByLastReadTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadTime', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByLastReadTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadTime', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByTotalPages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPages', Sort.asc);
    });
  }

  QueryBuilder<BookModel, BookModel, QAfterSortBy> thenByTotalPagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPages', Sort.desc);
    });
  }
}

extension BookModelQueryWhereDistinct
    on QueryBuilder<BookModel, BookModel, QDistinct> {
  QueryBuilder<BookModel, BookModel, QDistinct> distinctByAspectRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aspectRatio');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'author', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByBookmarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarks');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByCollections() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collections');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByCoverPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByDevicePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'devicePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByFileHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByFilePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'filePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByFormat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'format', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByLastReadPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadPage');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByLastReadTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadTime');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookModel, BookModel, QDistinct> distinctByTotalPages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPages');
    });
  }
}

extension BookModelQueryProperty
    on QueryBuilder<BookModel, BookModel, QQueryProperty> {
  QueryBuilder<BookModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookModel, double?, QQueryOperations> aspectRatioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aspectRatio');
    });
  }

  QueryBuilder<BookModel, String, QQueryOperations> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'author');
    });
  }

  QueryBuilder<BookModel, List<int>, QQueryOperations> bookmarksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarks');
    });
  }

  QueryBuilder<BookModel, List<String>, QQueryOperations>
      collectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collections');
    });
  }

  QueryBuilder<BookModel, String?, QQueryOperations> coverPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverPath');
    });
  }

  QueryBuilder<BookModel, String?, QQueryOperations> devicePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'devicePath');
    });
  }

  QueryBuilder<BookModel, String, QQueryOperations> fileHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileHash');
    });
  }

  QueryBuilder<BookModel, String, QQueryOperations> filePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'filePath');
    });
  }

  QueryBuilder<BookModel, BookFormat, QQueryOperations> formatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'format');
    });
  }

  QueryBuilder<BookModel, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<BookModel, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<BookModel, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<BookModel, int, QQueryOperations> lastReadPageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadPage');
    });
  }

  QueryBuilder<BookModel, DateTime, QQueryOperations> lastReadTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadTime');
    });
  }

  QueryBuilder<BookModel, double, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<BookModel, ReadingStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<BookModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<BookModel, int, QQueryOperations> totalPagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPages');
    });
  }
}
