import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/homepage/home_screen.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/beneficiary/beneficiary.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card_background_design.dart';
import 'package:myflutterapp/features/widget/list_container_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myflutterapp/models/user_model.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  // static const String validCardNumber = "1234 5678 999";

  @override
  State<CreditCard> createState() => _CreditCardState(); //create state
}

class _CreditCardState extends State<CreditCard> {
  User? currentUser;
  final SharedPrefService prefService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    checkUserCardData();
    loadUserAndBalance();
  }

  Future<void> checkUserCardData() async {
    User? user = await prefService.getCurrentUser();

    if (user == null || user.cardNumber == null || user.cardNumber!.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Beneficiary()),
      );
    } else {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> loadUserAndBalance() async {
    await getCardBalanceAmount();
    User? user = await prefService.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  Future<void> getCardBalanceAmount() async {
    User? user = await prefService.getCurrentUser();
    if (user != null) {
      double balance = getTotalAmount(user);
      user.cardBalance = balance.abs().toStringAsFixed(2);
      await prefService.setData(user);
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
    final loc = AppLocalizations.of(context)!;

    // final List<Map<String, dynamic>> item = [
    //   {
    //     'main':loc.buyCamera,
    //     'secondarytxt': '02/11/2018',
    //     'date': "-\$1200",
    //     'icon': 'assets/icon/14.svg',
    //     'bgColor': AppColor.primary1,
    //   },
    //   {
    //     'main': loc.buyTelevision,
    //     'secondarytxt': '02/11/2018',
    //     'date': "-\$1200",
    //     'icon': 'assets/icon/13.svg',
    //     'bgColor': AppColor.semantic1,
    //   },
    //   {
    //     'main': loc.buyCamera,
    //     'secondarytxt': '02/11/2018',
    //     'date': "-\$1200",
    //     'icon': 'assets/icon/14.svg',
    //     'bgColor': AppColor.semantic2,
    //   },
    //   {
    //     'main': loc.buyTelevision,
    //     'secondarytxt': '02/11/2018',
    //     'date': "-\$1200",
    //     'icon': 'assets/icon/13.svg',
    //     'bgColor': AppColor.semantic3,
    //   },
    // ];

    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: loc.creditCard,
          txtColor: AppColor.neutral6,
          iconColor: AppColor.neutral6,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          margin: EdgeInsets.only(top: 24.h),
          decoration: BoxDecoration(
            color: AppColor.neutral6,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            children: [
              CreditCardBackgroundDesign(
                cardHolderName: currentUser!.transactionName ?? "User",
                cardBalance: '\$${currentUser!.cardBalance ?? '0.00'}',
                cardColor:
                    getTotalAmount(currentUser!) < 0
                        ? Colors.red
                        : AppColor.neutral6,
                cardNumber: getMaskedCardNumber(currentUser!.cardNumber ?? ''),
              ),

              Padding(
                padding: EdgeInsets.only(top: 24.0, right: 24, left: 24),
                child: Container(
                  height: 300.h,
                  width: 327.w,
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: currentUser?.category?.length,
                          itemBuilder: (context, index) {
                            // final items = currentUser?.category?[index];
                            final categoryString =
                                currentUser!.category![index];
                            final categoryEnum =
                                ExpensesCategoryExtension.fromString(
                                  categoryString,
                                );
                            return ListContainerWidget(
                              leadingIconPath: categoryEnum.svgAsset,
                              iconBgColor: categoryEnum.backgroundColor,
                              title: categoryEnum.label(context),
                              description: currentUser!.description![index],
                              txtTapping:
                                  '\$${double.parse(currentUser!.amount![index]).abs().toStringAsFixed(2)}',
                              txtTappingColor: categoryEnum.amountColor,
                              txtTappingFontWeight: FontWeight.w600,
                              txtTappingFontSize: 16.0.sp,
                              padding: EdgeInsets.all(12.w),
                              margin: EdgeInsets.zero,
                              borderBottom: BorderSide(
                                color: Color(0xFFECECEC),
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(offset: Offset(0, 0), blurRadius: 0),
                              ],
                              // title: items['main'],
                              // description: items['secondarytxt'],
                              // txtTapping: items['date'],
                              // leadingIconPath: items['icon'],
                              // iconBgColor: items['bgColor'],
                              // txtTappingColor: AppColor.semantic1,
                              // padding: EdgeInsets.all(12.w),
                              // margin: EdgeInsets.zero,
                              // borderBottom: BorderSide(
                              //   color: Color(0xFFF2F2F2),
                              //   width: 1.0,
                              // ),
                              // // Border.(
                              // //   color: Color(0xFFF2F2F2),
                              // //   width: 1.0,
                              // // ),
                              // boxShadow: [
                              //   BoxShadow(offset: Offset(0, 0), blurRadius: 0),
                              // ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 24.w, left: 24.w, bottom: 12.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loc.total,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          '\$${getTotalAmount(currentUser!).abs().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                getTotalAmount(currentUser!) < 0
                                    ? Colors.red
                                    : AppColor.primary1,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: CustomButtonWidget(
                        btnText: loc.pay,
                        bgColorBtn: Theme.of(context).primaryColor,
                        isEnabled: getTotalAmount(currentUser!) < 0,
                        onTap: () async {
                          final currentUsers =
                              await prefService.getCurrentUser();

                          if (currentUsers != null) {
                            double totalAmount = getTotalAmount(currentUser!);

                            final updatedDescriptionList = List<String>.from(
                              currentUsers.description ?? [],
                            )..add('Debt Cleared');

                            final updatedAmountList = List<String>.from(
                              currentUsers.amount ?? [],
                            )..add(((totalAmount).toStringAsFixed(2)));

                            final updatedCategoryList = List<String>.from(
                              currentUsers.category ?? [],
                            )..add(ExpensesCategory.debtClerance.name);

                            final updatedUser = User(
                              id: currentUsers.id,
                              username: currentUsers.username,
                              phoneNumber: currentUsers.phoneNumber,
                              password: currentUsers.password,
                              bankName: currentUsers.bankName,
                              bankBranch: currentUsers.bankBranch,
                              transactionName: currentUsers.transactionName,
                              cardNumber: currentUsers.cardNumber,
                              category: updatedCategoryList,
                              description: updatedDescriptionList,
                              amount: updatedAmountList,
                            );

                            await prefService.setData(updatedUser);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loc.add_successfully),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }
                        },

                        // onTap: () async {
                        //   final currentUsers =
                        //       await prefService.getCurrentUser();
                        //   // double cardBalance =
                        //   //     double.tryParse(
                        //   //       currentUser!.cardBalance ?? '0',
                        //   //     ) ??
                        //   //     0.0;

                        //   double totalAmount = getTotalAmount(currentUser!);

                        //   // double updatedBalance = cardBalance - totalAmount;

                        //   // currentUser!.cardBalance = updatedBalance
                        //   //     .toStringAsFixed(2);

                        //   // currentUser!.amount?.clear();
                        //   // currentUser!.category?.clear();
                        //   // currentUser!.description?.clear();

                        //   // await prefService.setData(currentUser!);

                        //   // ScaffoldMessenger.of(context).showSnackBar(
                        //   //   SnackBar(
                        //   //     content: Text("Updated Successfully"),
                        //   //     duration: Duration(seconds: 1),
                        //   //   ),
                        //   // );
                        //   if (currentUsers != null) {
                        //     final updatedDescriptionList = List<String>.from(
                        //       currentUsers.description ?? [],
                        //     )..add('succesfully');
                        //     final updatedAmountList = List<String>.from(
                        //       currentUsers.amount ?? [],
                        //     )..add(totalAmount as String);
                        //     final updatedCategoryList = List<String>.from(
                        //       currentUsers.category ?? [],
                        //     )..add("Debt Clearance" ?? '');

                        //     final updateWithCategory = User(
                        //       id: currentUsers.id,
                        //       username: currentUsers.username,
                        //       phoneNumber: currentUsers.phoneNumber,
                        //       password: currentUsers.password,
                        //       bankName: currentUsers.bankName,
                        //       bankBranch: currentUsers.bankBranch,
                        //       transactionName: currentUsers.transactionName,
                        //       cardNumber: currentUsers.cardNumber,
                        //       category: updatedCategoryList,
                        //       description: updatedDescriptionList,
                        //       amount: updatedAmountList,
                        //     );

                        //     // debugPrint('Amoutn: ${updateWithCategory.amount}');

                        //     await prefService.setData(updateWithCategory);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(loc.add_successfully),
                        //         duration: Duration(seconds: 1),
                        //       ),
                        //     );
                        //   }
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomeScreen(),
                        //     ),
                        //   );
                        // },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
