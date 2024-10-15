import 'package:blog_app/features/profile/presentation/screens/favorites_screen.dart';
import 'package:flutter/material.dart';

import '../../../blog/presentation/screens/main_blog_screen.dart';
import '../../../bookmark/presentation/screens/bookmark_screen.dart';
import 'main_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: profileKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case '/':
                  return const MainProfileScreen();
                case '/favorite_posts':
                  return const BookmarksScreen();
              }
              return Container();
            },
          );
        });
  }
}
