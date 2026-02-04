import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:permission_handler/permission_handler.dart';

final fileServiceProvider = Provider<FileService>((ref) {
  return FileService();
});

class FileService {
  /// Request necessary storage permissions
  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
       // Check for Manage External Storage (Android 11+)
       if (await Permission.manageExternalStorage.request().isGranted) {
         return true;
       }
       
       // Fallback for older Android versions
       if (await Permission.storage.request().isGranted) {
         return true;
       }
       
       return false;
    }
    return true; 
  }

  /// Picks a directory and returns its path.
  Future<String?> pickDirectory() async {
    // Ensure permission before picking if needed, though FilePicker usually handles read permission.
    // Explicit request helps for Manage External Storage access later.
    await requestPermission();
    return await FilePicker.platform.getDirectoryPath();
  }

  /// Scans a directory recursively for supported book files.
  /// [extensions] should be a list like ['.pdf', '.epub']
  Stream<File> scanDirectory(String dirPath, List<String> extensions) async* {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) return;

    // We use a broadcast stream logic or just yield* recursive
    // Using explicit recursion for control
    try {
      print('[FileService] Scanning directory: $dirPath');
      final entities = dir.list(recursive: true, followLinks: false);
      await for (final entity in entities) {
        if (entity is File) {
          final ext = p.extension(entity.path).toLowerCase();
          print('[FileService] Found file: ${entity.path} with extension: $ext');
          if (extensions.contains(ext)) {
            print('[FileService] Matched extension!');
            yield entity;
          }
        }
      }
    } catch (e) {
      // Permission errors or other FS issues might happen
      print('[FileService] Error scanning directory $dirPath: $e');
    }
  }
}
