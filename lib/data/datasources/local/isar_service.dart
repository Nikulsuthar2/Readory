import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../models/book_model.dart';
import '../../models/annotation_model.dart';

class IsarService {
  static Isar? _instance;

  /// Opens an Isar instance for the specific [userId].
  /// This ensures data isolation between users.
  Future<Isar> openDB(String userId) async {
    // If we're already connected to this user's DB, return it.
    if (_instance != null && _instance!.name == userId) {
      return _instance!;
    }

    // If an instance is open but for a different user (shouldn't happen in normal flow but for safety), close it.
    if (_instance != null) {
      await _instance!.close();
    }

    final dir = await getApplicationDocumentsDirectory();
    final userDir = Directory(p.join(dir.path, 'users', userId));
    
    if (!await userDir.exists()) {
      await userDir.create(recursive: true);
    }

    _instance = await Isar.open(
      [BookModelSchema, AnnotationModelSchema],
      directory: userDir.path,
      name: userId, // named instance for the user
      inspector: true,
    );

    return _instance!;
  }

  /// Close the current instance
  Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
  
  /// Get the current open instance. Throws if not initialized.
  Isar get db {
    if (_instance == null) {
      throw Exception("IsarDB not initialized. Call openDB(userId) first.");
    }
    return _instance!;
  }
}
