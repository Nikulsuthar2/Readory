import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String author;
  final String filePath;
  final String? coverPath;
  final double progress;
  final bool isSynced;
  final int lastReadPage;
  final DateTime? lastReadTime;
  final ReadingStatus readingStatus;
  final List<String> collections;
  final int totalPages;
  final List<int> bookmarks; // Page numbers for now
  final String? devicePath; // Where the file is on device
  final double? aspectRatio; // Width / Height of the cover/first page

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.filePath,
    this.coverPath,
    this.progress = 0.0,
    this.isSynced = false,
    this.isFavorite = false,
    this.isDeleted = false,
    this.lastReadPage = 0,
    this.totalPages = 0,
    this.lastReadTime,
    this.readingStatus = ReadingStatus.none,
    this.collections = const [],
    this.bookmarks = const [],
    this.devicePath,
    this.aspectRatio,
  });

  final bool isFavorite;
  final bool isDeleted;

  BookEntity copyWith({
    String? id,
    String? title,
    String? author,
    String? filePath,
    String? coverPath,
    double? progress,
    bool? isSynced,
    int? lastReadPage,
    int? totalPages,
    DateTime? lastReadTime,
    ReadingStatus? readingStatus,
    List<String>? collections,
    List<int>? bookmarks,
    String? devicePath,
    bool? isFavorite,
    bool? isDeleted,
    double? aspectRatio,
  }) {
    return BookEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      filePath: filePath ?? this.filePath,
      coverPath: coverPath ?? this.coverPath,
      progress: progress ?? this.progress,
      isSynced: isSynced ?? this.isSynced,
      lastReadPage: lastReadPage ?? this.lastReadPage,
      totalPages: totalPages ?? this.totalPages,
      lastReadTime: lastReadTime ?? this.lastReadTime,
      readingStatus: readingStatus ?? this.readingStatus,
      collections: collections ?? this.collections,
      bookmarks: bookmarks ?? this.bookmarks,
      devicePath: devicePath ?? this.devicePath,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        filePath,
        coverPath,
        progress,
        isSynced,
        lastReadPage,
        totalPages,
        lastReadTime,
        readingStatus,
        collections,
        bookmarks,
        devicePath,
        isFavorite,
        isDeleted,
        aspectRatio,
      ];
}

enum ReadingStatus {
  none,
  reading,
  completed,
  wantToRead, 
}
