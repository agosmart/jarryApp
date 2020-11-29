import 'package:flutter/material.dart';
import 'package:jarryApp/themes/colors.dart';

// import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final bool uppercase;
  final TextAlign textAlign;
  //-----------
  const TitleText({
    Key key,
    @required this.text,
    this.fontSize = 18,
    this.color = AppColors.titleTextColor,
    this.fontWeight = FontWeight.w800,
    this.letterSpacing = 0.0,
    this.uppercase = false,
    this.textAlign = TextAlign.left,
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
      textAlign: textAlign,
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

//++++++++++++++++++++++++++++++++++++++++++++++++++
class BodyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final bool uppercase;
  final TextAlign textAlign;
  //-----------

  const BodyText({
    Key key,
    @required this.text,
    this.fontSize = 16,
    this.color = AppColors.bodyText,
    this.fontWeight = FontWeight.w400,
    this.letterSpacing = 0.0,
    this.uppercase = false,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

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

        textAlign: textAlign,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
          height: 1.6,
        ));
  }
}
