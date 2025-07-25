import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUserImgWidget extends StatelessWidget{

    final ImageProvider? img;
    final double? imgHeight;
    final double? imgWidth;

    const ProfileUserImgWidget({
      super.key,
      this.img, 
      this.imgHeight,
      this.imgWidth,
      });
 
  @override
  Widget build(BuildContext context) {
  
    return Container(
          margin: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
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