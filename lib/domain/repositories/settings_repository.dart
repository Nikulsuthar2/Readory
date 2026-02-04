import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';

abstract class SettingsRepository {
  Future<List<String>> getScannedFolders();
  Future<void> addScannedFolder(String path);
  Future<void> removeScannedFolder(String path);
}
