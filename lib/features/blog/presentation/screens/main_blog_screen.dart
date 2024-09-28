import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MainBlogScreen extends StatefulWidget {
  const MainBlogScreen({super.key});

  @override
  State<MainBlogScreen> createState() => _MainBlogScreenState();
}

class _MainBlogScreenState extends State<MainBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox.expand(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/details_screen');
                },
                child: Text('got to details'))
          ],
        ),
      ),
    );
  }
}
