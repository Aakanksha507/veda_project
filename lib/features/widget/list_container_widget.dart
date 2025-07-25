import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
// import 'package:myflutterapp/widget/text_widget.dart';


class ListContainerWidget extends StatelessWidget{
  final String title ;
  final String description;
  final String? leadingIconPath;
  final Color? iconBgColor;
  final Color? txtTappingColor;
  final String? txtTapping;
  final Widget? iconTapping;
  final double? height;
  final double? width;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderSide ? borderBottom;
  final BorderRadiusGeometry? borderRadius;



  
  const ListContainerWidget({
    super.key, 
    required this.title,  
    required this.description,
    this.leadingIconPath, 
    this.iconBgColor,
    this.txtTapping,
    this.txtTappingColor,
    this.iconTapping,
    this.height,
    this.width,
    this.radius = 0.0,
    this.boxShadow,
    this.padding,
    this.margin,
    this.borderBottom,
    this.borderRadius,
  
   
  
  });
    
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        padding: padding ?? EdgeInsets.all(12.w),
        margin: margin?? EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(radius ?? 0.0.r),
           border: Border(bottom: borderBottom??BorderSide(
            color: Color(0xFFFFFFFF),
            width: 1,
           )),
           boxShadow:boxShadow ??
                 [ BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 30,
                offset: Offset(0, 5),
                
              ),
            ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           if (leadingIconPath != null)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: iconBgColor ?? const Color.fromARGB(255, 12, 12, 12),
                  ),
                  child: SvgPicture.asset(
                    leadingIconPath!,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
            SizedBox(width: 12.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  TextWidget(txt: title,
                   fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                     txtColor: Color(0xFF343434),
                  ),
                  TextWidget(txt: description,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    txtColor: Color(0xFF989898),
                    
                  ) 
                ],
              )
              ),
      
              if(iconTapping != null || txtTapping != null) ...[
               SizedBox(width: 12.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconTapping != null) iconTapping!,
                  if (txtTapping != null) ...[
                    if (iconTapping != null)  SizedBox(width: 4.w),
                    TextWidget(
                      txt: txtTapping!,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      txtColor: txtTappingColor ?? Color(0xFF989898)),
                  ],
                ],
              )
          ],
        ],
        ),
      ),
    );
  }
}







