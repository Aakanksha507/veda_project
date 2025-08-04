import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermConditionCheckupBox extends StatefulWidget {
  const TermConditionCheckupBox({super.key});

  @override
  State<StatefulWidget> createState() => TermConditionCheckupBoxWidget();
}

class TermConditionCheckupBoxWidget extends State<TermConditionCheckupBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              isChecked = newValue!;
            });
          },
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              txt: loc.byCreatingAnAccountYourAgree,
              fontWeight: FontWeight.w400,
              fontSize: 11.99.sp,
              txtColor: Color(0xff343434),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  txt:loc.toOur,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.99.sp,
                ),
                TextWidget(
                  txt: loc.termCondtions,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  txtColor: AppColor.primary1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
