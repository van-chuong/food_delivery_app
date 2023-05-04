import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showLoading([String? mess]) {
    Get.dialog(Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(mess ?? '')
          ],
        ),
      ),
    ));
  }

  static void hideLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }

  static void alertDialog(String mess) {
    Get.defaultDialog(
        title: 'Status',
        middleText: mess,
        textConfirm: 'Ok',
        onConfirm: (){
          Get.back();
        }
    );
  }
}
