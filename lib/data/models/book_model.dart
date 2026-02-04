import 'package:isar/isar.dart';
import '../../domain/entities/book_entity.dart';

part 'book_model.g.dart';

@collection
class BookModel {
  Id id = Isar.autoIncrement; // Auto-incrementing ID for local storage

  @Index(unique: true, replace: true)
  late String fileHash; // Unique identifier for the file (MD5/SHA)

  late String title;
  late String author;
  late String filePath; // Local path to the file
  late String? coverPath; // Local path to the generated thumbnail

  late double progress; // 0.0 to 1.0
  late int lastReadPage;
  late int totalPages = 0;
  late DateTime lastReadTime;
  
  @Enumerated(EnumType.name)
  late ReadingStatus status = ReadingStatus.none;

  late List<String> collections = [];
  late List<int> bookmarks = [];
  late String? devicePath;
  double? aspectRatio; // Persist ratio

  @Enumerated(EnumType.name)
  late BookFormat format;
  
  bool isSynced = false;
  bool isFavorite = false;
  bool isDeleted = false;
  
  // ignore: unused_field

}

enum BookFormat {
  pdf,
  epub,
}


