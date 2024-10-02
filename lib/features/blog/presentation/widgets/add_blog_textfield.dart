import 'package:flutter/material.dart';

class AddBlogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AddBlogTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText cannot be empty';
        } else {
          return null;
        }
      },
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
