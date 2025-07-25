import 'package:flutter/material.dart';
import 'package:myflutterapp/features/auth/login/sign_in_page.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/home_screen.dart';

class CheckingLoginStatus extends StatelessWidget{
   CheckingLoginStatus({super.key});

  final SharedPrefService prefService = SharedPrefService();

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: prefService.isUserLoggedIn(),
       builder: (context, snapshot){
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return HomeScreen(); 
        } else {
          return SignInPage(); 
        }

       }
    );
  }
}