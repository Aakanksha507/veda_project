import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/auth/login/International_phone_number_inputfield.dart';
import 'package:myflutterapp/features/auth/login/sign_in_page.dart';
import 'package:myflutterapp/features/auth/sevice/input_validation.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/background_layout_widget.dart';
import 'package:myflutterapp/features/button_widgets/custom_button_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/features/auth/signup/term_condition_checkup_box.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool obscurePassword = true;

  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final usernamenode = FocusNode();
  final phoneNumbernode = FocusNode();
  final passwordnode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  String? phoneError;
  String? passwordError;
  String? usernameError;

  final SharedPrefService prefService = SharedPrefService();
  // final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus(); // way to remove focus from input field
                                                        // dismissed the keyboard
      },
      child: BackgroundLayoutWidget(
        appbarTittle: loc.signup,
        titleText: loc.welcomeToUs,
        secondaryText: loc.helloCreateNewAccount,
        promptText: loc.haveAnAccount,
        actionText: loc.signin,
        dynamicWidget: Padding(
          padding: EdgeInsets.only(top: 301.0.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Input Field For Username
                  InputFielsWidget(
                    controller: usernameController,
                    focusNode: usernamenode,
                    validator:  (value)=> InputValidation.validateUserName(loc, value),
                    errorText: usernameError,
                    hintTxt: loc.userName,
                    hintStyleColor:  AppColor.neutral4,
                    // borderBoxColor: const Color(0xFFCBCBCB),
                  ),
                  //Input Field For PhoneNumber
                  InternationalPhoneNumberInputfield(
                    controller: phoneNumberController,
      
                    validator: (value)=> InputValidation.validatePhoneNumber(loc, value),
                    errorText: phoneError,
                  ),
                  //Input Field For Password
                  InputFielsWidget(
                    controller: passwordController,
                    focusNode: passwordnode,
                    validator:  (value)=> InputValidation.validatePassword(loc, value),
                    errorText: passwordError,
                    obscureTextPassword: obscurePassword,
                    hintTxt: loc.password,
                    hintStyleColor:  AppColor.neutral4,
                    // borderBoxColor: const Color(0xFFCBCBCB),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 24.w,
                    ),
                    child: TermConditionCheckupBox(),
                  ),
                  CustomButtonWidget(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final username = usernameController.text.trim();
                        final phoneNumber = phoneNumberController.text.trim();
                        final password = passwordController.text.trim();
                        final usernameErrorText =
                            InputValidation.validateUserName(loc, username);
                        final phoneErrorText =
                            InputValidation.validatePhoneNumber(loc, phoneNumber);
                        final passwordErrorText =
                            InputValidation.validatePassword(loc, password);
      
                        setState(() {
                          phoneError = phoneErrorText;
                          passwordError = passwordErrorText;
                          usernameError = usernameErrorText;
                        });
                        User newUser = User(
                          // id: uuid.v4(),
                          username: username,
                          phoneNumber: phoneNumber,
                          password: password,
                        );
      
                        await prefService.setData(newUser);
      
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(loc.registration_success_message),
                          duration: Duration(seconds: 1))
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      }
                    },
                    btnText: loc.signup,
                    bgColorBtn: AppColor.primary1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        txt:loc.haveAnAccount,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                        child: TextWidget(
                          txt: loc.signin,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          txtColor: AppColor.primary1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
