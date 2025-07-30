import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/widget/text_img_designlayout_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class BackgroundLayoutWidget extends StatelessWidget{

  final String appbarTittle;
  final String titleText;
  final String secondaryText;
  final Widget dynamicWidget;
  final String promptText;
  final String actionText;
  final EdgeInsetsGeometry? whiteContainerHeight;
  
  const BackgroundLayoutWidget({
    super.key,
     required this.appbarTittle,
      this.whiteContainerHeight, 
        required this.titleText, 
        required this.secondaryText,
        required this.dynamicWidget,
          required this.promptText,
          required this.actionText,
     });

  @override
  Widget build(BuildContext context) {
       return Scaffold(
        appBar: AppBar(
          
          title: AppBarWidget(mainTxt:appbarTittle ),
          backgroundColor: AppColor.primary1,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                decoration: BoxDecoration(
                  color: Color(0xff3629B7)
                ),
                
                child: Container(
                  margin: whiteContainerHeight?? EdgeInsets.only(top: 15.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only( topLeft: Radius.circular(30.r),
                     topRight: Radius.circular(30.r)),
                  ),
                
                ),
                  
              ),
              Padding(
                padding: EdgeInsets.all(24.h),
                child: TextImgDesignlayoutWidget(
                  titleText: titleText, secondaryText:secondaryText,
                   ),
              ),
              // img: Image.asset("assets/image/Illustration_2.png")
              dynamicWidget, 
            
            
            
            
            
              // CustomButtonWidget(btnText: btnText, bgColorBtn: Color(0xFFF2F1F9),),
              // SizedBox(height: 112.h,),

              ]
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 112.0),
            //   child: Row(
            //    mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       TextWidget(txt: promptText,
            //        fontWeight: FontWeight.w400,
            //         fontSize: 12.sp),
                   
            //        TextButton(
            //          onPressed: (){
            //            Navigator.push(
            //        context,
            //        MaterialPageRoute(builder: (context) => const SignUpPage()),
            //      );
            //          },
            //          child: TextWidget(txt: actionText,
            //            fontWeight: FontWeight.w600,
            //            fontSize: 12.sp,
            //              txtColor: AppColor.primary1,
            //              ),
            //        ),
            //     ],
            //   ),
            // ),

          ],
        )

        
        
       );
  }
}