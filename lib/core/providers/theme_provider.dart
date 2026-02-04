import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Simple provider for SharedPreferences, assumed initialized in main
import '../../data/repositories/settings_repository_impl.dart';

final themeProvider = StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeController(prefs);
});

class ThemeController extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  ThemeController(this._prefs) : super(ThemeMode.system) {
    _load();
  }

  void _load() {
    final startOffset = _prefs.getString(_key);
    if (startOffset == 'light') state = ThemeMode.light;
    else if (startOffset == 'dark') state = ThemeMode.dark;
    else state = ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    String val = 'system';
    if (mode == ThemeMode.light) val = 'light';
    if (mode == ThemeMode.dark) val = 'dark';
    await _prefs.setString(_key, val);
  }
}
