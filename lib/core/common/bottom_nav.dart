import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/profile/presentation/bloc/bottom_nav_cubit.dart';
import '../../features/blog/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class BottomNav extends StatefulWidget {
  final PageController controller;

  const BottomNav({
    super.key,
    required this.controller,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

final List<Widget> screens = [
  const ProfileScreen(),
  const HomeScreen(), // const BlogScreen(),
];

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(builder: (context, state) {
      return BottomAppBar(
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      /// change selected index
                      BlocProvider.of<BottomNavCubit>(context).changeIndex(0);
                      widget.controller.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: state == 0
                        ? const Icon(Icons.home_filled)
                        : const Icon(Icons.home_outlined),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<BottomNavCubit>(context).changeIndex(1);
                      widget.controller.animateToPage(1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: state == 1
                        ? const Icon(Icons.person)
                        : const Icon(Icons.person_2_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

//           currentIndex:
//               BlocProvider.of<BottomNavCubit>(context).selectedIndex,
//           selectedItemColor: Colors.red.withOpacity(0.7),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: "Profile",
//             ),
//           ],
//           onTap: (value) {
//             BlocProvider.of<BottomNavCubit>(context).changeIndex(value);
//           },
//
//          Row(
//           children: [
//             IconButton(
//               onPressed: () {
//                 widget.controller.animateToPage(0,
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.decelerate);
//               },
//               icon: const Icon(Icons.home),
//             ), IconButton(
//               onPressed: () {
//                 widget.controller.animateToPage(1,
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.decelerate);
//               },
//               icon: const Icon(Icons.person),
//             ),
//
//           ],
//         ));
//   },
// );
