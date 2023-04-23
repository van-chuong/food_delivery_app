import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/orientation.dart';

class AppTextStyles {
  static TextStyle h1 = GoogleFonts.poppins(
      fontSize: OrientationHelper.styleMediaDouble(24, 28, 32) , fontWeight: FontWeight.bold, color: AppColors.white);
  static TextStyle h2 = GoogleFonts.poppins(
      fontSize: OrientationHelper.styleMediaDouble(18, 20, 26), fontWeight: FontWeight.bold, color: AppColors.white);
  static TextStyle nomal = GoogleFonts.roboto(
      fontSize: OrientationHelper.styleMediaDouble(16, 18, 20), fontWeight: FontWeight.normal, color: AppColors.white);
}
