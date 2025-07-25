import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return BackgroundLayoutWidget(
      appbarTittle: "SignIn",
      titleText: "Welcome Back",
      secondaryText: "Hello there, sign in to continue",
      //  btnText: "SignIn",
      promptText: "Don't have an account? ",
      actionText: "Sign Up ",
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
                  validator: InputValidation.validatePhoneNumber,
                  errorText: phoneError,
                  onInputValidated: (bool isValid) { 
                      setState(() {
                        phoneError = isValid ? null : phoneError;
                      });
                    },
                ),
                //Input Field For Password
                InputFielsWidget(
                  hintTxt: 'Password',
                  focusNode: passwordnode,
                  controller: passwordController,
                  validator: InputValidation.validatePassword,
                  errorText: passwordError,
                  obscureTextPassword: obscurePassword,
                  hintStyleColor: Color(0xFFCACACA),
                  borderBoxColor: Color(0xFFCBCBCB),
                 onChanged: (value) {
                    setState(() {
                      passwordError = InputValidation.validatePassword(value);
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
                      txt: "Forget your Password",
                      fontWeight: FontWeight.w500,
                      txtColor: Color(0xffCACACA),
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomButtonWidget(
                  btnText: "SignIn",
                  isEnabled: true,
                  bgColorBtn: Color(0xFF3629B7),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final phoneNumber = phoneNumberController.text.trim();
                      final password = passwordController.text.trim();

                      final phoneErrorText = InputValidation.validatePhoneNumber(phoneNumber);
                      final passwordErrorText = InputValidation.validatePassword(password);

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
                              content: Text("Invalid Phone Number or Password"),
                            ),
                          );
                        setState(() {
                          phoneError = "Please Enter Valid Phone Number.";
                        });
                        
                      }
                      debugPrint("matchUser.password  ${matchUser?.password} == $password ");
                      if (matchUser != null &&
                          matchUser.password != password  ) {
                             debugPrint("matchUser.password  ${matchUser?.password} == $password ");
                        setState(() {
                       phoneError = null;
                          passwordError = "Please Enter Valid Password.";
                        });
                        
                      }
                    
                      if (matchUser == null ||
                          matchUser.phoneNumber != phoneNumber ||
                          matchUser.password != password ) {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid Phone Number or Password"),
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
                        txt: "Don't have an account? ",
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
                          txt: "Sign Up ",
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          txtColor: Color(0xFF3629B7),
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
