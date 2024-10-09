import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/core/utils/reading_time_algoritm.dart';
import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogDetailsScreen extends StatelessWidget {
  static route(BlogEntity blog) {
    return MaterialPageRoute(
        builder: (context) => BlogDetailsScreen(blog: blog));
  }

  final BlogEntity? blog;

  const BlogDetailsScreen({super.key, this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog!.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  'by ${blog!.name}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${formatDateTime(blog!.updatedAt)}  ${readingTimeCalculator(blog!.content)} min',
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    blog!.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  blog!.content,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
