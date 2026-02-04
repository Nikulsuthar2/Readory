import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/book_model.dart';
import '../models/annotation_model.dart';
import '../../domain/entities/annotation_entity.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepositoryImpl(ref.watch(localDataSourceProvider));
});

class BookRepositoryImpl implements BookRepository {
  final LocalDataSource _localDataSource;

  BookRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks() async {
    try {
      final models = await _localDataSource.getAllBooks();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<BookEntity>> watchAllBooks() {
    return _localDataSource.watchAllBooks().map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }

  @override
  Future<Either<Failure, void>> addBook(BookEntity book) async {
    try {
      await _localDataSource.saveBook(BookModelMapper.fromEntity(book));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity?>> getBookById(String id) async {
    try {
      final model = await _localDataSource.getBookByHash(id);
      return Right(model?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<BookEntity?> watchBookById(String id) {
    return _localDataSource.watchBookByHash(id).map((model) => model?.toEntity());
  }
  @override
  Future<Either<Failure, void>> deleteBooksByDirectory(String directoryPath) async {
    try {
      await _localDataSource.deleteBooksByDirectory(directoryPath);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  // Annotations
  @override
  Future<Either<Failure, void>> addAnnotation(AnnotationEntity annotation) async {
    try {
      await _localDataSource.saveAnnotation(AnnotationModelMapper.fromEntity(annotation));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAnnotation(String id) async {
    try {
      // Isar IDs are ints, but Entity uses String for flexibility. 
      // We assume ID is int parsed for now, or use mapped ID logic.
      // For MVP: assume parsing works if created by us.
      // Wait, Isar autoIncrement ID is int. Entity ID is String. 
      // We should parse it.
      await _localDataSource.deleteAnnotation(int.parse(id));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<AnnotationEntity>> watchAnnotationsForBook(String bookId) {
    return _localDataSource.watchAnnotationsForBook(bookId).map(
      (models) => models.map((m) => m.toEntity()).toList(),
    );
  }
}

extension BookModelMapper on BookModel {
  BookEntity toEntity() {
    return BookEntity(
      id: fileHash,
      title: title,
      author: author,
      filePath: filePath,
      coverPath: coverPath,
      progress: progress,
      isSynced: isSynced,
      isFavorite: isFavorite,
      isDeleted: isDeleted,
      lastReadPage: lastReadPage,
      totalPages: totalPages,
      lastReadTime: lastReadTime,
      readingStatus: status,
      collections: collections,
      bookmarks: bookmarks,
      devicePath: devicePath,
      aspectRatio: aspectRatio,
    );
  }

  static BookModel fromEntity(BookEntity entity) {
    return BookModel()
      ..fileHash = entity.id
      ..title = entity.title
      ..author = entity.author
      ..filePath = entity.filePath
      ..coverPath = entity.coverPath
      ..progress = entity.progress
      ..isSynced = entity.isSynced
      ..isFavorite = entity.isFavorite
      ..isDeleted = entity.isDeleted
      ..lastReadTime = entity.lastReadTime ?? DateTime.now()
      ..lastReadPage = entity.lastReadPage
      ..totalPages = entity.totalPages
      ..status = entity.readingStatus
      ..collections = entity.collections
      ..bookmarks = entity.bookmarks
      ..devicePath = entity.devicePath
      ..aspectRatio = entity.aspectRatio
      ..format = BookFormat.pdf; // Default for now
  }
}

extension AnnotationModelMapper on AnnotationModel {
  AnnotationEntity toEntity() {
    return AnnotationEntity(
      id: id.toString(),
      bookId: bookHash,
      pageNumber: pageNumber,
      content: content,
      selectedText: selectedText,
      color: color,
      rects: rects,
      createdAt: createdAt,
    );
  }

  static AnnotationModel fromEntity(AnnotationEntity entity) {
    return AnnotationModel()
      ..id = int.tryParse(entity.id) ?? Isar.autoIncrement
      ..bookHash = entity.bookId
      ..pageNumber = entity.pageNumber
      ..content = entity.content
      ..selectedText = entity.selectedText
      ..color = entity.color
      ..rects = entity.rects
      ..createdAt = entity.createdAt; 
  }
}
