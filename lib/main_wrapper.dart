import 'package:blog_app/core/common/bottom_nav.dart';
import 'package:blog_app/features/profile/presentation/bloc/bottom_nav_cubit.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/bottom_navigation.dart';
import 'features/profile/presentation/screens/profile_screen.dart';

class MainWrapper extends StatelessWidget {
  static rout() => MaterialPageRoute(builder: (context) => MainWrapper());

  MainWrapper({super.key});

  final PageController controller = PageController();

  final List<Widget> screens = [
    const ProfileScreen(
      title: 'hello',
    ),
    const TestScreen()
    // const BlogScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        body: IndexedStack(
          index:  BlocProvider.of<BottomNavCubit>(context).selectedIndex,
          children: screens,
        ),
      ),
    );
  }
}
