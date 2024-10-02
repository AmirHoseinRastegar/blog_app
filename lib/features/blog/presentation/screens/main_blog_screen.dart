import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainBlogScreen extends StatefulWidget {
  const MainBlogScreen({super.key});

  static rout() => MaterialPageRoute(
        builder: (context) => const MainBlogScreen(),
      );

  @override
  State<MainBlogScreen> createState() => _MainBlogScreenState();
}

class _MainBlogScreenState extends State<MainBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Blog'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_blog');
              },
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
