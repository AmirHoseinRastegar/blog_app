import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/reading_time_algoritm.dart';

class BlogCard extends StatelessWidget {
  final Color color;
  final BlogEntity blog;

  const BlogCard({super.key, required this.color, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
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
                  children: blog.topics

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
                  blog.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text('${readingTimeCalculator(blog.content)}min'),
              )
            ],
          )
        ],
      ),
    );
  }
}
