import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/entities/annotation_entity.dart';
import '../library/library_view_model.dart';
import '../library/widgets/add_to_collection_dialog.dart';

import '../../../data/repositories/book_repository_impl.dart';
import '../../../../domain/repositories/book_repository.dart';
import '../reader/reader_screen.dart'; // Ensure correct import for ref.read usage context
import 'edit_metadata_dialog.dart';

// Stream Provider for realtime updates
final bookStreamProvider = StreamProvider.family<BookEntity?, String>((ref, id) {
  return ref.watch(bookRepositoryProvider).watchBookById(id);
});

// Stream Provider for Annotations
final annotationsStreamProvider = StreamProvider.family<List<AnnotationEntity>, String>((ref, bookId) {
  return ref.watch(bookRepositoryProvider).watchAnnotationsForBook(bookId);
});

class BookDetailsScreen extends ConsumerWidget {
  final BookEntity initialBook;

  const BookDetailsScreen({super.key, required BookEntity book}) : initialBook = book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch both book info and annotations
    final bookAsync = ref.watch(bookStreamProvider(initialBook.id));
    
    // We preload annotations here so they are ready for tabs
    // Or we can let each tab watch it. Since StreamProvider caches, it's fine.
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) => EditMetadataDialog(book: initialBook),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Options
            },
          ),
        ],
      ),
      body: bookAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (bookData) {
           final book = bookData ?? initialBook;
           
           return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Cover Image & Status
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                         context.push('/reader', extra: book);
                      },
                      child: Hero(
                        tag: 'book_cover_${book.id}',
                        child: Container(
                          width: 160,
                          height: 240,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: book.coverPath != null
                              ? Image.file(
                                  File(book.coverPath!),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => _buildPlaceholder(),
                                )
                              : _buildPlaceholder(),
                        ),
                        ),
                      ),
                    ),
                    if (book.progress == 0)
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Not Read Yet',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                // Title & Author
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    book.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.author,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                 const SizedBox(height: 8),
                // Progress Bar
                if (book.progress > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: book.progress, 
                          backgroundColor: Colors.grey[300],
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${(book.progress * 100).toInt()}% Done",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                             if (book.totalPages > 0)
                              Text(
                                "${book.lastReadPage} / ${book.totalPages} pages",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                const SizedBox(height: 24),
                // Action Buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: book.isDeleted 
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                             final updated = book.copyWith(isDeleted: false);
                             ref.read(libraryViewModelProvider.notifier).updateBook(updated);
                             // Navigator.pop(context); // Optional: stay to show restored 
                          },
                          icon: const Icon(Icons.restore),
                          label: const Text('Restore'),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                          onPressed: () {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permanent delete not ready yet.")));
                          },
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Delete Forever'),
                        ),
                      ],
                    )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: () {
                           context.push('/reader', extra: book);
                        },
                        icon: const Icon(Icons.menu_book),
                        label: Text(book.progress > 0 ? 'Continue' : 'Read Now'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AddToCollectionDialog(book: book),
                          );
                        },
                        icon: const Icon(Icons.style),
                        label: const Text('Collect'),
                      ),
                      const SizedBox(width: 8),
                      IconButton.outlined(
                        tooltip: book.isFavorite ? 'Unfavorite' : 'Favorite',
                        style: IconButton.styleFrom(
                          foregroundColor: book.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                           final updated = book.copyWith(isFavorite: !book.isFavorite);
                           ref.read(libraryViewModelProvider.notifier).updateBook(updated);
                        }, 
                        icon: Icon(book.isFavorite ? Icons.favorite : Icons.favorite_border),
                      ),
                      const SizedBox(width: 8),
                      IconButton.outlined(
                        tooltip: 'Delete',
                        onPressed: () {
                           // Move to trash (Soft Delete)
                           final updated = book.copyWith(isDeleted: true);
                           ref.read(libraryViewModelProvider.notifier).updateBook(updated);
                           Navigator.pop(context); // Go back after deleting
                        }, 
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Info / Tabs
                DefaultTabController(
                  length: 6,
                  child: Column(
                    children: [
                       const TabBar(
                         isScrollable: true,
                         tabs: [
                            Tab(text: 'Metadata'),
                            Tab(text: 'TOC'),
                            Tab(text: 'Notes'),
                            Tab(text: 'Highlights'),
                            Tab(text: 'Bookmarks'),
                            Tab(text: 'Vocab'),
                          ],
                        ),
                        SizedBox(
                          height: 400, 
                          child: TabBarView(
                            children: [
                              _buildMetadataTab(context, book),
                              const Center(child: Text("Table of Contents (Coming Soon)")),
                              _buildNotesTab(ref, book.id),
                              _buildHighlightsTab(ref, book.id),
                              _buildBookmarksTab(book),
                              const Center(child: Text("Vocabulary (Coming Soon)")),
                            ],
                          ),
                        ),
                     ],
                   ),
                 ),
               ],
             ),
           );
        },
      ),
    );
  }

  Widget _buildBookmarksTab(BookEntity book) {
     if (book.bookmarks.isEmpty) {
       return const Center(child: Text("No bookmarks yet"));
     }
     return ListView.builder(
       itemCount: book.bookmarks.length,
       itemBuilder: (context, index) {
         return ListTile(
           leading: const Icon(Icons.bookmark),
           title: Text('Page ${book.bookmarks[index]}'),
           onTap: () {
             // Navigate to page
           },
         );
       },
     );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.book, size: 50, color: Colors.grey),
      ),
    );
  }

  Widget _buildMetadataTab(BuildContext context, BookEntity book) {
    // Calculate file size
    String sizeStr = 'Unknown';
    try {
      final file = File(book.filePath);
      if (file.existsSync()) {
        final bytes = file.lengthSync();
        sizeStr = '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
      }
    } catch (_) {}

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoRow('Format', book.filePath.split('.').last.toUpperCase()),
        _buildInfoRow('Size', sizeStr),
        _buildInfoRow('File Path', book.filePath),
        if (book.devicePath != null) _buildInfoRow('Device Path', book.devicePath!),
        _buildInfoRow('Added', 'Just now'), // TODO: Add 'addedDate' to entity
        _buildInfoRow('Last Read', book.lastReadTime != null ? _formatDate(book.lastReadTime!) : 'Never'),
        _buildInfoRow('Status', book.readingStatus.name.toUpperCase()),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    return "${dt.day}/${dt.month}/${dt.year}";
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildNotesTab(WidgetRef ref, String bookId) {
    final annotationsAsync = ref.watch(annotationsStreamProvider(bookId));
    
    return annotationsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
      data: (annotations) {
        // Filter Notes (content is not empty)
        final notes = annotations.where((a) => a.content.isNotEmpty).toList();
        
        if (notes.isEmpty) {
          return const Center(child: Text("No notes yet. Add one while reading!"));
        }

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.note, color: Colors.blue),
                title: Text(note.content),
                subtitle: Text("Page ${note.pageNumber}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                     ref.read(bookRepositoryProvider).deleteAnnotation(note.id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Widget _buildHighlightsTab(WidgetRef ref, String bookId) {
    final annotationsAsync = ref.watch(annotationsStreamProvider(bookId));
    
    return annotationsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
      data: (annotations) {
        final highlights = annotations.where((a) => (a.selectedText ?? "").isNotEmpty).toList();
        
        if (highlights.isEmpty) {
          return const Center(child: Text("No highlights yet. Select text to highlight."));
        }

        return ListView.builder(
          itemCount: highlights.length,
          itemBuilder: (context, index) {
            final highlight = highlights[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       children: [
                         CircleAvatar(
                           backgroundColor: Color(int.parse(highlight.color.replaceFirst('#', '0xff'))),
                           radius: 6,
                         ),
                         const SizedBox(width: 8),
                         Text("Page ${highlight.pageNumber}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                         const Spacer(),
                         IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                            onPressed: () {
                               ref.read(bookRepositoryProvider).deleteAnnotation(highlight.id);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                         ),
                       ],
                     ),
                     const SizedBox(height: 8),
                     Text(
                       highlight.selectedText ?? "",
                       style: const TextStyle(fontStyle: FontStyle.italic, backgroundColor: Color(0x33FFEB3B)),
                     ),
                     if (highlight.content.isNotEmpty) ...[
                        const Divider(),
                        Text(highlight.content, style: const TextStyle(fontSize: 13)),
                     ]
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
