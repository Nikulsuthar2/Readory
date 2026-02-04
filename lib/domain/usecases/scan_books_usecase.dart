import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../core/services/metadata_service.dart';
import '../../data/datasources/local/file_service.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../data/repositories/settings_repository_impl.dart';

final scanBooksUseCaseProvider = Provider<ScanBooksUseCase>((ref) {
  return ScanBooksUseCase(
    ref.watch(fileServiceProvider),
    ref.watch(metadataServiceProvider),
    ref.watch(bookRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
  );
});

class ScanBooksUseCase {
  final FileService _fileService;
  final MetadataService _metadataService;
  final BookRepository _bookRepository;
  final SettingsRepository _settingsRepository;

  ScanBooksUseCase(
    this._fileService,
    this._metadataService,
    this._bookRepository,
    this._settingsRepository,
  );

  /// Picks a directory, adds it to settings, and scans it.
  Future<int> pickAndAddDirectory() async {
    final dirPath = await pickDirectoryAndAdd();
    if (dirPath == null) return 0;
    return await scanDirectory(dirPath);
  }

  /// Picks a directory and adds it to settings (does NOT scan).
  /// Returns the path if selected, null otherwise.
  Future<String?> pickDirectoryAndAdd() async {
    final dirPath = await _fileService.pickDirectory();
    if (dirPath == null) return null;

    await _settingsRepository.addScannedFolder(dirPath);
    return dirPath;
  }

  /// Removes a directory from settings and deletes associated books.
  Future<void> removeDirectory(String dirPath) async {
    await _settingsRepository.removeScannedFolder(dirPath);
    await _bookRepository.deleteBooksByDirectory(dirPath);
  }

  /// Re-scans all saved directories.
  Future<int> scanAllFolders() async {
    final folders = await _settingsRepository.getScannedFolders();
    int total = 0;
    for (final folder in folders) {
      total += await scanDirectory(folder);
    }
    return total;
  }

  /// Scans existing books in DB and adds their directories to settings if missing.
  Future<void> restoreFoldersFromBooks() async {
    final booksResult = await _bookRepository.getAllBooks();
    booksResult.fold(
      (l) => null,
      (books) async {
        final Set<String> paths = {};
        for (final book in books) {
          final dir = p.dirname(book.filePath);
          paths.add(dir);
        }
        
        final existing = await _settingsRepository.getScannedFolders();
        for (final path in paths) {
          if (!existing.contains(path)) {
            await _settingsRepository.addScannedFolder(path);
          }
        }
      },
    );
  }

  Future<int> scanDirectory(String dirPath) async {
    // Ensure permission before scanning (double check)
    await _fileService.requestPermission();

    int count = 0;
    final extensions = ['.pdf', '.epub'];

    await for (final file in _fileService.scanDirectory(dirPath, extensions)) {
      try {
        print('[ScanBooksUseCase] Processing file: ${file.path}');
        final id = sha1.convert(utf8.encode(file.absolute.path)).toString();
        
        final existing = await _bookRepository.getBookById(id);
        bool exists = false;
        existing.fold(
          (l) => print('[ScanBooksUseCase] Error checking existence: $l'), 
          (r) {
             if (r != null) {
               exists = true;
               print('[ScanBooksUseCase] Book already exists in DB: ${r.title}');
             }
          },
        );

        // if (exists) continue; // Allow updating existing books to refresh metadata/covers

        final metadata = await _metadataService.extractMetadata(file);
        print('[ScanBooksUseCase] Extracted metadata: ${metadata.title}');
        
        String? localCoverPath;
        if (metadata.coverImage != null) {
          try {
             final appDir = await getApplicationDocumentsDirectory();
             final coversDir = Directory(p.join(appDir.path, 'covers'));
             if (!await coversDir.exists()) {
               await coversDir.create(recursive: true);
             }
             final coverFile = File(p.join(coversDir.path, '$id.jpg'));
             await coverFile.writeAsBytes(metadata.coverImage!);
             localCoverPath = coverFile.path;
          } catch(e) {
            print("[ScanBooksUseCase] Error saving cover: $e");
          }
        }

        final book = BookEntity(
          id: id,
          title: metadata.title,
          author: metadata.author,
          filePath: file.absolute.path,
          coverPath: localCoverPath,
          progress: 0,
          totalPages: metadata.totalPages,
          aspectRatio: metadata.aspectRatio,
        );

        final result = await _bookRepository.addBook(book);
        if (result.isRight()) {
          print('[ScanBooksUseCase] Successfully added book: ${book.title}');
          count++;
        } else {
           result.fold((l) => print('[ScanBooksUseCase] Failed to add book to DB: $l'), (r) => null);
        }
      } catch (e) {
        print("[ScanBooksUseCase] Failed to import ${file.path}: $e");
      }
    }
    print('[ScanBooksUseCase] Finished scanning. Total added: $count');
    return count;
  }
}
