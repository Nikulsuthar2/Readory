import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'library_view_model.dart';
import 'widgets/book_card.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/usecases/scan_books_usecase.dart'; // To access pickAndScan
import '../../widgets/app_drawer.dart';

import 'widgets/book_list_item.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  final ReadingStatus? filterStatus;
  final String? filterAuthor;
  final bool showFavorites;
  final bool showDeleted;
  
  const LibraryScreen({
    super.key, 
    this.filterStatus,
    this.filterAuthor,
    this.showFavorites = false,
    this.showDeleted = false,
  });

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  bool _isSearching = false;
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(libraryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching 
          ? TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onChanged: (val) {
                ref.read(libraryViewModelProvider.notifier).setSearchQuery(val);
              },
            )
          : Text(_getTitle()),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                   ref.read(libraryViewModelProvider.notifier).setSearchQuery('');
                }
              });
            },
          ),
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by',
            onSelected: (option) {
              // Default to ascending for text, descending for progress/recent
              bool asc = true;
              if (option == SortOption.recent || option == SortOption.progress) {
                asc = false;
              }
              ref.read(libraryViewModelProvider.notifier).setSortOption(option, ascending: asc);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: SortOption.recent, child: Text('Last Read')),
              const PopupMenuItem(value: SortOption.title, child: Text('Title')),
              const PopupMenuItem(value: SortOption.author, child: Text('Author')),
              const PopupMenuItem(value: SortOption.progress, child: Text('Progress')),
            ],
          ),
          // Settings Icon Removed
          const SizedBox(width: 8),
        ],
      ),
      body: booksAsync.when(
        data: (books) {
          var displayBooks = books;
          
          // Filter Deleted / Not Deleted
          if (widget.showDeleted) {
             displayBooks = books.where((b) => b.isDeleted).toList();
          } else {
             displayBooks = books.where((b) => !b.isDeleted).toList();
          }

          // Filter Favorites
          if (widget.showFavorites) {
            displayBooks = displayBooks.where((b) => b.isFavorite).toList();
          }

          // Filter Status
          if (widget.filterStatus != null) {
            displayBooks = displayBooks.where((b) => b.readingStatus == widget.filterStatus).toList();
          }

          // Filter Author
          if (widget.filterAuthor != null) {
             displayBooks = displayBooks.where((b) => b.author == widget.filterAuthor).toList();
          }

          if (displayBooks.isEmpty) {
             if (widget.filterStatus != null) {
                return const Center(child: Text("No books found in this list."));
             }
             return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.library_books_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No books found'),
                  const SizedBox(height: 16),
                  if (!widget.showFavorites)
                    FilledButton.icon(
                       onPressed: () => context.push('/folders'),
                       icon: const Icon(Icons.folder_open),
                       label: const Text('Manage Folders')
                    )
                ],
              ),
            );
          }
          
          return Column(
            children: [
               // View Toggle Bar
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('${displayBooks.length} Books', style: Theme.of(context).textTheme.bodyMedium),
                     ToggleButtons(
                       isSelected: [_isGridView, !_isGridView],
                       onPressed: (index) {
                         setState(() {
                           _isGridView = index == 0;
                         });
                       },
                       constraints: const BoxConstraints(minHeight: 32, minWidth: 48),
                       borderRadius: BorderRadius.circular(8),
                       children: const [
                         Icon(Icons.grid_view, size: 20),
                         Icon(Icons.view_list, size: 20),
                       ],
                     ),
                   ],
                 ),
               ),
               Expanded(
                 child: RefreshIndicator(
                  onRefresh: () async {
                     // Optional refresh logic
                  },
                  child: _isGridView 
                    ? GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.55, // Adjusted for cover (0.7) + text
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: displayBooks.length,
                        itemBuilder: (context, index) {
                          final book = displayBooks[index];
                          return BookCard(
                            book: book,
                            onTap: () {
                              context.push('/book/${book.id}', extra: book);
                            },
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: displayBooks.length,
                        itemBuilder: (context, index) {
                           final book = displayBooks[index];
                           return BookListItem(
                             book: book,
                             onTap: () {
                               context.push('/book/${book.id}', extra: book);
                             },
                           );
                        },
                      ),
                ),
               ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
  String _getTitle() {
    if (widget.filterAuthor != null) return widget.filterAuthor!;
    if (widget.showDeleted) return 'Trash Bin';
    if (widget.showFavorites) return 'Favorites';
    if (widget.filterStatus == ReadingStatus.wantToRead) return 'Want to Read';
    if (widget.filterStatus == ReadingStatus.completed) return 'Have Read';
    return 'Library';
  }
}
