import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../domain/entities/bookmark_entity.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<BookMarkEntity> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    final box = Hive.box<BookMarkEntity>('bookMarks');
    setState(() {

           bookmarks = box.values.toList();
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<BookMarkEntity>('bookMarks');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Posts'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder:
            (BuildContext context, Box<BookMarkEntity> value, Widget? child) {
          final bookmarks = box.values.toList();

          if (bookmarks.isEmpty) {
            return const Center(child: Text('No bookmarks yet!'));
          }
          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarks[index];
              return ListTile(
                title: Text(bookmark.title),
                subtitle: Text(
                  bookmark.content.length > 50
                      ? '${bookmark.content.substring(0, 50)}...'
                      : bookmark.content,
                ),
                leading: bookmark.imageUrl != null
                    ? Image.network(bookmark.imageUrl!, width: 50)
                    : const Icon(Icons.bookmark),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
