import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData lighttheme(){
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xFFFFFFFF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3629B7),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
        )
      ),
      // colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, surface: surface, onSurface: onSurface)
    );
  }
  static ThemeData darkTheme(){
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 9, 8, 24),
        titleTextStyle: TextStyle(
          color: Colors.blue,
        )
      )
    );
  }
}