import 'package:flutter/material.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class AppTheme {
  static ThemeData lighttheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFF3629B7),

      scaffoldBackgroundColor: Color(0xFFFFFFFF),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primary1,
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 20, 20, 20)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.neutral6,
        selectedItemColor: AppColor.primary1,
        unselectedItemColor: AppColor.neutral2,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.primary1,
        onPrimary: AppColor.neutral6,
        secondary: AppColor.neutral6,
        onSecondary: AppColor.neutral6,
        error: AppColor.primary1,
        onError: AppColor.primary1,
        surface: AppColor.primary4,
        onSurface: AppColor.primary1,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xFF3629B7),
      scaffoldBackgroundColor: AppColor.neutral1,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.neutral1,
        titleTextStyle: TextStyle(color: Colors.blue),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.primary2,
        unselectedItemColor: AppColor.neutral6,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColor.neutral1,
        onPrimary: AppColor.neutral5,
        secondary: AppColor.neutral4,
        onSecondary: AppColor.neutral4,
        error:  Colors.red,
        onError: Colors.red,
        surface: AppColor.neutral1,
        onSurface: AppColor.primary1,
      ),
    );
  }
}
