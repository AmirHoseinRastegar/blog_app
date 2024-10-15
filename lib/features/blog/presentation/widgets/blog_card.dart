import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_details_screen.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/utils/reading_time_algoritm.dart';

class BlogCard extends StatefulWidget {
  final Color color;
  final BlogEntity blog;

  const BlogCard({
    super.key,
    required this.color,
    required this.blog,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isBookmarked = false; // Track bookmark status locally

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<bool> _checkBookmarkStatus() async {
    final box = await Hive.openBox<BookMarkEntity>('bookMarks');
    return box.containsKey(widget.blog.id);
  }

  void _toggleBookmark() async {
    final box = await Hive.openBox<BookMarkEntity>('bookMarks');
    if (await _checkBookmarkStatus()) {
      await box.delete(widget.blog.id);
    } else {
      final bookmark = BookMarkEntity.fromBlogEntity(widget.blog);
      await box.put(widget.blog.id, bookmark);
      print(widget.blog.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _checkBookmarkStatus(),
        builder: (context, snapshot) {
          final isBookmarked = snapshot.data ?? false;
          return InkWell(
            onTap: () {
              Navigator.push(context, BlogDetailsScreen.route(widget.blog));
            },
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16).copyWith(bottom: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: widget.color),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.blog.topics

                              ///by using this map in the row children we can access each one of
                              ///children using e of the map and do the operations
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Chip(
                                    label: Text(
                                      e,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          widget.blog.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                                '${readingTimeCalculator(widget.blog.content)}min'),
                          ),
                          IconButton(
                            onPressed: _toggleBookmark,
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
