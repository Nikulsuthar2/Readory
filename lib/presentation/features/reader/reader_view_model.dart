import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/repositories/book_repository.dart';
import '../../../../data/repositories/book_repository_impl.dart';
import '../../../../domain/entities/annotation_entity.dart';

enum ReaderTheme {
  day,
  night,
  sepia,
  twilight
}

class ReaderState {
  final int currentPage;
  final int totalPages;
  final bool showControls;
  final ReaderTheme theme;
  final List<int> bookmarks;
  final Axis scrollDirection;
  final List<AnnotationEntity> annotations;
  final bool isDarkMode; // Kept for backward compat calculation, derived

  ReaderState({
    this.currentPage = 1,
    this.totalPages = 0,
    this.showControls = true,
    this.theme = ReaderTheme.day,
    this.bookmarks = const [],
    this.scrollDirection = Axis.vertical,
    this.annotations = const [],
  }) : isDarkMode = theme == ReaderTheme.night;

  ReaderState copyWith({
    int? currentPage,
    int? totalPages,
    bool? showControls,
    ReaderTheme? theme,
    List<int>? bookmarks,
    Axis? scrollDirection,
    List<AnnotationEntity>? annotations,
  }) {
    return ReaderState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      showControls: showControls ?? this.showControls,
      theme: theme ?? this.theme,
      bookmarks: bookmarks ?? this.bookmarks,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      annotations: annotations ?? this.annotations,
    );
  }
}

class ReaderViewModel extends StateNotifier<ReaderState> {
  final BookRepository _repository;
  final BookEntity book;

  ReaderViewModel(this._repository, this.book) 
      : super(ReaderState(
          currentPage: book.lastReadPage > 0 ? book.lastReadPage : 1,
          totalPages: book.totalPages,
          bookmarks: book.bookmarks,
        )) {
      _watchAnnotations();
  }

  void _watchAnnotations() {
    _repository.watchAnnotationsForBook(book.id).listen((annotations) {
      state = state.copyWith(annotations: annotations);
    });
  }

  void onPageChanged(int page) {
    if (page != state.currentPage) {
      state = state.copyWith(currentPage: page);
      // Save progress to DB immediately (Isar is fast)
      saveProgress(); 
    }
  }

  Future<void> setTotalPages(int total) async {
    state = state.copyWith(totalPages: total);
    // Initial save to update reading status
    await saveProgress();
  }

  void toggleControls() {
    state = state.copyWith(showControls: !state.showControls);
  }

  void setTheme(ReaderTheme theme) {
    state = state.copyWith(theme: theme);
  }
  
  // Deprecated: Only used for quick toggles if needed, but UI will likely use setTheme
  void toggleTheme() {
    state = state.copyWith(
      theme: state.theme == ReaderTheme.day ? ReaderTheme.night : ReaderTheme.day
    );
  }

  void toggleScrollDirection() {
    state = state.copyWith(
      scrollDirection: state.scrollDirection == Axis.vertical 
          ? Axis.horizontal 
          : Axis.vertical
    );
  }

  Future<void> saveProgress() async {
    // Save last read page
    // Save last read page
    final updated = book.copyWith(
       lastReadPage: state.currentPage,
       bookmarks: state.bookmarks,
       // IMPORTANT: Persist total pages
       totalPages: state.totalPages > 0 ? state.totalPages : book.totalPages,
       progress: state.totalPages > 0 ? state.currentPage / state.totalPages : book.progress,
       lastReadTime: DateTime.now(),
       readingStatus: ReadingStatus.reading, 
    );
    await _repository.addBook(updated); // addBook doubles as update in upsert model logic usually
  }

  Future<void> toggleBookmark() async {
    final current = state.currentPage;
    final List<int> newBookmarks = List.from(state.bookmarks);
    if (newBookmarks.contains(current)) {
      newBookmarks.remove(current);
    } else {
      newBookmarks.add(current);
      newBookmarks.sort();
    }
    state = state.copyWith(bookmarks: newBookmarks);
    await saveProgress();
  }

  Future<void> addAnnotation(String content, {String? color}) async {
    final annotation = AnnotationEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temp ID gen
      bookId: book.id,
      pageNumber: state.currentPage,
      content: content,
      color: color ?? '#FFEB3B',
      createdAt: DateTime.now(),
    );
    await _repository.addAnnotation(annotation);
  }
  
  Future<void> addAnnotationEntity(AnnotationEntity annotation) async {
    await _repository.addAnnotation(annotation);
  }
}

final readerViewModelProvider = StateNotifierProvider.family<ReaderViewModel, ReaderState, BookEntity>((ref, book) {
  return ReaderViewModel(ref.watch(bookRepositoryProvider), book);
});
