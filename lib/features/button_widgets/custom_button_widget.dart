import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  final String btnText;
  final Color? bgColorBtn;
  final bool isEnabled;
  final VoidCallback? onTap;

  const CustomButtonWidget({
    super.key,
    required this.btnText,
    this.bgColorBtn,
    this.isEnabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isEnabled ? bgColorBtn ?? theme.primaryColor : theme.scaffoldBackgroundColor,
        minimumSize: Size(327.w, 44.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: TextWidget(
        txt: btnText,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        txtColor: AppColor.neutral6,
      ),
    );
  }
}
