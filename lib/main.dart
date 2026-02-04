import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readory/config/routes/app_router.dart';
import 'package:readory/core/providers/theme_provider.dart' hide sharedPreferencesProvider;
import 'package:readory/presentation/features/auth/providers/auth_dependencies_provider.dart';
import 'package:readory/config/themes/app_theme.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:readory/data/repositories/settings_repository_impl.dart';
import 'package:readory/domain/repositories/settings_repository.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      settingsRepositoryProvider.overrideWithValue(SettingsRepositoryImpl(prefs)),
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const ReadoryApp(),
  ));
}

class ReadoryApp extends ConsumerWidget {
  const ReadoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Readory',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
