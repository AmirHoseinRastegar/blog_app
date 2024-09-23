import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String? title;
  const ProfileScreen({super.key, this.title=''});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: Text(title!),
      ),
    );
  }
}
