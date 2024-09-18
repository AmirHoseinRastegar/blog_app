import 'package:blog_app/core/theme/pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final _border = OutlineInputBorder(
      borderSide: const BorderSide(color: Pallet.borderColor, width: 3),
      borderRadius: BorderRadius.circular(10));
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: Pallet.backgroundColor),
    scaffoldBackgroundColor: Pallet.backgroundColor,
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(Pallet.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border,
      border: _border,
      focusedBorder: _border.copyWith(
        borderSide: const BorderSide(color: Pallet.gradient2, width: 3),
      ),
      errorBorder: _border.copyWith(
        borderSide: const BorderSide(color: Pallet.errorColor, width: 3),
      ),
    ),
  );
}
