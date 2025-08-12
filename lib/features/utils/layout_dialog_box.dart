import 'package:flutter/material.dart';
import 'package:myflutterapp/AppColor/app_color.dart';

class LayoutDialogBox extends StatelessWidget {
  const LayoutDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Image Feature'),
      surfaceTintColor: AppColor.neutral6,
      titlePadding: const EdgeInsets.only(top: 16, left: 24, right: 24), 
      content: const Text('Select Image feature.'), 
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
       
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
