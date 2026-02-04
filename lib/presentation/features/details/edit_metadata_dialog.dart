import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/book_entity.dart';
import '../library/library_view_model.dart';
// import '../../../widgets/book_card.dart'; // Reuse if needed, or removing import

class EditMetadataDialog extends ConsumerStatefulWidget {
  final BookEntity book;

  const EditMetadataDialog({super.key, required this.book});

  @override
  ConsumerState<EditMetadataDialog> createState() => _EditMetadataDialogState();
}

class _EditMetadataDialogState extends ConsumerState<EditMetadataDialog> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Metadata'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final newTitle = _titleController.text.trim();
            final newAuthor = _authorController.text.trim();
            
            if (newTitle.isNotEmpty) {
              final updatedBook = BookEntity(
                id: widget.book.id, // Keep same ID to update
                title: newTitle,
                author: newAuthor.isNotEmpty ? newAuthor : widget.book.author,
                filePath: widget.book.filePath,
                coverPath: widget.book.coverPath,
                progress: widget.book.progress,
                isSynced: widget.book.isSynced,
                lastReadPage: widget.book.lastReadPage,
                lastReadTime: widget.book.lastReadTime,
                readingStatus: widget.book.readingStatus,
                collections: widget.book.collections,
                bookmarks: widget.book.bookmarks,
                devicePath: widget.book.devicePath,
              );
              
              ref.read(libraryViewModelProvider.notifier).updateBook(updatedBook);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
