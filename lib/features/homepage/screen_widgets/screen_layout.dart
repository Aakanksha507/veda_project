import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ScreenLayout extends StatelessWidget {
  final EdgeInsetsGeometry? marginOfWhiteContainer;

  const ScreenLayout({super.key, this.marginOfWhiteContainer});

  @override
  Widget build(BuildContext  context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),

          child: Container(
            margin: marginOfWhiteContainer?? EdgeInsets.only(top: 78.h),
            decoration: BoxDecoration(
              color:Theme.of(context).colorScheme.secondary,
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
