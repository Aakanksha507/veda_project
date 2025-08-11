import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUserImgWidget extends StatelessWidget {
  final ImageProvider? img;
  final double? imgHeight;
  final double? imgWidth;
  final EdgeInsetsGeometry? imgMargin;
  final Widget? child;
  

  const ProfileUserImgWidget({
    super.key,
    this.img,
    this.imgHeight,
    this.imgWidth,
    this.imgMargin,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          imgMargin ?? EdgeInsets.symmetric(horizontal: 140.w, vertical: 15.h),
      height: imgWidth ?? 120.h,
      width: imgWidth ?? 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: img ?? AssetImage("assets/image/img1.png"),
          fit: BoxFit.cover,
        ),
      ),
       child: child,
      // Align(
      //   alignment: Alignment.bottomRight,
      //   child: SvgPicture.asset(
      //     'assets/icon/roundedButton.svg',
      //     height: 32.h, width: 32.w,
      //   ),
      // ),
    );
  }
}
