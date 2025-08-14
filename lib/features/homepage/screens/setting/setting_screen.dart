import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/button_widgets/cutom_toggle_switch_widget.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/homepage/screens/setting/language_widget.dart';
import 'package:myflutterapp/features/homepage/screens/setting/password.dart';
import 'package:myflutterapp/features/utils/custom_snack_bar.dart';
import 'package:myflutterapp/features/widget/profile_user_img_widget.dart';
import 'package:myflutterapp/features/widget/profile_username_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  File? selectedImage;
  SharedPrefService prefService = SharedPrefService();

  get routeObserver => null;

  @override
  void initState() {
    super.initState();
    loadImage();
    // getLostData();
  }

  Future<void> loadImage() async {
    final file = await prefService.loadUserProfileImage();
    if (file != null) {
      setState(() {
        selectedImage = file;
      });
    } else {
      setState(() {
        selectedImage = null;
      });
    }
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? returnedImage = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Feature'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (selectedImage == null) ...[
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text("Camera"),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await picker.pickImage(source: ImageSource.camera),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await picker.pickImage(source: ImageSource.gallery),
                    );
                  },
                ),
              ] else ...[
                ListTile(
                  leading: Icon(Icons.remove_circle_outline),
                  title: Text("Remove"),
                  onTap: () async {
                    await prefService.clearUserProfileImage();
                    Navigator.pop(context, null);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
    if (returnedImage == null) {
      await prefService.clearUserProfileImage();
      setState(() {
        selectedImage = null;
      });
      return;
    }
    final imageFile = File(returnedImage.path);
    await prefService.saveImageToPrefs(imageFile);
    final newImage = await prefService.loadUserProfileImage();
    setState(() {
      selectedImage = imageFile;
    });
  }

  // Future<void> getLostData() async {
  //   final ImagePicker picker = ImagePicker();
  //   final LostDataResponse response = await picker.retrieveLostData();

  //   if (response.isEmpty) return;

  //   final List<XFile>? files = response.files;
  //   if (files != null && files.isNotEmpty) {
  //     final imageFile = File(files.first.path);
  //     await prefService.saveImageToPrefs(imageFile);
  //     setState(() {
  //       selectedImage = imageFile;
  //      });
  //   }else {
  //     debugPrint('Error retrieving lost data: ${response.exception}');
  //   }
  // }

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
          ProfileUserImgWidget(
            imgHeight: 100.h,
            imgWidth: 100.w,
            img:
                selectedImage != null
                    ? FileImage(selectedImage!)
                    : AssetImage("assets/image/img1.png"),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColor.primary3,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    getImage();
                  },
                  child: SvgPicture.asset(
                    'assets/icon/roundedButton.svg',
                    height: 32.h,
                    width: 32.w,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 127.h,
            left: 145.w,
            child: ProfileUsernameWidget(username: loc.user),
          ),
          Positioned(
            top: 166.h,
            left: 24.w,
            right: 24.w,
            bottom: 0,
            // padding: EdgeInsets.symmetric(vertical: 166.h, horizontal: 24.w),
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
                              CustomSnackBar.show(context, loc.comingSoon);
                            break;
                          case 2:
                            showDialog(
                              context: context,
                              builder: (_) => const LanguageDialog(),
                            );
                            break;

                          case 3:
                              CustomSnackBar.show(context, loc.comingSoon);
                            break;
                          case 4:
                            CutomToggleSwitchWidget();
                            break;
                          case 5:
                             CustomSnackBar.show(context, loc.comingSoon);
                            break;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
