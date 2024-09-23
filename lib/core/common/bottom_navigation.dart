import 'package:blog_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:blog_app/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/profile/presentation/bloc/bottom_nav_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const String bottomNavBarId = '/bottom_nav';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    const ProfileScreen(),
    const TestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: Theme.of(context).iconTheme.color,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'خانه',
                    activeIcon: Icon(Icons.home)),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'پروفایل',
                  activeIcon: Icon(Icons.person),
                ),
              ],
              currentIndex:
                  BlocProvider.of<BottomNavCubit>(context).selectedIndex,
              onTap: (value) {
                BlocProvider.of<BottomNavCubit>(context).changeIndex(value);
              },
            ),
            body: screens.elementAt(
                BlocProvider.of<BottomNavCubit>(context).selectedIndex),
          ),
        );
      },
    );
  }
}
