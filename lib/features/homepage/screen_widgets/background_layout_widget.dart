import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myflutterapp/screen/sign_up_page.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
// import 'package:myflutterapp/widget/custom_button_widget.dart';
// import 'package:myflutterapp/widget/input_fiels_widget.dart';
import 'package:myflutterapp/features/widget/text_img_designlayout_widget.dart';
// import 'package:myflutterapp/widget/text_widget.dart';

class BackgroundLayoutWidget extends StatelessWidget{

  final String appbarTittle;
  final String titleText;
  final String secondaryText;
  final Widget dynamicWidget;
  // final String btnText;
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
        // required this.btnText,
          required this.promptText,
          required this.actionText,
     });

  @override
  Widget build(BuildContext context) {
       return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppBarWidget(mainTxt:appbarTittle ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints){
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.minHeight
                ),
                child: Column(
            children: [
              Stack(
                children: [
                  Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  
                  child: Container(
                    margin: whiteContainerHeight?? EdgeInsets.only(top: 15.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
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
            
                ]
              ),
          
            ],
          ),
              ),
            );
          },
          
        )

        
        
       );
  }
}