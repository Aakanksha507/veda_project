import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/enumClass/enum.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/home_screen.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card_background_design.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/add_expenses.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/edit_expenses.dart';
import 'package:myflutterapp/features/widget/list_container_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    getUserExpenses();
  }

  Future<void> getUserExpenses() async {
    User? user = await prefService.getCurrentUser();
    if (user != null) {
      if (mounted){
        setState(() {
        currentUser = user;
      });
      }  
    }
  }

  String getMaskedCardNumber(String cardNumber) {
    String cleaned = cardNumber.replaceAll(' ', '');
    if (cleaned.length < 7) return cardNumber;

    String firstFour = cleaned.substring(0, 4);
    String lastThree = cleaned.substring(cleaned.length - 3);

    return '$firstFour  ****   $lastThree';
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

  @override
  Widget build(BuildContext context) {
      final loc = AppLocalizations.of(context)!;
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: loc.transactionReport,
          bgColor: Theme.of(context).appBarTheme.backgroundColor,
          txtColor: Color(0xFFFFFFFF),
          iconColor: Color(0xFFFFFFFF),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(color: Theme.of(context).primaryColor, height: 200.h),
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
              cardNumber: getMaskedCardNumber(currentUser!.cardNumber ?? ''),
              cardBalance: getTotalAmount(currentUser!).toStringAsFixed(2),
            ),

            Positioned(
              top: 290.h,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                // height: 300.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: currentUser?.category?.length,
                      itemBuilder: (context, index) {
                        // final items = currentUser?.category?[index];
                        final categoryString = currentUser!.category![index];
                        final categoryEnum =
                            ExpensesCategoryExtension.fromString(
                              categoryString,
                            );
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              currentUser?.category?.removeAt(index);
                              currentUser?.amount?.removeAt(index);
                              currentUser?.description?.removeAt(index);
                            });

                            if (currentUser != null) {
                              prefService.setData(currentUser!);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(loc.deleted_successfully)),
                            );

                          },

                          background: Container(color: Colors.red),

                          child: GestureDetector(
                            onLongPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EditExpenses(
                                        category: currentUser!.category![index],
                                        description:currentUser!.description![index],
                                        amount: currentUser!.amount![index],
                                        index : index,
                                      ),
                                ),
                              );
                            },
                            child: ListContainerWidget(
                              leadingIconPath: categoryEnum.svgAsset,
                              iconBgColor: categoryEnum.backgroundColor,
                              title: categoryEnum.label(context),
                              description: currentUser!.description![index],
                              txtTapping:
                                  '${categoryEnum.amountSign}\$${currentUser!.amount![index]}',
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
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
