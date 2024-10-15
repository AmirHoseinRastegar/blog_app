import 'package:blog_app/core/constants/loading.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/blog/domain/entites/hive_manager.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_details_screen.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:blog_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:blog_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/reading_time_algoritm.dart';

class BlogCard extends StatefulWidget {
  final Color color;
  final BlogEntity blog;
  final BookMarkEntity? bookmark;

  const BlogCard(
      {super.key, required this.color, required this.blog, this.bookmark});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        context
                            .read<BookmarkBloc>()
                            .add(ToggleBookmarkEvent(widget.bookmark!));
                        //  if (!HiveManager.isBookMarked(blog: widget.blog)) {
                        // HiveManager.addToBookmark(blog: widget.blog);
                        //  } else {
                        //    HiveManager.removeBookmark(blog: widget.blog);
                        //  }
                        //  setState(() {});
                      },
                      icon: Icon(
                        HiveManager.isBookMarked(blog: widget.blog)
                            ? Icons.bookmark_border
                            : Icons
                                .bookmark, // Toggle between filled/unfilled icons
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
  }
}
