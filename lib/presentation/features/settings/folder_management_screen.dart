import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readory/data/repositories/settings_repository_impl.dart';
import 'package:readory/domain/usecases/scan_books_usecase.dart';
import 'package:readory/presentation/features/library/library_view_model.dart';
import '../../widgets/app_drawer.dart';

class FolderManagementScreen extends ConsumerStatefulWidget {
  const FolderManagementScreen({super.key});

  @override
  ConsumerState<FolderManagementScreen> createState() => _FolderManagementScreenState();
}

class _FolderManagementScreenState extends ConsumerState<FolderManagementScreen> {
  // We should ideally have a ViewModel, but for simple settings, FutureBuilder or local state with repository is fine.
  // Better: autoDispose provider for the list.
  
  bool _isScanning = false;
  String? _scanResult;

  Future<void> _scanFoldersForPath(String? specificPath) async {
    setState(() {
      _isScanning = true;
      _scanResult = null;
    });

    try {
      int count = 0;
      if (specificPath != null) {
         count = await ref.read(scanBooksUseCaseProvider).scanDirectory(specificPath);
      } else {
         count = await ref.read(scanBooksUseCaseProvider).scanAllFolders();
      }

      if (mounted) {
        setState(() {
          _scanResult = "Scan complete. Found $count books.";
        });
        ref.invalidate(libraryViewModelProvider);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _scanResult = "Scan failed: $e";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  Future<void> _scanFolders() => _scanFoldersForPath(null);

  @override
  Widget build(BuildContext context) {
    final settingsRepo = ref.watch(settingsRepositoryProvider);
    final foldersAsync = ref.watch(foldersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Folders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Restore from Library',
            onPressed: () async {
               await ref.read(scanBooksUseCaseProvider).restoreFoldersFromBooks();
               ref.invalidate(foldersProvider);
               if (context.mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Scanned folders restored')));
               }
            },
          )
        ],
      ),
      // drawer: const AppDrawer(), // Removed (BottomNav)
      body: Column(
        children: [
          if (_isScanning)
            const LinearProgressIndicator(),
            
          if (_scanResult != null)
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(_scanResult!, style: const TextStyle(fontWeight: FontWeight.bold)),
             ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isScanning ? null : _scanFolders, 
                icon: const Icon(Icons.refresh), 
                label: _isScanning ? const Text("Scanning...") : const Text("Scan Now")
              ),
            ),
          ),
          
          Expanded(
            child: foldersAsync.when(
              data: (folders) {
                if (folders.isEmpty) {
                  return const Center(child: Text('No folders added.'));
                }
                return ListView.separated(
                   itemCount: folders.length,
                   separatorBuilder: (_, __) => const Divider(),
                   itemBuilder: (context, index) {
                     final path = folders[index];
                     return ListTile(
                       leading: const Icon(Icons.folder),
                       title: Text(path),
                       trailing: IconButton(
                         icon: const Icon(Icons.delete, color: Colors.black), // Requested BLACK color
                         onPressed: () async {
                           await ref.read(scanBooksUseCaseProvider).removeDirectory(path);
                           ref.invalidate(foldersProvider);
                           // Also invalidate library to remove deleted books from view
                           ref.invalidate(libraryViewModelProvider);
                         },
                       ),
                     );
                   },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // 1. Pick and Add (Fast)
          final path = await ref.read(scanBooksUseCaseProvider).pickDirectoryAndAdd();
          
          if (path != null) {
            // 2. Immediate UI Update
            ref.invalidate(foldersProvider);
            
            // 3. Trigger Scan (Background/Progress)
            _scanFoldersForPath(path);
          }
        },
        label: const Text('Add Folder'),
        icon: const Icon(Icons.create_new_folder),
      ),
    );
  }
}

final foldersProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.getScannedFolders();
});
