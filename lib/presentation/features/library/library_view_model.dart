import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readory/domain/entities/book_entity.dart';
import 'package:readory/domain/repositories/book_repository.dart';
import 'package:readory/data/repositories/book_repository_impl.dart';
import 'package:readory/domain/usecases/scan_books_usecase.dart';

final libraryViewModelProvider = AsyncNotifierProvider<LibraryViewModel, List<BookEntity>>(() {
  return LibraryViewModel();
});

enum SortOption {
  recent,
  title,
  author,
  progress,
}

class LibraryViewModel extends AsyncNotifier<List<BookEntity>> {
  late BookRepository _repository;
  late ScanBooksUseCase _scanBooksUseCase;
  
  // Local state for filter/sort
  String _searchQuery = '';
  SortOption _sortOption = SortOption.recent;
  bool _ascending = false; // Default desc for recent

  @override
  FutureOr<List<BookEntity>> build() async {
    _repository = ref.watch(bookRepositoryProvider);
    _scanBooksUseCase = ref.watch(scanBooksUseCaseProvider);
    
    // Subscribe to changes
    final stream = _repository.watchAllBooks();
    final subscription = stream.listen((books) {
      // When db updates, we need to apply current filters
      state = AsyncValue.data(_applyFilters(books));
    });
    
    ref.onDispose(() => subscription.cancel());
    
    // Initial fetch
    final result = await _repository.getAllBooks();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (books) => _applyFilters(books),
    );
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _refreshState();
  }

  void setSortOption(SortOption option, {bool ascending = true}) {
    _sortOption = option;
    _ascending = ascending;
    _refreshState();
  }

  Future<void> _refreshState() async {
     // Fetch fresh list from repo (or keep local cache if preferred, but repo is source of truth)
     // For simplicity, we re-fetch to ensure we filter on latest data. 
     // Optimization: Cache 'allBooks' locally in class and filter that instead of re-fetching.
     
     final result = await _repository.getAllBooks();
     result.fold(
       (l) => state = AsyncValue.error(l, StackTrace.current),
       (r) => state = AsyncValue.data(_applyFilters(r)),
     );
  }

  List<BookEntity> _applyFilters(List<BookEntity> books) {
    var filtered = books;
    
    // 0. Base Filter (Deleted vs Not Deleted)
    // By default, we hide deleted books unless we are specifically looking for them?
    // Actually, let VM consumers handle this via specific getters or arguments? 
    // For now, let's say the VM exposes the "Main Library" view by default.
    // We will trust the UI to filter, OR we add state flags here.
    // Let's rely on the UI passing a filter, or we modify this method to take optional params?
    // Better: _applyFilters runs on the raw list.
    // The consumer (UI) gets the full list.
    // Wait, if I filter here, the UI gets a filtered list.
    // Correct approach: The VM should expose the *entire* list (or a specific filtered stream).
    // Let's keep the VM providing a generic filtered list based on Search/Sort, 
    // BUT we must handle the `isDeleted` logic. 
    // Standard Library View: isDeleted == false.
    // Trash View: isDeleted == true.
    
    // Just return all books here, but apply Search/Sort. 
    // The UI (LibraryScreen) decides whether to show deleted or favorites.
    // OR: we move that logic here. 
    
    // Let's filtering logic remain basic (Search/Sort).
    // UI will filter `if (widget.showDeleted) ...`.
    
    // 1. Search
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = books.where((b) => 
        b.title.toLowerCase().contains(q) || 
        b.author.toLowerCase().contains(q)
      ).toList();
    }

    // 2. Sort
    filtered.sort((a, b) {
      int cmp = 0;
      switch (_sortOption) {
        case SortOption.title:
          cmp = a.title.compareTo(b.title);
          break;
        case SortOption.author:
          cmp = a.author.compareTo(b.author);
          break;
        case SortOption.progress:
          cmp = a.progress.compareTo(b.progress);
          break;
        case SortOption.recent:
        default:
          final dateA = a.lastReadTime ?? DateTime(0);
          final dateB = b.lastReadTime ?? DateTime(0);
          cmp = dateA.compareTo(dateB);
          break;
      }
      return _ascending ? cmp : -cmp;
    });

    return filtered;
  }

  Future<void> updateBook(BookEntity book) async {
    try {
      final result = await _repository.addBook(book);
      result.fold(
        (l) => state = AsyncValue.error(l.message, StackTrace.current),
        (r) {
           // Success. The stream will handle the update, or we can refresh.
           // _refreshState();
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> importBooks() async {
    state = const AsyncValue.loading();
    try {
      final addedCount = await _scanBooksUseCase.pickAndAddDirectory();
      if (addedCount > 0) {
        // Stream handles update
      } else {
         _refreshState();
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
