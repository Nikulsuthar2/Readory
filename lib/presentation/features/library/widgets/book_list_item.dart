
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../domain/entities/book_entity.dart';

class BookListItem extends StatelessWidget {
  final BookEntity book;
  final VoidCallback onTap;

  const BookListItem({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            Container(
              height: 100, // Larger height
              width: 70,   // ~0.7 aspect ratio
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(4),
                 color: Colors.grey[200],
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.1),
                     blurRadius: 4,
                     offset: const Offset(0, 2),
                   )
                 ]
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildCover(),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (book.author.isNotEmpty)
                    Text(
                      book.author, 
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (book.progress > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: book.progress,
                            backgroundColor: Colors.grey[200],
                            minHeight: 4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${(book.progress * 100).toInt()}%",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Actions
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // TODO: Show options
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCover() {
    if (book.coverPath != null && File(book.coverPath!).existsSync()) {
      return Image.file(
        File(book.coverPath!),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.book, color: Colors.grey),
      );
    }
    return const Icon(Icons.book, color: Colors.grey);
  }
}
