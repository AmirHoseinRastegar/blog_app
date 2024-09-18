import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogScreen());
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
