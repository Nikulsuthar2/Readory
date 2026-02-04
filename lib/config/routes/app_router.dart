import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../presentation/features/auth/providers/auth_dependencies_provider.dart';
import '../../presentation/features/auth/screens/login_screen.dart';
import '../../presentation/features/auth/screens/sign_up_screen.dart';
import '../../presentation/features/library/library_screen.dart';
import '../../presentation/features/reader/reader_screen.dart';
import '../../presentation/features/home/home_screen.dart';
import '../../presentation/features/details/book_details_screen.dart';
import '../../domain/entities/book_entity.dart';
import '../../presentation/features/settings/folder_management_screen.dart';
import '../../presentation/features/library/collections_screen.dart';
import '../../presentation/features/settings/settings_screen.dart';
import '../../presentation/features/library/author_list_screen.dart';
import '../../presentation/widgets/scaffold_with_navbar.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final authStream = ref.watch(authStateChangesProvider.stream);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authStream),
    redirect: (context, state) {
      // Login bypass: always allow access.
      // We keep the login routes available but don't force them.
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavbar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Branch 1: Library
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryScreen(),
                routes: [
                  GoRoute(
                    path: 'author/:name',
                    builder: (context, state) => LibraryScreen(filterAuthor: state.pathParameters['name']),
                  ),
                ],
              ),
            ],
          ),
          // Branch 2: Favorites
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const LibraryScreen(showFavorites: true),
              ),
            ],
          ),
          // Branch 3: Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
                routes: [
                   GoRoute(
                    path: 'folders',
                    builder: (context, state) => const FolderManagementScreen(),
                  ),
                  GoRoute(
                    path: 'trash',
                    builder: (context, state) => const LibraryScreen(showDeleted: true),
                  ),
                  GoRoute(
                    path: 'collections',
                    builder: (context, state) => const CollectionsScreen(),
                  ),
                  GoRoute(
                    path: 'authors',
                    builder: (context, state) => const AuthorListScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
       GoRoute(
        path: '/book/:id',
        builder: (context, state) {
          final book = state.extra as BookEntity?;
          if (book != null) {
            return BookDetailsScreen(book: book);
          } else {
            return const Scaffold(body: Center(child: Text("Book not found")));
          }
        },
      ),
      GoRoute(
        path: '/reader',
        builder: (context, state) {
          final book = state.extra as BookEntity;
          return ReaderScreen(book: book);
        },
      ),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
