import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:get/get.dart';

import '../../config/helper/image_helper.dart';
import '../../controllers/cart_controller.dart';
import '../auth/home_screen.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({Key? key}) : super(key: key);
  static String routerName = '/cart_screen';
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shopping Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
          child: cartController.user?.uid == null
              ? Column(
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
                              width: isDesktop
                                  ? context.width * 0.1
                                  : context.width * 0.4,
                              child: Image.asset(
                                ImageHelper.imgError,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'You are not logged into your account !',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondGray),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Discover dishes and add them to cart to display them here.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondGray),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: isDesktop?context.width*0.3:double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    backgroundColor: AppColors.primaryColor,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Get.toNamed(HomeScreen.routerName);
                                  },
                                  child: Text(
                                    'Get Started Now',
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Obx(() {
                  if (cartController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else {
                    if (cartController.cartItems.isEmpty) {
                      return Center(
                        child: Text('Giỏ hàng của bạn trống'),
                      );
                    } else {
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(),
                          ),
                        ],
                      );
                    }
                  }
                })),
    );
  }
}
