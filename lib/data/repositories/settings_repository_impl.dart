import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  // We assume SharedPreferences is initialized in main or we use FutureProvider
  // ideally we should pass the instance.
  // For now, let's look up how to get generic SharedPreferences via Riverpod.
  // We'll return an UnimplementedError if not overridden, OR we can make this a FutureProvider.
  // Better: make the impl class get instance on method call or await it.
  throw UnimplementedError('Provider was not overridden');
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Provider was not overridden');
});

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;
  static const String _keyScannedFolders = 'scanned_folders';

  SettingsRepositoryImpl(this._prefs);

  @override
  Future<List<String>> getScannedFolders() async {
    return _prefs.getStringList(_keyScannedFolders) ?? [];
  }

  @override
  Future<void> addScannedFolder(String path) async {
    final list = _prefs.getStringList(_keyScannedFolders) ?? [];
    if (!list.contains(path)) {
      list.add(path);
      await _prefs.setStringList(_keyScannedFolders, list);
    }
  }

  @override
  Future<void> removeScannedFolder(String path) async {
    final list = _prefs.getStringList(_keyScannedFolders) ?? [];
    if (list.contains(path)) {
      list.remove(path);
      await _prefs.setStringList(_keyScannedFolders, list);
    }
  }
}
