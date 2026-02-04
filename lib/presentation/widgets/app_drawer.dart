import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/providers/auth_controller.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/favorites')) return 3;
    if (location.startsWith('/authors')) return 4;
    // 5: Collections
    // 6: Want to Read
    // 7: Have Read
    if (location.startsWith('/collections')) return 5;
    if (location.startsWith('/want-to-read')) return 6;
    if (location.startsWith('/have-read')) return 7;
    // Divider at 8
    // 9: Folders
    if (location.startsWith('/folders')) return 9;
    // 10: Trash
    if (location.startsWith('/trash')) return 10;
    // 11: Log Out
    // 12: Settings
    if (location.startsWith('/settings')) return 12;
    if (location.startsWith('/library')) return 2;
    if (location == '/') return 1;
    return 1;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = _calculateSelectedIndex(context);

    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        Scaffold.of(context).closeDrawer();

        switch (index) {
          case 0: // Header - Ignore
            break;
          case 1: // Reading Now
            context.go('/');
            break;
          case 2: // Library
            context.go('/library');
            break;
          case 3: // Favorites
             context.go('/favorites');
             break;
          case 4: // Authors
             context.go('/authors');
             break;
          case 5: // Collections
            context.go('/collections');
            break;
          case 6: // Want to Read
            context.go('/want-to-read');
            break;
          case 7: // Have Read
            context.go('/have-read');
            break;
          case 8: // Divider - Ignore (actually Divider is wrapped in Padding, so index 8 is Padding)
             break;  
          case 9: // Manage Folders (Padding is index 8)
            context.go('/folders');
            break;
          case 10: // Trash
             context.go('/trash');
             break;
          case 11: // Log Out
            ref.read(authControllerProvider.notifier).signOut();
            context.go('/login');
            break;
          case 12: // Settings
             context.go('/settings');
             break;
        }
      },
      children: const [
         Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Readory Beta',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.home),
          label: Text('Reading Now'), // 0
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.library_books), // 1
          label: Text('All Books'),
        ),
        NavigationDrawerDestination( // 2
          icon: Icon(Icons.favorite),
          label: Text('Favorites'),
        ),
        NavigationDrawerDestination( // 3
          icon: Icon(Icons.person),
          label: Text('Authors'),
        ),
        NavigationDrawerDestination( // 4
          icon: Icon(Icons.style),
          label: Text('Collections'),
        ),
        NavigationDrawerDestination( // 5
          icon: Icon(Icons.bookmark),
          label: Text('Want to Read'),
        ),
        NavigationDrawerDestination( // 6
          icon: Icon(Icons.done_all),
          label: Text('Have Read'),
        ), 
        Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
        NavigationDrawerDestination( // 7
          icon: Icon(Icons.folder_special),
          label: Text('Manage Folders'),
        ),
        NavigationDrawerDestination( // 8
          icon: Icon(Icons.delete_outline),
          label: Text('Trash Bin'),
        ),
        NavigationDrawerDestination( // 9
          icon: Icon(Icons.logout),
          label: Text('Log Out'),
        ),
        NavigationDrawerDestination( // 10
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
      ],
    );
  }
}
