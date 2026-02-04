import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/collection_entity.dart';
import '../../domain/repositories/collection_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/collection_model.dart';

final collectionRepositoryProvider = Provider<CollectionRepository>((ref) {
  return CollectionRepositoryImpl(ref.watch(localDataSourceProvider));
});

class CollectionRepositoryImpl implements CollectionRepository {
  final LocalDataSource _localDataSource;

  CollectionRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections() async {
    try {
      final models = await _localDataSource.getAllCollections();
      return Right(models.map((m) => CollectionEntity(
        id: m.id.toString(),
        name: m.name,
        isDefault: m.isDefault,
      )).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<CollectionEntity>> watchAllCollections() {
    return _localDataSource.watchAllCollections().map(
      (models) => models.map((m) => CollectionEntity(
        id: m.id.toString(),
        name: m.name,
        isDefault: m.isDefault,
      )).toList(),
    );
  }

  @override
  Future<Either<Failure, void>> createCollection(String name) async {
    try {
      final model = CollectionModel()..name = name;
      await _localDataSource.saveCollection(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCollection(String id) async {
    try {
      final intId = int.tryParse(id);
      if (intId != null) {
        await _localDataSource.deleteCollection(intId);
      }
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
