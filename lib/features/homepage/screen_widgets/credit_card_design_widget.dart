import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';

class CreditCardDesignWidget extends StatelessWidget {
  final String? cardHolderName;
  final String? cardName;
  final String? cardNumber;
  final String? cardBalance;

  const CreditCardDesignWidget({
    super.key,
    this.cardHolderName,
    this.cardNumber,
    this.cardName,
    this.cardBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 204.h,
          width: 375.w,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/creditcard.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 30,
                offset: Offset(0, 5),
              ),
            ],
          ),
          // child: SvgPicture.asset(
          //   'assets/image/creditcard.svg',
          //   fit: BoxFit.cover,
          // ),
        ),
        Positioned(
          top: 21.h,
          left: 44.4.w,
          child: TextWidget(
            txt: cardHolderName ?? 'John Smith',
            fontWeight: FontWeight.w400,
            fontSize: 24.sp,
            txtColor: Color(0xFFFFFFFF),
          ),
        ),
        Positioned(
          top: 92.82.h,
          left: 44.4.w,
          child: TextWidget(
            txt: 'Amazon Platinium',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            txtColor: Color(0xFFFFFFFF),
          ),
        ),
        Positioned(
          top: 121.96.h,
          left: 44.4.w,
          child: TextWidget(
            txt: cardNumber ?? '4768  ****  ****  1234',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            txtColor: Color(0xFFFFFFFF),
          ),
        ),
        Positioned(
          top: 149.94.h,
          left: 44.4.w,
          child: TextWidget(
            txt: cardBalance ?? '\$3.469,52',
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            txtColor: Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }
}
