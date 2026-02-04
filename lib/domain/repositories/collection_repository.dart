import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../entities/collection_entity.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections();
  Stream<List<CollectionEntity>> watchAllCollections();
  Future<Either<Failure, void>> createCollection(String name);
  Future<Either<Failure, void>> deleteCollection(String id);
}
