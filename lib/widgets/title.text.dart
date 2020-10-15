import 'package:flutter/material.dart';
import 'package:jariapp/themes/colors.dart';
// import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final bool uppercase;
  //-----------
  const TitleText({
    Key key,
    @required this.text,
    this.fontSize = 18,
    this.color = AppColors.titleTextColor,
    this.fontWeight = FontWeight.w800,
    this.letterSpacing = 0.0,
    this.uppercase = true,
  }) : super(key: key);

  //+++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return Text(
      //-----------------------
      uppercase ? '${text.toUpperCase()}' : '$text',
      //-----------------------
      /* style: GoogleFonts.muli(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ), */
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}