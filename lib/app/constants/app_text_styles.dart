import 'package:flutter/material.dart';

import 'app_fonts.dart';

abstract class AppTextStyles {
  AppTextStyles._();
  static TextStyle customText({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double fontSize = 12,
    double? height,
  }) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: AppFonts.poetsenOne);
  }

  static TextStyle headingStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 0,
    double fontSize = 24,
    double? height,
  }) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: AppFonts.poetsenOne);
  }

  static TextStyle customTextbold12() {
    return TextStyle(
        color: Colors.white,
        fontFamily: AppFonts.poetsenOne,
        fontSize: 16,
        fontWeight: FontWeight.bold);
  }

  static TextStyle customTextboldd12() {
    return TextStyle(
        color: Colors.white,
        fontFamily: AppFonts.poetsenOne,
        fontSize: 12,
        fontWeight: FontWeight.bold);
  }

  static TextStyle customText12() {
    return TextStyle(
      color: Colors.grey.withOpacity(0.7),
      fontFamily: AppFonts.poetsenOne,
      fontSize: 12,
      // fontWeight: FontWeight.bold
    );
  }

  static TextStyle customText12white() {
    return TextStyle(
      color: Colors.white,
      fontFamily: AppFonts.poetsenOne,
      fontSize: 12,
      // fontWeight: FontWeight.bold
    );
  }

  static TextStyle customTextbold14() {
    return TextStyle(
        color: Colors.white,
        fontFamily: AppFonts.poetsenOne,
        fontSize: 14,
        fontWeight: FontWeight.bold);
  }

  static TextStyle customText14() {
    return TextStyle(
      color: Colors.white,
      fontFamily: AppFonts.poetsenOne,
      fontSize: 14,
    );
  }

  static TextStyle customTextbold16() {
    return TextStyle(
        color: Colors.white,
        fontFamily: AppFonts.poetsenOne,
        fontSize: 16,
        fontWeight: FontWeight.bold);
  }

  static TextStyle customText16() {
    return TextStyle(
      color: Colors.white,
      fontFamily: AppFonts.poetsenOne,
      fontSize: 16,
    );
  }
}
