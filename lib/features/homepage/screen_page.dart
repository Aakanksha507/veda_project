import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/screens/beneficiary.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card.dart';
import 'package:myflutterapp/features/auth/login/sign_in_page.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/transaction_report.dart';

class ScreenPage extends StatelessWidget {
  const ScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreditCard(),
                      ),
                    );
                  },
                  child: const Text('Go to Credit Page'),
                ),
               
                SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    final prefService = SharedPrefService();
                    await prefService.clearData();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => SignInPage()),
                      (route) => false,
                    );
                  },
                  child: Text("logout"),
                ),

                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionReport(),
                      ),
                    );
                  },
                  child: const Text('Go to Transaction Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
