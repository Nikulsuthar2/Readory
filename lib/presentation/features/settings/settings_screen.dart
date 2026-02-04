import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
           const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.folder_special),
            title: const Text('Manage Folders'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/folders'),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Trash Bin'),
             trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/trash'),
          ),
           ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Authors'),
             trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/authors'),
          ),
           ListTile(
            leading: const Icon(Icons.style),
            title: const Text('Collections'),
             trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/collections'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Appearance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                notifier.setTheme(newSelection.first);
              },
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup & Restore'),
            subtitle: const Text('Export or import your library database'),
            onTap: () {
               // Placeholder for backup
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup feature coming soon!')));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Readory v1.0.0'),
            onTap: () {
               showAboutDialog(context: context, applicationName: 'Readory', applicationVersion: '1.0.0');
            },
          ),
        ],
      ),
    );
  }
}
