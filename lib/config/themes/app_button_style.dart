import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
class AppButtonStyle{
  static ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 20),
      minimumSize: Size(354, 50),
      primary: AppColors.primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))
      )
  );
  static ButtonStyle buttonSecond= ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 20),
      minimumSize: Size(354, 50),
      primary: AppColors.grayMain,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))
      )
  );
  static ButtonStyle iConButtonCircle= ElevatedButton.styleFrom(
      padding: EdgeInsets.all(0),
      minimumSize: Size(40, 40),
      primary: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))
      )
  );
  static ButtonStyle textButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
      foregroundColor: MaterialStateProperty.all(AppColors.secondColor),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      )));
}