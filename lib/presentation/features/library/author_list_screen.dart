import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'library_view_model.dart';
import '../../widgets/app_drawer.dart';

class AuthorListScreen extends ConsumerWidget {
  const AuthorListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(libraryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
        leading: const BackButton(),
      ),
      body: booksAsync.when(
        data: (books) {
          // Group by author
          final Map<String, int> authorCounts = {};
          for (var book in books) {
            if (!book.isDeleted) { // Exclude deleted books
               authorCounts.update(book.author, (val) => val + 1, ifAbsent: () => 1);
            }
          }

          if (authorCounts.isEmpty) {
            return const Center(child: Text('No authors found'));
          }

          final sortedAuthors = authorCounts.keys.toList()
            ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

          return ListView.separated(
            itemCount: sortedAuthors.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final author = sortedAuthors[index];
              final count = authorCounts[author];
              return ListTile(
                leading: CircleAvatar(child: Text(author[0].toUpperCase())),
                title: Text(author),
                subtitle: Text('$count ${count == 1 ? 'book' : 'books'}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                   // Navigate to library with search query for author
                   // Ideally we would add an 'author' filter param, but search works too.
                   ref.read(libraryViewModelProvider.notifier).setSearchQuery(author);
                   context.push('/library'); 
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
