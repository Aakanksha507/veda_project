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
  User ? currentUser;
  final SharedPrefService prefService = SharedPrefService();

@override
void initState() {
 super.initState();
 getUserExpenses();
}
  
  Future <void> getUserExpenses() async{
    List<User?> users = (await prefService.getCurrentUser()) as List<User?>;
    setState(() {
      currentUser = users.last;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              color: Color(0xFF3629B7),
              height: 200.h,
            ),
            Container(
              margin: EdgeInsets.only(top: 108.h),
             
              height: 632.h,
              decoration: BoxDecoration(
                 color: Color(0xFFFFFFFF),
                 borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                 ),
                 boxShadow:[BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    spreadRadius: 0
                  )], 
              ),
            ),
            CreditCardBackgroundDesign(
                      cardHolderName: 'User Name',
                      cardNumber: '1234  ****   5678',
            ),

           currentUser == null
          ? Center(child: CircularProgressIndicator())
          : Positioned(
              top: 290.h, 
              child: ListContainerWidget(
                title: '${currentUser!.amount}',
                description: '${currentUser!.amount}',
              ),
            ),


            Positioned(
              top: 600.h,
              left: 290.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.small(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExpenses(),
                      ),
                    );
                  },
                  tooltip: 'Add Expense',
                  child: Icon(Icons.add),
                ),
              ),
            )
            
          ],
        ),

      ),
    );
  }
}
