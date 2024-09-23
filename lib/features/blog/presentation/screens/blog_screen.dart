import 'package:blog_app/core/common/bottom_nav.dart';
import 'package:blog_app/features/profile/presentation/bloc/bottom_nav_cubit.dart';
import 'package:blog_app/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/presentation/screens/profile_screen.dart';

class BlogScreen extends StatelessWidget {
  static rout() => MaterialPageRoute(builder: (context) => BlogScreen());

  BlogScreen({super.key});

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
        bottomNavigationBar: BottomNav(
          controller: controller,
        ),
        body: PageView(
          controller: controller,
          children: screens,
          onPageChanged: (value){
             BlocProvider.of<BottomNavCubit>(context).changeIndex(value);
          },
        ),
      ),
    );
  }
}
