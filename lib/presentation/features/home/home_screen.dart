import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../library/library_view_model.dart';
import '../library/widgets/book_card.dart';
import '../../../domain/entities/book_entity.dart';
import '../../widgets/app_drawer.dart';

import '../library/widgets/book_list_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
                  hintText: 'Search Reading Now...',
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  ref.read(libraryViewModelProvider.notifier).setSearchQuery(val);
                },
              )
            : const Text('Readory'),
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
          ToggleButtons(
            isSelected: [_isGridView, !_isGridView],
            onPressed: (index) {
              setState(() {
                _isGridView = index == 0;
              });
            },
            constraints: const BoxConstraints(minHeight: 32, minWidth: 40),
            borderRadius: BorderRadius.circular(8),
            children: const [
               Icon(Icons.grid_view, size: 18),
               Icon(Icons.view_list, size: 18),
            ],
          ),
          const SizedBox(width: 8),
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by',
            onSelected: (option) {
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
        ],
      ),
      // drawer: const AppDrawer(), // Removed (BottomNav)
      body: booksAsync.when(
        data: (books) {
          // Filter for "Reading Now"
          final readingNow = books.where((b) => b.progress > 0 && b.progress < 1.0).toList();
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Reading Now',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              if (readingNow.isEmpty)
                _buildEmptyState(context)
              else
                _isGridView 
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: readingNow.length,
                    itemBuilder: (context, index) {
                      final book = readingNow[index];
                      return BookCard(
                        book: book,
                        onTap: () => context.push('/book/${book.id}', extra: book),
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: readingNow.length,
                    itemBuilder: (context, index) {
                       final book = readingNow[index];
                       return BookListItem(
                         book: book,
                         onTap: () => context.push('/book/${book.id}', extra: book),
                       );
                    },
                  ),
                
              const SizedBox(height: 32),
              
              Text(
                'Recently Added',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              _isGridView
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: books.take(9).length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookCard(
                      book: book,
                      onTap: () => context.push('/book/${book.id}', extra: book),
                    );
                  },
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: books.take(10).length,
                  itemBuilder: (context, index) {
                     final book = books[index];
                     return BookListItem(
                       book: book,
                       onTap: () => context.push('/book/${book.id}', extra: book),
                     );
                  },
                ),
              const SizedBox(height: 30),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.auto_stories, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "You aren't reading anything right now.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/library'),
            child: const Text('Go to Library'),
          ),
        ],
      ),
    );
  }
}
