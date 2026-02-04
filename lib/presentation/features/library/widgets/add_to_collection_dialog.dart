import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/book_entity.dart';
import '../collections_view_model.dart';
import '../../../../data/repositories/book_repository_impl.dart';

class AddToCollectionDialog extends ConsumerStatefulWidget {
  final BookEntity book;

  const AddToCollectionDialog({super.key, required this.book});

  @override
  ConsumerState<AddToCollectionDialog> createState() => _AddToCollectionDialogState();
}

class _AddToCollectionDialogState extends ConsumerState<AddToCollectionDialog> {
  // Local state for tracking selections before save
  late Set<String> _selectedCollectionIds;

  @override
  void initState() {
    super.initState();
    _selectedCollectionIds = widget.book.collections.toSet();
  }

  Future<void> _save() async {
    final updatedBook = BookEntity(
       id: widget.book.id,
       title: widget.book.title,
       author: widget.book.author,
       filePath: widget.book.filePath,
       coverPath: widget.book.coverPath,
       progress: widget.book.progress,
       isSynced: widget.book.isSynced,
       lastReadPage: widget.book.lastReadPage,
       lastReadTime: widget.book.lastReadTime,
       readingStatus: widget.book.readingStatus,
       collections: _selectedCollectionIds.toList(),
       bookmarks: widget.book.bookmarks,
       devicePath: widget.book.devicePath,
    );
    
    // Save book
    await ref.read(bookRepositoryProvider).addBook(updatedBook);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(collectionsViewModelProvider);

    return AlertDialog(
      title: const Text('Add to Collection'),
      content: SizedBox(
        width: double.maxFinite,
        child: collectionsAsync.when(
          data: (collections) {
            if (collections.isEmpty) {
              return const Text('No collections found. Create one?');
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final col = collections[index];
                final isSelected = _selectedCollectionIds.contains(col.id);
                return CheckboxListTile(
                  title: Text(col.name),
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _selectedCollectionIds.add(col.id);
                      } else {
                        _selectedCollectionIds.remove(col.id);
                      }
                    });
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Text('Error: $e'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Quick create
            _showCreateInput(context);
          },
          child: const Text('New Collection'),
        ),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }

  void _showCreateInput(BuildContext context) {
    // Logic to show another dialog or input to create collection
    // For simplicity, reusing logic from CollectionsScreen or duplicating
    // Duplicating small logic is fine for now to avoid coupling to Screen
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Collection'),
        content: TextField(controller: controller, autofocus: true, decoration: const InputDecoration(labelText: 'Name')),
        actions: [
           TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
           TextButton(
             onPressed: () async {
               if (controller.text.isNotEmpty) {
                 await ref.read(collectionsViewModelProvider.notifier).createCollection(controller.text);
                 Navigator.pop(context);
                 // The provider will update naturally
               }
             },
             child: const Text('Create'),
           )
        ],
      )
    );
  }
}
