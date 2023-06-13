import 'package:flutter/material.dart';

class AppColors{
  static final black = Color(0xF000000);
  static final bgWhite = Color(0xFFFFFFFF);
  static final white = Color(0xFFFFFFFF);
  static final lightBlue = Color(0x4D3498DB);
  static final blueMain = Color(0xFF3D58F8);
  static final lightPurple= Color(0x4D9B59B6);
  static final primaryColor = Color(0xFF13AA80);
  static final secondColor = Color(0xFF2FCDA8);
  static final grayMain = Color(0xFFECF0F1);
  static final gray = Color(0xFFDBD8DD);
  static final secondGray = Color(0x80000000);
  static final lightBlack = Color(0xFF34495E);
  static final blueDarkColor = Color(0xff252B5C);
  static final yellow = Color(0xFFFFC107);
  static final red = Color(0xFFFF0707);
  static final green = Color(0xFF4BB543);
  static final error = Color(0xFFFF3737);
  static final darkBlue = Color(0xFF0039FF);
  static final darkGreen = Color(0xFF00B211);
  static final darkPink = Color(0xFFCC0056);
  static final darkPurple = Color.fromRGBO(165, 80, 179, 1);
  static final darkTealBlue = Color(0xFF008CCC);
}
class AppGradient{
  static Gradient dfGradientBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColor
    ]
  );
}