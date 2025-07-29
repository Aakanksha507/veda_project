import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextWidget extends StatelessWidget{
  final String txt;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? txtColor;
  final double? letterSpacing;
  final double? lineheight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;


  const TextWidget({
    super.key, 
    required this.txt,
    required this.fontWeight,
    required this.fontSize,
    this.txtColor,
    this.letterSpacing,
    this.lineheight,
    this.overflow,  
    this.textAlign,

    });
  
  @override
  Widget build(BuildContext context) {
  return Text(
    txt,
    textAlign: textAlign,
     style: GoogleFonts.poppins(
      fontSize: fontSize, 
      fontWeight: fontWeight, 
      color: txtColor?? Colors.black, 
      letterSpacing: letterSpacing ?? 0,
      height: lineheight,
      
    ),
    overflow: overflow ?? TextOverflow.visible,
   
  );
} 
}



