import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../domain/entities/book_entity.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.7, // Dynamic ratio or fallback
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: _buildCover(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                ),
                if (book.author.isNotEmpty && book.author != 'Unknown') ...[
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCover() {
    if (book.coverPath != null && File(book.coverPath!).existsSync()) {
      return Image.file(
        File(book.coverPath!),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.book,
          size: 40,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
