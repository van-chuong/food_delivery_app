import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:get/get.dart';

import '../config/helper/image_helper.dart';
import '../config/themes/app_colors.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({
    super.key,
    required this.isDesktop,
  });

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? context.width * 0.2 : 30),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: isDesktop ? context.width * 0.1 : context.width *
                      0.4,
                  child: Image.asset(ImageHelper.imgError,),
                ),
                const SizedBox(height: 16),
                Text(
                  'ERROR 404 PAGE NOT FOUND!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondGray
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Something went wrong please try again later.',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondGray
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: isDesktop?context.width*0.3:double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                        ),
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Get.toNamed(MainScreen.routerName);
                      },
                      child: Text(
                        'Return HomePage',
                      )
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}