import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/cutom_toggle_switch_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/screen_layout.dart';
import 'package:myflutterapp/features/homepage/screens/beneficiary/beneficiary.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card.dart';
import 'package:myflutterapp/features/auth/login/sign_in_page.dart';
import 'package:myflutterapp/features/homepage/screens/credit_card_background_design.dart';
import 'package:myflutterapp/features/homepage/screens/transactions/transaction_report.dart';
import 'package:myflutterapp/features/widget/home_category_layout.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/models/user_model.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  User? currentUser;

  String getMaskedCardNumber(String cardNumber) {
    String cleaned = cardNumber.replaceAll(' ', ''); 
    if (cleaned.length < 7) return cardNumber;

    String firstFour = cleaned.substring(0, 4);
    String lastThree = cleaned.substring(cleaned.length - 3);

    return '$firstFour  ****   $lastThree';
    }
 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScreenLayout(marginOfWhiteContainer: EdgeInsets.only(top: 130.h)),
        Align(
          alignment: Alignment.topLeft,
          child: ProfileUserImgWidget(
            imgHeight: 50.h,
            imgWidth: 50.w,
            imgMargin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 56.h),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 92.w, vertical: 69.h),
          child: ProfileUsernameWidget(
            username: 'Hi, Push Puttichai',
            txtColor: Color(0xFFFFFFFF),
            txtFontWeight: FontWeight.w500,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 60.h),
          child: Align(
            alignment: Alignment.topRight,
            child: CutomToggleSwitchWidget()),
        ),
        GestureDetector(
          onTap: () async {
            final prefService = SharedPrefService();
            await prefService.clearData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SignInPage()),
              (route) => false,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 67.h),
            child: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                'assets/icon/notify_bell.svg',
                height: 28.h,
                width: 26.w,
              ),
            ),
          ),
        ),

        Positioned(top: 130.h, child: CreditCardBackgroundDesign(
          // cardHolderName: currentUser!.transactionName ?? 'USer not found',
          // cardNumber:getMaskedCardNumber(currentUser!.cardNumber ?? '123214123'),
        )),

        Positioned(
          top: 391.h,
          left: 24.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  HomeCategoryLayout(
                    text: 'Account and Card',
                    iconImg: 'assets/icon/home_icon/accountCard.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: 'Transfer',
                    iconImg: 'assets/icon/home_icon/transfer.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: 'Withdraw',
                    iconImg: 'assets/icon/home_icon/withdraw.svg',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  HomeCategoryLayout(
                    text: 'Mobile prepaid',
                    iconImg: 'assets/icon/home_icon/mobilePrepaid.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: 'Pay the bill',
                    iconImg: 'assets/icon/home_icon/receipt.svg',
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: 'Save online',
                    iconImg: 'assets/icon/home_icon/pig.svg',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  HomeCategoryLayout(
                    text: 'Credit card',
                    iconImg: 'assets/icon/home_icon/creditCard.svg',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreditCard()),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: 'Transaction Report',
                    iconImg: 'assets/icon/home_icon/report.svg',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionReport(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  HomeCategoryLayout(
                    text: 'Beneficiary',
                    iconImg: 'assets/icon/home_icon/beneficiary.svg',
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Beneficiary()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
