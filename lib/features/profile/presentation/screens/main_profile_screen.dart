import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SizedBox.expand(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.of(context).pushNamed('/profile_details');
              }, child: Text('got to Profiles Details'))
            ],
          ),
        ),
      ),
    );
  }
}
