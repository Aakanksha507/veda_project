import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/auth/login/checking_login_status.dart';


void main() => runApp
(ScreenUtilInit(
    designSize: Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    ensureScreenSize: true,
    builder:(context, child)=> const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckingLoginStatus(),
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


