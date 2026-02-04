import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../domain/entities/book_entity.dart';
import '../providers/book_repository_provider.dart';

part 'library_controller.g.dart';

@riverpod
class LibraryController extends _$LibraryController {
  @override
  FutureOr<List<BookEntity>> build() async {
    final result = await ref.read(bookRepositoryProvider).getBooks();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (books) => books,
    );
  }

  Future<void> scanDirectory(String path) async {
    state = const AsyncLoading();
    final result = await ref.read(bookRepositoryProvider).scanDirectory(path);
    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (success) {
        // Refresh the list
        ref.invalidateSelf();
      },
    );
  }
}
