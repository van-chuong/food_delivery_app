import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/responsive_helper.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:food_delivery_app/models/CartItemModel.dart';
import 'package:food_delivery_app/screens/cart/confirm_order_screen.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/screens/pages/home_view_screen.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/helper/image_helper.dart';
import '../../config/themes/app_text_styles.dart';
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
                              width: isDesktop
                                  ? context.width * 0.3
                                  : double.infinity,
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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: isDesktop?context.width*0.2:30),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: isDesktop?context.width*0.1:context.width*0.4,
                                    child: Image.asset(ImageHelper.imgEmptyBox,),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Shopping Cart Is Empty!',
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
                                      'Discover dishes and add them to cart to display them here.',
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
                                        child:Text(
                                          'Discover Now',
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      );
                    } else {
                      return Stack(
                        children: [
                          OverflowBox(
                            alignment: Alignment.topCenter,
                            maxHeight: double.infinity,
                            child: Container(
                              height: context.height - 220, // 100 is the height of bottom container
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isDesktop?200:30),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cartController.cartItems.length,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20,
                                      childAspectRatio:
                                      ResponsiveHelper.styleMediaDouble(
                                          2.5, 5, 6, context),
                                    ),
                                    itemBuilder: (context, index) {
                                      CartItemModel cartItem =
                                      cartController.cartItems[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          // color: AppColors.lightPurple,
                                            borderRadius:
                                            BorderRadius.circular(24)),
                                        child: Stack(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: double.infinity,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                        child: Image.network(
                                                          cartItem.image,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      height: double.infinity,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .fromLTRB(
                                                            10, 10, 10, 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              cartItem.name,
                                                              style: AppTextStyles
                                                                  .h2
                                                                  .copyWith(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 1,
                                                            ),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              cartItem.description,
                                                              style: AppTextStyles
                                                                  .nomal
                                                                  .copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 2,
                                                            ),
                                                            SizedBox(height: 5),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  highlightColor:
                                                                  AppColors
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      24),
                                                                  child: Icon(
                                                                      Icons.remove,
                                                                      size: ResponsiveHelper
                                                                          .styleMediaDouble(
                                                                          26,
                                                                          26,
                                                                          40,
                                                                          context),
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                  onTap: () {
                                                                    if (!cartController
                                                                        .decrementQuantity(
                                                                        cartItem
                                                                            .id)) {
                                                                      showTopSnackBar(
                                                                        Overlay.of(context),
                                                                        displayDuration: Duration(
                                                                            milliseconds:
                                                                            100),
                                                                        const CustomSnackBar
                                                                            .error(
                                                                          message:
                                                                          "An error occurred, please try again later",
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0),
                                                                  child: Text(
                                                                    cartItem
                                                                        .quantity
                                                                        .toString(),
                                                                    style: AppTextStyles
                                                                        .nomal
                                                                        .copyWith(
                                                                        fontSize:
                                                                        14,
                                                                        color: Colors
                                                                            .black),
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      24),
                                                                  highlightColor:
                                                                  AppColors
                                                                      .primaryColor,
                                                                  child: Icon(
                                                                      Icons.add,
                                                                      size: ResponsiveHelper
                                                                          .styleMediaDouble(
                                                                          26,
                                                                          26,
                                                                          40,
                                                                          context),
                                                                      color: AppColors
                                                                          .primaryColor),
                                                                  onTap: () {
                                                                    if (!cartController
                                                                        .incrementQuantity(
                                                                        cartItem
                                                                            .id)) {
                                                                      showTopSnackBar(
                                                                        Overlay.of(
                                                                            context),
                                                                        displayDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                            100),
                                                                        const CustomSnackBar
                                                                            .error(
                                                                          message:
                                                                          "An error occurred, please try again later",
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                                Center(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                        20.0),
                                                                    child: Text(
                                                                      '\$' +
                                                                          cartItem
                                                                              .price
                                                                              .toString(),
                                                                      style: AppTextStyles
                                                                          .h2
                                                                          .copyWith(
                                                                          fontSize:
                                                                          20,
                                                                          color:
                                                                          AppColors.red),
                                                                      maxLines: 1,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: InkWell(
                                                  highlightColor: AppColors.red,
                                                  borderRadius:
                                                  BorderRadius.circular(24),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: 'Remove Item',
                                                      middleText:
                                                      'Are you sure want to remove item ?',
                                                      textConfirm: 'Ok',
                                                      onConfirm: () async {
                                                        Get.back();
                                                        if (!await cartController
                                                            .removeCartItem(
                                                            cartItem.id)) {
                                                          showTopSnackBar(
                                                            Overlay.of(context),
                                                            displayDuration:
                                                            Duration(
                                                                milliseconds:
                                                                100),
                                                            const CustomSnackBar
                                                                .error(
                                                              message:
                                                              "An error occurred, please try again later",
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      textCancel: 'No',
                                                      onCancel: () {
                                                        Get.back();
                                                      },
                                                    );
                                                  },
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: context.width,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(isDesktop?200:30,10,isDesktop?200:30,10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Shipping Fee: ',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text('Free',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.red
                                            )
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Total To Pay: ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('\$'+cartController.totalPrice.value.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              color: AppColors.red
                                            )
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed(ConfirmOrderScreen.routerName, arguments: {
                                                'totalPrice': cartController.totalPrice.value,
                                                'cartItems': cartController.cartItems,
                                              }
                                              );
                                            },
                                            child: Text(
                                              'Place Order',
                                              style: AppTextStyles.h1.copyWith(fontSize: 20),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(24)
                                              ),
                                              backgroundColor: AppColors.primaryColor,
                                              elevation: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
                })),
    );
  }
}
