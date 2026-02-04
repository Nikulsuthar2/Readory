import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../entities/book_entity.dart';
import '../entities/annotation_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getAllBooks();
  Stream<List<BookEntity>> watchAllBooks();
  Future<Either<Failure, void>> addBook(BookEntity book);
  Future<Either<Failure, BookEntity?>> getBookById(String id);
  Stream<BookEntity?> watchBookById(String id);
  Future<Either<Failure, void>> deleteBooksByDirectory(String directoryPath);
  
  // Annotations
  Future<Either<Failure, void>> addAnnotation(AnnotationEntity annotation);
  Future<Either<Failure, void>> deleteAnnotation(String id);
  Stream<List<AnnotationEntity>> watchAnnotationsForBook(String bookId);
}
