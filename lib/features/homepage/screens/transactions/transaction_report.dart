import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card_background_design.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/add_expenses.dart';
import 'package:myflutterapp/features/widget/list_container_widget.dart';
import 'package:myflutterapp/models/user_model.dart';

class TransactionReport extends StatefulWidget {
  const TransactionReport({super.key});

  @override
  State<TransactionReport> createState() => _TransactionReportState();
}

class _TransactionReportState extends State<TransactionReport> {
  User? currentUser;
  
  final SharedPrefService prefService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    // getUserExpenses();
  }
  

 Future<void> getUserExpenses() async {
  User? user = await prefService.getCurrentUser();
  if (user != null) {
    setState(() {
      currentUser = user;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: 'Transaction Report',
          bgColor: Color(0xFF3629B7),
          txtColor: Color(0xFFFFFFFF),
          iconColor: Color(0xFFFFFFFF),
        ),
        backgroundColor: Color(0xFF3629B7),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(color: Color(0xFF3629B7), height: 200.h),
            Container(
              margin: EdgeInsets.only(top: 108.h),

              height: 632.h,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            CreditCardBackgroundDesign(
              cardHolderName:
                  currentUser!.transactionName ?? 'User name not found',
              cardNumber: '1234  ****   5678',
            ),

          //  Positioned(
          //   top: 290.h,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     width: double.infinity,
          //     padding: EdgeInsets.symmetric(horizontal: 16.w),
          //     height: 300.h, 
          //     child: ListView.builder(
          //       itemCount: currentUser?.category?.length ?? 0,
          //       itemBuilder: (context, index) {
          //         return ListContainerWidget(
          //           title: currentUser!.category![index],
          //           description: currentUser!.description![index],
          //           txtTapping: currentUser!.amount![index],
          //           txtTappingColor: Colors.red,
          //         );
          //       },
          //     ),
          //   ),
          // ),

            
            Positioned(
              top: 600.h,
              left: 290.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.small(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AddExpenses()),
                    );
                  },
                  tooltip: 'Add Expense',
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
