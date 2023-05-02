import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextStyles {
  static TextStyle h1 = GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white);
  static TextStyle h2 = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white);
  static TextStyle nomal = GoogleFonts.roboto(
      fontSize: 14, color: AppColors.white);
}
