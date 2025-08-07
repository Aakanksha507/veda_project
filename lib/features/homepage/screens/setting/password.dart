import 'package:flutter/material.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/features/widget/text_field_widget/input_fiels_widget.dart';
import 'package:myflutterapp/models/user_model.dart'; 

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final passwordNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final SharedPrefService prefService = SharedPrefService();

  User? currentUser;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    User? user = await prefService.getCurrentUser();
    if (user != null) {
      setState(() {
        currentUser = user;
        passwordController.text = user.password ?? '';
      });
    }
  }

  @override
  void dispose() {
    passwordNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarWidget(mainTxt: 'Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputFielsWidget(
              hintTxt: "Password",
              labelTxt: "Password",
              focusNode: passwordNode,
              obscureTextPassword: false,
              controller: passwordController,
              readOnly: true,
            
            ),
            
          ],
        ),
      ),
    );
  }
}
