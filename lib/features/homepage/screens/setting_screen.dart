import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget{
   const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
      final List<String> item = [
    loc.password,
    loc.touchId,
    loc.languages,
    loc.appInformation,
    loc.customerCare,
  ];
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: AppBarWidget(mainTxt:loc.setting,
         bgColor: Theme.of(context).appBarTheme.backgroundColor,
          txtColor:  AppColor.neutral6,
           iconColor:  AppColor.neutral6,
           ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
    
      body: Stack(
        children: [
          Container(
            color: AppColor.primary1,
          ),
          Container(
            margin: EdgeInsets.only(top: 67.h),
            decoration: BoxDecoration(
              color: AppColor.neutral6,
              borderRadius: BorderRadius.only(
                topLeft:Radius.circular(30.r), 
                topRight: Radius.circular(30.r)
                ),   
              boxShadow:[BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 0
              )],
            ),
          ),
          ProfileUserImgWidget( imgHeight: 100.h, imgWidth: 100.w,),
          Positioned(
            top: 127.h,
            left: 145.w,
            // right: 131.w,
            child: ProfileUsernameWidget(username: loc.user,),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 166.h, horizontal:24.w,),
          child: ListView.separated(
            itemBuilder: (context, index){
              final items = item[index];
              return  Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.w, color: Colors.black12
                    )
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items, 
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight:FontWeight.w500 , color: Colors.black               
                         ),
                       ),
          
                       items == loc.customerCare
                        ? const Text('1233434')
                        : const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: Colors.black12)
       
                  ],  
                ),
          
              );
          
          },
          separatorBuilder: (context, index)=> SizedBox(),
          itemCount: item.length
          ),
        )],
      ),
    );
  }
}

