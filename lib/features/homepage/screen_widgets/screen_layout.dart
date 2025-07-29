import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenLayout extends StatelessWidget {
  final EdgeInsetsGeometry? marginOfWhiteContainer;

  const ScreenLayout({super.key, this.marginOfWhiteContainer});

  @override
  Widget build(Object context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xff3629B7)),

          child: Container(
            margin: marginOfWhiteContainer?? EdgeInsets.only(top: 78.h),
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
        ),
      ],
    );
  }
}
