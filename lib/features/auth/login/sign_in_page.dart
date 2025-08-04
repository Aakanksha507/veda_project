import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/features/auth/login/International_phone_number_inputfield.dart';
import 'package:myflutterapp/features/auth/sevice/input_validation.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/auth/signup/sign_up_page.dart';
import 'package:myflutterapp/features/homepage/home_screen.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/background_layout_widget.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumbernode = FocusNode();
  final passwordnode = FocusNode();
  bool obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  String? phoneError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BackgroundLayoutWidget(
      appbarTittle: loc.signin,
      titleText: loc.welcomeBack,
      secondaryText: loc.helloSignInToContinue,
      //  btnText: "SignIn",
      promptText:loc.dontHaveAnAccount,
      actionText: loc.signup,
      dynamicWidget: Padding(
        padding: EdgeInsets.only(top: 301.0.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Input Field For PhoneNumber
                InternationalPhoneNumberInputfield(
                  controller: phoneNumberController,
                  validator: (value) => InputValidation.validatePhoneNumber(loc, value),
                  errorText: phoneError,
                  onInputValidated: (bool isValid) { 
                      setState(() {
                        phoneError = isValid ? null : phoneError;
                      });
                    },
                ),
                //Input Field For Password
                InputFielsWidget(
                  hintTxt: loc.password,
                  focusNode: passwordnode,
                  controller: passwordController,
                  validator:  (value)=>  InputValidation.validatePassword(loc, value),
                  errorText: passwordError,
                  obscureTextPassword: obscurePassword,
                  hintStyleColor: AppColor.neutral4,
                  borderBoxColor: Color(0xFFCBCBCB),
                 onChanged: (value) {
                    setState(() {
                      passwordError = InputValidation.validatePassword(loc,value);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextWidget(
                      txt: loc.forgetYourPassword,
                      fontWeight: FontWeight.w500,
                      txtColor: AppColor.neutral4,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomButtonWidget(
                  btnText: loc.signin,
                  isEnabled: true,
                  bgColorBtn: AppColor.primary1,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final phoneNumber = phoneNumberController.text.trim();
                      final password = passwordController.text.trim();

                      final phoneErrorText = InputValidation.validatePhoneNumber(loc, phoneNumber);
                      final passwordErrorText = InputValidation.validatePassword(loc, password);

                      final prefService = SharedPrefService();
                      final users = await prefService.getAllUsers();
                      
                      

                      User? matchUser;
                      try {
                        matchUser = users.firstWhere(
                          (user) =>
                              user.phoneNumber == phoneNumber 
                             
                        );
                      } catch (e) {
                        print("%not found ${e.toString()}");
                        matchUser = null;
                      }

                      setState(() {
                        phoneError = phoneErrorText;
                        passwordError = passwordErrorText;
                      });

                      // debugPrint("Match User Phone: ${phoneError}");

                      if (matchUser == null ||
                          matchUser.phoneNumber != phoneNumber  ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loc.invalid_phone_password_message),
                            ),
                          );
                        setState(() {
                          phoneError = loc.invalid_phone_message;
                        });
                        
                      }
                      debugPrint("matchUser.password  ${matchUser?.password} == $password ");
                      if (matchUser != null &&
                          matchUser.password != password  ) {
                             debugPrint("matchUser.password  ${matchUser.password} == $password ");
                        setState(() {
                       phoneError = null;
                          passwordError = loc.invalid_password_message;
                        });
                        
                      }
                    
                      if (matchUser == null ||
                          matchUser.phoneNumber != phoneNumber ||
                          matchUser.password != password ) {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loc.invalid_phone_password_message),
                            ),
                          );
                        });
                      }

                      if (matchUser != null && matchUser.password == password ) {
                        await prefService.setUserPhoneNumber(phoneNumber);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                        
                      }
                      
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 112.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        txt: loc.dontHaveAnAccount,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: TextWidget(
                          txt: loc.signup,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          txtColor: AppColor.primary1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
