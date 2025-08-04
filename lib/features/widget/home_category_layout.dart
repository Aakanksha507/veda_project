import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeCategoryLayout extends StatelessWidget {
  final String text;
  final String? iconImg;
  final GestureTapCallback? ontap;

  const HomeCategoryLayout({
    super.key,
    required this.text,
    this.iconImg,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InkWell(
      onTap: ontap?? (){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.comingSoon),
          duration: Duration(seconds: 2), )
        );
  
      },
      
      child: Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color:Theme.of(context).colorScheme.onPrimary,
          // color: Colors.red,
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              offset: Offset(0, 5),
              spreadRadius: 0,
              color: Color(0x0D000000),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconImg!, height: 28.h, width: 28.w),
            SizedBox(height: 12.h),
            TextWidget(
              txt: text,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              txtColor: Color(0xFF979797),
              lineheight: 1.33,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
