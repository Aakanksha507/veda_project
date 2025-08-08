import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myflutterapp/features/widget/text_widget.dart';

class InputFielsWidget extends StatelessWidget {
  final String? labelTxt;
  final String hintTxt;
  final Color? hintStyleColor;
  final Color? borderBoxColor;
  final TextEditingController? controller;
  final bool obscureTextPassword;
  final Widget? suffixIconPassword;
  final TextInputType? keyboardType;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool readOnly;

  const InputFielsWidget({
    super.key,
    this.labelTxt,
    required this.hintTxt,
    required this.focusNode,
    this.hintStyleColor,
    this.borderBoxColor,
    this.controller,
    this.obscureTextPassword = false,
    this.suffixIconPassword,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.errorText,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.w, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelTxt != null && labelTxt!.isNotEmpty) ...[
            TextWidget(
              txt: labelTxt!,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              txtColor: Color(0xFF979797),
            ),
            SizedBox(height: 8.h),
          ] else ...[
            SizedBox(height: 2.h),
          ],
          TextFormField(
            onChanged: onChanged,
            // onChanged: (value) {
            //   if (validator != null) {
            //     final error = validator!(value);
            //     if (error != null) {
            //       errorText = error;
            //     } else {
            //       errorText = null;
            //     }
            //   }
            // },
            readOnly: readOnly,
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            focusNode: focusNode,
            obscureText: obscureTextPassword,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintTxt,
              hintStyle: TextStyle(
                color: hintStyleColor ?? Color(0xFFCACACA),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: focusNode.hasFocus ? Colors.red : Colors.grey,
                  width: 1,
                ),
              ),

              suffixIcon: suffixIconPassword,
              errorText: errorText,
              errorStyle: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
