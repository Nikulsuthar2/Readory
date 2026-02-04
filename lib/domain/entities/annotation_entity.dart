import 'package:equatable/equatable.dart';

class AnnotationEntity extends Equatable {
  final String id;
  final String bookId;
  final int pageNumber;
  final String content; // The note itself
  final String? selectedText; // Highlighted text (optional for now)
  final String color; // Hex color
  final List<String> rects; // "x,y,w,h" normalized coordinates
  final DateTime createdAt;

  const AnnotationEntity({
    required this.id,
    required this.bookId,
    required this.pageNumber,
    required this.content,
    this.selectedText,
    this.color = '#FFEB3B', // Default yellow
    this.rects = const [],
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, bookId, pageNumber, content, selectedText, color, rects, createdAt];
}
