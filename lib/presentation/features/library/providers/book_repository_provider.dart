import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';

final bookRepositoryProvider = Provider<BookRepositoryImpl>((ref) {
  return BookRepositoryImpl(ref.watch(localDataSourceProvider));
});
