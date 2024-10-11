import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  static rout() => MaterialPageRoute(builder: (context) => const FavoritesScreen());
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:  ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {

        },),
      ),
    );
  }
}
