import 'package:blog/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = Palette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3.0),
        borderRadius: BorderRadius.circular(10),
      );
  static final ThemeData darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Palette.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27.0),
        enabledBorder: _border(),
        focusedBorder: _border(Palette.gradient2),
      ));

  static final ThemeData lightThemeMode = ThemeData.light().copyWith();
}
