import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/database_provider.dart';
import '../models/book_model.dart';
import '../models/collection_model.dart';
import '../models/annotation_model.dart';

class LocalDataSource {
  final Future<Isar?> _isarFuture;

  LocalDataSource(this._isarFuture);

  Future<Isar> _getIsar() async {
    final isar = await _isarFuture;
    if (isar == null) {
      throw Exception("Local database not available (User logged out or database not initialized)");
    }
    return isar;
  }

  Future<void> saveBook(BookModel book) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.bookModels.put(book);
    });
  }

  Future<List<BookModel>> getAllBooks() async {
    try {
      final isar = await _getIsar();
      return await isar.bookModels.where().findAll();
    } catch (e) {
      if (e.toString().contains("logged out")) return [];
      rethrow;
    }
  }

  Future<BookModel?> getBookByHash(String hash) async {
     try {
      final isar = await _getIsar();
      return await isar.bookModels.filter().fileHashEqualTo(hash).findFirst();
    } catch (e) {
       return null;
    }
  }

  Stream<BookModel?> watchBookByHash(String hash) async* {
    try {
      final isar = await _getIsar();
      yield* isar.bookModels.filter().fileHashEqualTo(hash).watch(fireImmediately: true).map((events) {
        return events.isNotEmpty ? events.first : null;
      });
    } catch (_) {
      yield null;
    }
  }

  Stream<List<BookModel>> watchAllBooks() async* {
    try {
      final isar = await _getIsar();
      yield* isar.bookModels.where().watch(fireImmediately: true);
    } catch (_) {
      yield [];
    }
  }

  Future<void> deleteBooksByDirectory(String directoryPath) async {
    try {
      final isar = await _getIsar();
      await isar.writeTxn(() async {
        await isar.bookModels.filter().filePathStartsWith(directoryPath).deleteAll();
      });
    } catch (_) {
      // Ignore
    }
  }

  // Collections
  Future<void> saveCollection(CollectionModel collection) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.collectionModels.put(collection);
    });
  }

  Future<List<CollectionModel>> getAllCollections() async {
    try {
      final isar = await _getIsar();
      return await isar.collectionModels.where().findAll();
    } catch (_) {
      return [];
    }
  }

  Stream<List<CollectionModel>> watchAllCollections() async* {
    try {
      final isar = await _getIsar();
      yield* isar.collectionModels.where().watch(fireImmediately: true);
    } catch (_) {
      yield [];
    }
  }

  Future<void> deleteCollection(int id) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.collectionModels.delete(id);
    });
  }

  // Annotations
  Future<void> saveAnnotation(AnnotationModel annotation) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.annotationModels.put(annotation);
    });
  }

  Future<void> deleteAnnotation(int id) async {
    final isar = await _getIsar();
    await isar.writeTxn(() async {
      await isar.annotationModels.delete(id);
    });
  }

  Stream<List<AnnotationModel>> watchAnnotationsForBook(String bookHash) async* {
    try {
      final isar = await _getIsar();
      yield* isar.annotationModels.filter().bookHashEqualTo(bookHash).watch(fireImmediately: true);
    } catch (_) {
      yield [];
    }
  }
}

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSource(ref.watch(databaseProvider.future));
});
