import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/helper/image_helper.dart';
import '../../config/themes/app_colors.dart';
import '../main_screen.dart';

class CheckOutStatus extends StatelessWidget {
  CheckOutStatus({ this.status});
  final bool? status;
  static String routerName = '/checkout_status';
  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    return Scaffold(
      body: status!=null && status!
          ?Column(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                            child: Image.asset(ImageHelper.gifOrderSuccess,)
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'ORDER SUCCESSFULLY!',
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
                          'You can track your order status in the order section.',
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
                        width: isDesktop ? context.width * 0.3 : double.infinity,
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
                              'Go To HomePage',
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        :Column(
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
                  width: isDesktop ? context.width * 0.3 : double.infinity,
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
    )
    ,
    );
  }
}
