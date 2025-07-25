import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InternationalPhoneNumberInputfield extends StatelessWidget{

   final TextEditingController controller;
   final String intialCountryCode;
   final String? Function(String?)? validator;
   final String? errorText;
   final void Function(bool)? onInputValidated;

  const InternationalPhoneNumberInputfield({
    super.key,
    required this.controller,
    this.validator,
    this.intialCountryCode = 'NP',
     this.errorText, this.onInputValidated,
    });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.w, left: 16.w, right: 16.w),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number){
          return ;
        },
        onInputValidated: onInputValidated,
        textFieldController: controller,
        
        initialValue: PhoneNumber(isoCode: intialCountryCode),
        keyboardType: TextInputType.phone,
        autoFocus: true,
        spaceBetweenSelectorAndTextField: 5,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
           setSelectorButtonAsPrefixIcon: true,
          //  useEmoji: true, 
           showFlags: false,
        ),
        
        autoValidateMode: AutovalidateMode.onUserInteraction,
        inputDecoration: InputDecoration(
          hintText: "Phone Number",
          errorStyle: GoogleFonts.poppins(
                    fontSize: 10.sp, fontWeight: FontWeight.w400
                  ),
          errorText: errorText,
          hintStyle:  GoogleFonts.poppins( color: Color(0xFFCACACA),
                     fontWeight: FontWeight.w500,
                      fontSize: 14.sp
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: Color(0xFF979797),
               width: 1,
            )
          )
          
        ),
        
        validator: validator,
      
        
        
      
      ),
    );
  }
}
