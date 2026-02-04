import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'collections_view_model.dart';
import '../../widgets/app_drawer.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        leading: const BackButton(),
      ),
      body: collectionsAsync.when(
        data: (collections) {
          if (collections.isEmpty) {
            return const Center(child: Text('No collections created.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: collections.length,
            itemBuilder: (context, index) {
               final col = collections[index];
               return Card(
                 child: InkWell(
                   onTap: () {
                     // Navigate to details (filter books by this collection)
                     // context.push('/collection/${col.id}', extra: col);
                   },
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Icon(Icons.collections_bookmark, size: 40),
                       const SizedBox(height: 8),
                       Text(col.name, style: Theme.of(context).textTheme.titleMedium),
                     ],
                   ),
                 ),
               );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           _showCreateDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Collection'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(collectionsViewModelProvider.notifier).createCollection(controller.text);
                Navigator.pop(context);
              }
            }, 
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
