import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myflutterapp/features/button_widgets/cutom_toggle_switch_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/setting/language_widget.dart';
import 'package:myflutterapp/features/homepage/screens/setting/password.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<String> item = [
      loc.password,
      loc.touchId,
      loc.languages,
      loc.appInformation,
      'Theme',
      loc.customerCare,
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          mainTxt: loc.setting,
          bgColor: Theme.of(context).appBarTheme.backgroundColor,
          txtColor: AppColor.neutral6,
          iconColor: AppColor.neutral6,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Stack(
        children: [
          Container(color: Theme.of(context).primaryColor),
          Container(
            margin: EdgeInsets.only(top: 67.h),
            decoration: BoxDecoration(
              color: AppColor.neutral6,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          ProfileUserImgWidget(imgHeight: 100.h, imgWidth: 100.w),
          Positioned(
            top: 127.h,
            left: 145.w,
            child: ProfileUsernameWidget(username: loc.user),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 166.h, horizontal: 24.w),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final items = item[index];

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.w, color: Colors.black12),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: AppColor.neutral5,
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Password()),
                            );
                            break;
                          case 1:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Coming Soon"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            break;
                          case 2:
                            showDialog(
                              context: context,
                              builder: (_) => const LanguageDialog(),
                            );
                            break;

                          case 3:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Coming Soon"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            break;
                          case 4:
                            CutomToggleSwitchWidget();
                            break;
                          case 5:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Coming Soon"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            break;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              items,
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            items == "Theme"
                                ? CutomToggleSwitchWidget(
                                  lightbtn: Colors.black12,
                                  darkbtn: AppColor.semantic3,
                                )
                                : items == loc.customerCare
                                ? Text(
                                  '1233434',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                                : Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                  color: Colors.black12,
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: item.length,
            ),
          ),
        ],
      ),
    );
  }
}
