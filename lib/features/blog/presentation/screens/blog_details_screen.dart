import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogDetailsScreen extends StatefulWidget {
  const BlogDetailsScreen({super.key});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
         Expanded(child: Center(child: Text('This is the blog details screen'))),

        ],
      ),
    );
  }
}
