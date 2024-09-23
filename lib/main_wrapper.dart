// import 'package:blog_app/core/common/bottom_nav.dart';
// import 'package:blog_app/features/blog/presentation/screens/blog_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'features/profile/presentation/screens/profile_screen.dart';
//
// class MainWrapper extends StatelessWidget {
//  final PageController controller = PageController();
//
//   MainWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> screens = [
//       const ProfileScreen(),
//       const ProfileScreen(),
//       // const BlogScreen(),
//
//     ];
//
//     return Scaffold(
//       bottomNavigationBar:  BottomNav(controller: controller,),
//       body: PageView(
//         controller: controller,
//         children: screens,
//       ),
//     );
//   }
// }
