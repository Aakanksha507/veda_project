import 'package:flutter/material.dart';
class CustomSnackBar {
  static void show(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.removeCurrentSnackBar(); 

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
