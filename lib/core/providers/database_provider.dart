import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/datasources/local/isar_service.dart';
import '../../data/models/book_model.dart';
import '../../data/models/collection_model.dart';
import '../../data/models/annotation_model.dart';
import '../../presentation/features/auth/providers/auth_dependencies_provider.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final databaseProvider = FutureProvider<Isar?>((ref) async {
  final authState = ref.watch(authStateChangesProvider);
  
  return authState.when(
    data: (user) async {
      if (user != null) {
        final dir = await getApplicationDocumentsDirectory();
        return await Isar.open(
          [BookModelSchema, CollectionModelSchema, AnnotationModelSchema],
          directory: dir.path,
        );
      } else {
        return null; 
      }
    },
    loading: () => null,
    error: (e, s) => throw e,
  );
});
