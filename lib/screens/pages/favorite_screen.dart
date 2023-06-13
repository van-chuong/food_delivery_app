import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/controllers/favorite_controller.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../config/helper/image_helper.dart';
import '../../config/themes/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../services/firebase_service.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  static String routerName = '/favorite_screen';

  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    final cartController = Get.put(CartController());
    final favoriteController = Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Obx(
            () {
              if (favoriteController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else {
                if (favoriteController.favoriteProducts.isNotEmpty) {
                  return GridView.builder(
                    itemCount: favoriteController.favoriteProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 4 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: isDesktop ? 0.9 : 0.6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductDetailScreen(
                          //       product: favoriteController.favoriteProducts[index],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(favoriteController
                                              .favoriteProducts[index]
                                              .images[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favoriteController
                                                .favoriteProducts[index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '\$${favoriteController.favoriteProducts[index].price.toString()}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: favoriteController
                                                    .favoriteProducts[index]
                                                    .rating,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: AppColors.primaryColor,
                                                ),
                                                itemCount: 5,
                                                itemSize: 14.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (cartController.user?.uid != null) {
                                                  if (await cartController.addToCart(favoriteController.favoriteProducts[index])) {
                                                    showTopSnackBar(
                                                      Overlay.of(context),
                                                      displayDuration: Duration(milliseconds: 100),
                                                      const CustomSnackBar
                                                          .success(
                                                        message:
                                                            "The product has been added to cart",
                                                      ),
                                                    );
                                                  } else {
                                                    showTopSnackBar(
                                                      Overlay.of(context),
                                                      displayDuration: Duration(
                                                          milliseconds: 100),
                                                      const CustomSnackBar
                                                          .error(
                                                        message:
                                                            "An error occurred, please try again later",
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                              child: Text(
                                                'Add to cart',
                                                style: TextStyle(
                                                    color: AppColors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Obx(() => IconButton(
                                        icon: Icon(
                                          favoriteController.isFavorite(
                                                  favoriteController
                                                      .favoriteProducts[index]
                                                      .id)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          if (FirebaseAuth
                                                  .instance.currentUser !=
                                              null) {
                                            if (favoriteController.isFavorite(
                                                favoriteController
                                                    .favoriteProducts[index]
                                                    .id)) {
                                              favoriteController.removeFavorite(
                                                  favoriteController
                                                      .favoriteProducts[index]
                                                      .id);
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                displayDuration:
                                                    Duration(milliseconds: 100),
                                                CustomSnackBar.error(
                                                  message:
                                                      "The product has been removed from your favorites",
                                                ),
                                              );
                                            }
                                          } else {
                                            showTopSnackBar(
                                              Overlay.of(context),
                                              displayDuration:
                                                  Duration(milliseconds: 100),
                                              CustomSnackBar.error(
                                                message:
                                                    "You need to be logged in to add your favorite products",
                                              ),
                                            );
                                          }
                                        },
                                      )))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: isDesktop
                                ? context.width * 0.2
                                : context.width * 0.5,
                            child: Image.asset(
                              ImageHelper.imgEmptyBox,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your favorites list is empty !',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondGray),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Explore food dishes and add them to favorites list to show them here.',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondGray),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}
