import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';

import '../themes/app_text_styles.dart';

class ColorHelper {
  static paymentColor(String payment) {
    if (payment == 'Paypal') {
      return Text(payment, style: AppTextStyles.h2.copyWith(
        color: AppColors.blueMain,
      ),);
    } else if (payment == 'Cash') {
      return Text(payment, style: AppTextStyles.h2.copyWith(
        color: AppColors.primaryColor,
      ),);
    }else{
      return Text(payment, style: AppTextStyles.h2.copyWith(
        color: AppColors.yellow,
      ),);
    }
  }

  static statusColor(String status) {
    if (status == 'Canceled') {
      return Text(status, style: AppTextStyles.nomal.copyWith(
        color: AppColors.red,
      ));
    } else if (status == 'Pending') {
      return Text(status, style: AppTextStyles.nomal.copyWith(
        color: AppColors.yellow,
      ));
    } else if (status == 'Paid') {
      return Text(status, style: AppTextStyles.nomal.copyWith(
        color: AppColors.blueMain,
      ));
    } else if (status == 'Completed') {
      return Text(status, style: AppTextStyles.nomal.copyWith(
        color: AppColors.green,
      ));
    }else{
      return Text(status, style: AppTextStyles.nomal.copyWith(
        color: AppColors.yellow,
      ));
    }
  }
}