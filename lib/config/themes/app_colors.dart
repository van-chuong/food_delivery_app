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