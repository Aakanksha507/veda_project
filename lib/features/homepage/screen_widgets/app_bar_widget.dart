import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget{

  final String mainTxt;
  final Color? bgColor;
  final Color? txtColor;
  final Color? iconColor;
  final GestureTapCallback? onTap;

  const AppBarWidget({
    super.key, 
    required this.mainTxt,
    this.bgColor,
    this.txtColor,
    this.iconColor,
    this.onTap,
    });

   @override
  Widget build(BuildContext context) {
       return AppBar( 
        // automaticallyImplyLeading: false,
        backgroundColor: bgColor ?? Theme.of(context).appBarTheme.backgroundColor,    
        title: 
            Text(mainTxt,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
               fontWeight: FontWeight.w600, 
                color:txtColor ?? Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),  
            
            
        ),
        leadingWidth: 16.w,
      
        leading:Padding(
          padding: EdgeInsets.all(4.w),
          child: GestureDetector(
            onTap:onTap ?? () {
              Navigator.pop(context); 
            },
            child: SvgPicture.asset('assets/icon/Path.svg',
             height: 16.h,
              width: 16.w,
              colorFilter: ColorFilter.mode(iconColor ?? Colors.white, BlendMode.srcIn),
              //  color: iconColor ?? Color(0xFFFFFFFF),
            ), 
          ),
        ) ,
    );
  } 
}