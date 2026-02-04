import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../../domain/repositories/collection_repository.dart';
import '../../../data/repositories/collection_repository_impl.dart';

final collectionsViewModelProvider = AsyncNotifierProvider<CollectionsViewModel, List<CollectionEntity>>(() {
  return CollectionsViewModel();
});

class CollectionsViewModel extends AsyncNotifier<List<CollectionEntity>> {
  late final CollectionRepository _repository;

  @override
  FutureOr<List<CollectionEntity>> build() async {
    _repository = ref.watch(collectionRepositoryProvider);
    
    // Subscribe
    final stream = _repository.watchAllCollections();
    final sub = stream.listen((data) {
      state = AsyncValue.data(data);
    });
    ref.onDispose(sub.cancel);
    
    final result = await _repository.getAllCollections();
    return result.fold(
      (l) => throw Exception(l.message),
      (r) => r,
    );
  }

  Future<void> createCollection(String name) async {
    await _repository.createCollection(name);
  }

  Future<void> deleteCollection(String id) async {
    await _repository.deleteCollection(id);
  }
}
