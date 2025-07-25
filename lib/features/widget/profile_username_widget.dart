import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';

class ProfileUsernameWidget extends StatelessWidget{

  final String username;
  
  const ProfileUsernameWidget({
    super.key, 
    required this.username
    });

  @override
  Widget build(BuildContext context) {
    return TextWidget(txt: username,
     fontWeight:FontWeight.w600 ,
      fontSize: 16.sp,
       txtColor: Color(0xFF3629B7)
       );
  }
}