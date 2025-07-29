import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/beneficiary/beneficiary.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card_background_design.dart';
import 'package:myflutterapp/features/widget/list_container_widget.dart';

import 'package:myflutterapp/models/user_model.dart';

class CreditCard extends StatefulWidget {
  
  const CreditCard({super.key});

  // static const String validCardNumber = "1234 5678 999";

  @override
  State<CreditCard> createState() => _CreditCardState();  //create state
}

class _CreditCardState extends State<CreditCard> {

  
  
  final List<Map<String, dynamic>> item = const [
    {
      'main': 'Buy Camera',
      'secondarytxt': '02/11/2018',
      'date': "-\$1200",
      'icon': 'assets/icon/14.svg',
      'bgColor': Color(0xFF3629B7),
    },
    {
      'main': 'Buy Television',
      'secondarytxt': '02/11/2018',
      'date': "-\$1200",
      'icon': 'assets/icon/13.svg',
      'bgColor': Color(0XFFFF4267),
    },
    {
      'main': 'Buy Camera',
      'secondarytxt': '02/11/2018',
      'date': "-\$1200",
      'icon': 'assets/icon/14.svg',
      'bgColor': Color(0XFF0890FE),
    },
    {
      'main': 'Buy Television',
      'secondarytxt': '02/11/2018',
      'date': "-\$1200",
      'icon': 'assets/icon/13.svg',
      'bgColor': Color(0XFFFFAF2A),
    },
  ];

  User? currentUser;
  final SharedPrefService prefService = SharedPrefService();

@override
void initState() {
 super.initState();
 checkUserCardData();
}

Future<void> checkUserCardData() async {
 User? user = await prefService.getCurrentUser();

  if (user == null || user.cardNumber == null || user.cardNumber!.isEmpty) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Beneficiary(),
      ),
    );
  } else {
    setState(() {
      currentUser = user;
    });
  }

}

double getTotalAmount(User user) {
    double total = 0.0;

    for (int i = 0; i < user.amount!.length; i++) {
      final amountString = user.amount![i];
      final categoryString = user.category![i];

      final categoryEnum = ExpensesCategoryExtension.fromString(categoryString);
      final parsedAmount = double.tryParse(amountString) ?? 0.0;

      if (categoryEnum == ExpensesCategory.salaries) {
        total += parsedAmount;
      } else {
        total -= parsedAmount;
      }
    }

    return total;
  }


String getMaskedCardNumber(String cardNumber) {
 String cleaned = cardNumber.replaceAll(' ', ''); 
 if (cleaned.length < 7) return cardNumber;

 String firstFour = cleaned.substring(0, 4);
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
          mainTxt: 'Credit Card',
          bgColor: Color(0xFF3629B7),
          txtColor: Color(0xFFFFFFFF),
          iconColor: Color(0xFFFFFFFF),
        ),
        backgroundColor: Color(0xFF3629B7),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF3629B7),
          child: Container(
            margin: EdgeInsets.only(top: 24.h),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                CreditCardBackgroundDesign(
                  cardHolderName: currentUser!.transactionName ?? "User",
                   cardBalance: getTotalAmount(currentUser!).toStringAsFixed(2),
                  cardNumber: getMaskedCardNumber(currentUser!.cardNumber ?? ''),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 30.r,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            final items = item[index];
                            return ListContainerWidget(
                              title: items['main'],
                              description: items['secondarytxt'],
                              txtTapping: items['date'],
                              leadingIconPath: items['icon'],
                              iconBgColor: items['bgColor'],
                              txtTappingColor: Color(0xFFFF4267),
                              padding: EdgeInsets.all(12.w),
                              margin: EdgeInsets.zero,
                              borderBottom: BorderSide(
                                color: Color(0xFFF2F2F2),
                                width: 1.0,
                              ),
                              // Border.(
                              //   color: Color(0xFFF2F2F2),
                              //   width: 1.0,
                              // ),
                              boxShadow: [
                                BoxShadow(offset: Offset(0, 0), blurRadius: 0),
                              ],
                            );
                          },
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$1234.56',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF4267),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: CustomButtonWidget(
                            btnText: 'Pay',
                            onTap: () {
                            
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
