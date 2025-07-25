import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';

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

    return ElevatedButton(
      onPressed: isEnabled ? onTap : null, 
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ?
        bgColorBtn ?? Color(0xFF3629B7)
        :Color(0xFFA8A3D7) ,
        minimumSize: Size(327.w, 44.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: TextWidget(
        txt: btnText,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        txtColor: Color(0xFFFFFFFF),
      ),
    );
  }
}
