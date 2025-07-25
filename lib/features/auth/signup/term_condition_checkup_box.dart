import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';

class TermConditionCheckupBox extends StatefulWidget{
  const TermConditionCheckupBox({super.key});

  @override
  State<StatefulWidget> createState() => TermConditionCheckupBoxWidget();
}

class TermConditionCheckupBoxWidget extends State<TermConditionCheckupBox>{

   bool isChecked = false;
 

  @override
  Widget build(BuildContext context) {

    return Row(

      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Checkbox(value: isChecked,
         onChanged: (bool? newValue){
          setState(() {
            isChecked = newValue!;
          });
         }
         ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(txt: "By creating an account your aggree",
             fontWeight: FontWeight.w400,
              fontSize: 11.99.sp,
              txtColor: Color(0xff343434),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(txt: "to our", fontWeight: FontWeight.w400, fontSize: 11.99.sp),
                      TextWidget(txt: " Term and Condtions", fontWeight: FontWeight.w600, fontSize: 14.sp, txtColor: Color(0xFF3629B7),), 
                ],
              )
          ],
        )
      ],
    );
  }
  
}