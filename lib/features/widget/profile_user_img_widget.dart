import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUserImgWidget extends StatelessWidget{

    final ImageProvider? img;
    final double? imgHeight;
    final double? imgWidth;
    final EdgeInsetsGeometry? imgMargin;

    const ProfileUserImgWidget({
      super.key,
      this.img, 
      this.imgHeight,
      this.imgWidth, 
      this.imgMargin,
      });
 
  @override
  Widget build(BuildContext context) {
  
    return Container(
          margin: imgMargin?? EdgeInsets.symmetric(horizontal: 140.w, vertical: 15.h),
          height: imgWidth?? 120.h,
          width: imgWidth?? 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image:img ?? AssetImage("assets/image/img1.png"), 
              fit: BoxFit.cover, 
              ),
          ),
    );
  }
}