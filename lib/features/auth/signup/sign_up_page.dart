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

  @override
  Widget build(BuildContext context) {
    return BackgroundLayoutWidget(
      appbarTittle: "Sign Up",
      titleText: "Welcome to us,",
      secondaryText: "Hello there, create New account",
      promptText: "Have an account?",
      actionText: "Sign In",
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
                  validator: InputValidation.validateUserName,
                  errorText: usernameError,
                  hintTxt: 'User Name',
                  hintStyleColor: const Color(0xFFCACACA),
                  borderBoxColor: const Color(0xFFCBCBCB),
                ),
                //Input Field For PhoneNumber
                InternationalPhoneNumberInputfield(
                  controller: phoneNumberController,

                  validator: InputValidation.validatePhoneNumber,
                  errorText: phoneError,
                ),
                //Input Field For Password
                InputFielsWidget(
                  controller: passwordController,
                  focusNode: passwordnode,
                  validator: InputValidation.validatePassword,
                  errorText: passwordError,
                  obscureTextPassword: obscurePassword,
                  hintTxt: 'Password',
                  hintStyleColor: const Color(0xFFCACACA),
                  borderBoxColor: const Color(0xFFCBCBCB),
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
                          InputValidation.validateUserName(username);
                      final phoneErrorText =
                          InputValidation.validatePhoneNumber(phoneNumber);
                      final passwordErrorText =
                          InputValidation.validatePassword(password);

                      setState(() {
                        phoneError = phoneErrorText;
                        passwordError = passwordErrorText;
                        usernameError = usernameErrorText;
                      });
                      User newUser = User(
                        username: username,
                        phoneNumber: phoneNumber,
                        password: password,
                      );

                      await prefService.setData(newUser);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User Register Succesfully")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    }
                  },
                  btnText: "SignUp",
                  bgColorBtn: const Color(0xFF3629B7),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      txt: "Have an account? ",
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
                        txt: "Sign In ",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        txtColor: const Color(0xFF3629B7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
