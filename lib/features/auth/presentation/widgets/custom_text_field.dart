import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconButton? icon;
  final bool isObscured;
  final TextEditingController controller;

  const CustomTextField(
      {super.key, required this.hintText, required this.controller, this.icon, required this.isObscured});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: icon,
      ),
    );
  }
}
