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
  double cardBalance = 0.0;
  
  final SharedPrefService prefService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    getUserExpenses();
  }

  void txtTapping(int index) {
  setState(() {
    cardBalance += double.parse(currentUser!.amount![index]);
  });
}

  

 Future<void> getUserExpenses() async {
  User? user = await prefService.getCurrentUser();
  if (user != null) {
    setState(() {
      currentUser = user;
    });
  }
}

String getMaskedCardNumber(String cardNumber){

  String cleaned = cardNumber.replaceAll(' ', '');
  if(cleaned.length < 7) return cardNumber;

  String firstFour = cleaned.substring(0,4);
  String lastThree = cleaned.substring(cleaned.length - 3);

 return '$firstFour  ****   $lastThree';

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
              cardNumber: getMaskedCardNumber(currentUser!.cardNumber ??''),
              cardBalance: cardBalance.toStringAsFixed(2),
            ),


           Positioned(
            top: 290.h,
            left: 0,
            right: 0,
            child: Container(
              // width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
              ),
              // height: 300.h, 
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: currentUser?.category?.length,
                    itemBuilder: (context, index) {
                      final items = currentUser?.category?[index];
                      return ListContainerWidget(
                        title: currentUser!.category![index],
                        description: currentUser!.description![index],
                        txtTapping: '\$${currentUser!.amount![index]}',
                        txtTappingColor: Color(0xFFFF4267), 
                        padding: EdgeInsets.all(12.w),
                        margin: EdgeInsets.zero,
                        borderBottom: BorderSide(
                          color: Color(0xFFECECEC),
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(offset: Offset(0, 0), blurRadius:0 )
                        ],
                      );
                    },
                ),]
              ),
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
