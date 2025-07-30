import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class TextImgDesignlayoutWidget extends StatelessWidget {

  final String titleText;
  
  final String secondaryText;
  final Image? img;
  const TextImgDesignlayoutWidget({super.key,
   required this.titleText, required this.secondaryText, this.img});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(txt: titleText,
         fontSize: 24.sp,
          fontWeight: FontWeight.w600,
           txtColor: AppColor.primary1,
        ), 
        TextWidget(txt: secondaryText,
         fontWeight: FontWeight.w500,
          fontSize: 12.sp),

          Padding(
            padding: const EdgeInsets.only(top:32.0),
            child: Center(
              child: SizedBox(
                height:165.h , width: 213.w,
                child: img ??
                 Image.asset("assets/image/Illustration.png"),
              )
               ),
          ),
        
      ],
    );
  }
}