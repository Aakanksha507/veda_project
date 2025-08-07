import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/credit_card_design_widget.dart';

class CreditCardBackgroundDesign extends StatelessWidget {
  final String? cardHolderName;
  final String? cardName;
  final String? cardNumber;
  final String? cardBalance;
  final Color? cardColor;

  const CreditCardBackgroundDesign({
    super.key,
    this.cardHolderName,
    this.cardName,
    this.cardNumber,
    this.cardColor,
    this.cardBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 57.0.w, right: 57.0.w, top: 75.0.h),
          child: Container(
            height: 164.h,
            width: 261.w,
            decoration: BoxDecoration(
              color: AppColor.primary2,
              borderRadius: BorderRadius.circular(10.0.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D3629B7),
                  blurRadius: 30,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 44.0.w, right: 44.0.w, top: 50.0.h),
          child: Container(
            height: 178.h,
            width: 287.w,
            decoration: BoxDecoration(
              color: AppColor.semantic1,
              borderRadius: BorderRadius.circular(10.0.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D3629B7),
                  blurRadius: 30,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          child: CreditCardDesignWidget(
            cardHolderName: cardHolderName,
            cardName: cardName,
            cardNumber: cardNumber,
            cardBalance: cardBalance,
            cardColor: cardColor,
          ),
        ),
      ],
    );
  }
}
