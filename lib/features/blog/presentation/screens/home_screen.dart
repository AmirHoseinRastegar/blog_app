import 'package:blog_app/features/blog/presentation/screens/blog_details_screen.dart';
import 'package:blog_app/features/blog/presentation/screens/main_blog_screen.dart';
import 'package:flutter/material.dart';

import 'add_blogs_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? title;

  const HomeScreen({super.key, this.title = ''});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            switch (settings.name) {
              case '/':
                return const MainBlogScreen();
              case '/details_screen':
                return const BlogDetailsScreen();
              case '/add_blog':
                return const AddBlogsScreen();
            }
            return Container();
          },
        );
      },
    );
  }
}
