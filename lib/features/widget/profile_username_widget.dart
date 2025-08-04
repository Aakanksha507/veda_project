import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
class ProfileUsernameWidget extends StatelessWidget{

  final String username;
  final Color? txtColor;
  final FontWeight? txtFontWeight;
  
  const ProfileUsernameWidget({
    super.key, 
    required this.username, 
    this.txtColor, 
    this.txtFontWeight
    });

  @override
  Widget build(BuildContext context) {
    return TextWidget(txt: username,
    overflow: TextOverflow.ellipsis,
     fontWeight:txtFontWeight?? FontWeight.w600 ,
      fontSize: 16.sp,
       txtColor:txtColor?? Theme.of(context).colorScheme.primary
       );
  }
}