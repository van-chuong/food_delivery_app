import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:food_delivery_app/screens/product/products_screen.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:searchfield/searchfield.dart';

import '../../config/themes/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../controllers/home_view_controller.dart';
import '../../models/Productmodel.dart';
import '../cart/cart_screen.dart';
import '../product/product_detail.dart';

class HomeViewScreen extends GetView<HomeViewController> {
  HomeViewScreen({Key? key}) : super(key: key);
  static String routerName = '/home_view_screen';
  final homeViewController = Get.put(HomeViewController());
  final favoriteController = Get.put(FavoriteController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    var isDesktop = context.width > 1000;
    final focusNode = FocusNode();
    var _searchKeyController = TextEditingController();
    focusNode.addListener(() {
      homeViewController.isVisible.toggle();
    });
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: isDesktop ? 10 : 6,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                            height: 40,
                            child: SearchField(
                              searchInputDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  prefixIcon: Icon(Icons.search_outlined),
                                  filled: true,
                                  fillColor: AppColors.grayMain,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blueDarkColor
                                          .withOpacity(0.5))),
                              suggestionsDecoration: SuggestionDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColors.white),
                              maxSuggestionsInViewPort: 3,
                              suggestions: homeViewController.allProducts.value
                                  .map(
                                    (e) => SearchFieldListItem<ProductModel>(
                                        e.name,
                                        item: e,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(e.name),
                                        )),
                                  )
                                  .toList(),
                              focusNode: focus,
                              suggestionState: Suggestion.expand,
                              onSuggestionTap:
                                  (SearchFieldListItem<ProductModel> x) {
                                focus.unfocus();
                                Get.toNamed(ProductDetail.routerName,
                                    arguments: {'productId': x.item?.id});
                              },
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              // Navigate to shopping cart screen
                              Get.toNamed(CartScreen.routerName);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                                Obx(() {
                                  if (cartController.cartItems.length > 0) {
                                    return Positioned(
                                      top: -4,
                                      right: -4,
                                      child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 16,
                                            minHeight: 16,
                                          ),
                                          child: Obx(
                                            () => Text(
                                              cartController.cartItems.length
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: isDesktop ? 18 : 14,
                      ),
                      Text(
                        ' 15 Tran Dai Nghia, Ngu Hanh Son, Da Nang',
                        style: AppTextStyles.nomal.copyWith(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontSize: isDesktop ? 18 : 14,
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Container(
                  width: context.width - 60,
                  height: isDesktop ? 300 : 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(24)),
                  child: Obx((){
                    if(homeViewController.isLoading.value){
                      return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
                    }else{
                      return CarouselSlider(
                          items: homeViewController.banners.value
                              .map((item) => Container(
                            child: Center(
                              child: ClipRRect(
                                // Sử dụng ClipRRect để cắt bớt phần tràn ra
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(
                                  item.photoUrl,
                                  fit: BoxFit.cover,
                                  width: context.width - 60,
                                ),
                              ),
                            ),
                          ))
                              .toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2,
                              enlargeCenterPage: true));
                    }
                  })
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Food Category',
                          style: AppTextStyles.h1.copyWith(color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30, 0, 0),
                child: SizedBox(
                    height: isDesktop ? 160 : 100,
                    child: Obx(() => ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: homeViewController.categories.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: isDesktop ? 40 : 30,
                          );
                        },
                        itemBuilder: (context, index) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  homeViewController.selectedItem.value =
                                      homeViewController.categories[index].id;
                                  homeViewController.refreshSubCategories(
                                      homeViewController.selectedItem.value);
                                  homeViewController
                                          .selectedCategoryName.value =
                                      homeViewController.categories[index].name;
                                },
                                child: Obx(
                                  () => Container(
                                      width: isDesktop ? 110 : 70,
                                      height: double.infinity,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: isDesktop ? 110 : 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: homeViewController
                                                            .selectedItem
                                                            .value ==
                                                        homeViewController
                                                            .categories[index]
                                                            .id
                                                    ? AppColors.primaryColor
                                                    : AppColors.grayMain),
                                            child: Center(
                                              child: SizedBox(
                                                width: isDesktop ? 50 : 30,
                                                height: isDesktop ? 50 : 30,
                                                child: FittedBox(
                                                  child: Image.network(
                                                      homeViewController
                                                          .categories[index]
                                                          .image),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(homeViewController
                                                .categories[index].name),
                                          )
                                        ],
                                      )),
                                )),
                          );
                        }))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Obx(() => Text(
                            homeViewController.selectedCategoryName.value +
                                ' Menu',
                            style:
                                AppTextStyles.h1.copyWith(color: Colors.black),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed('/subCategories_screen', arguments: {
                              'categoryId':
                                  homeViewController.selectedItem.value,
                              'categoryName':
                                  homeViewController.selectedCategoryName.value,
                            });
                          },
                          child: Text(
                            'View all',
                            style: AppTextStyles.nomal
                                .copyWith(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Obx(
                    () => homeViewController.subCategories.length == 0
                        ? Center(
                            child: Text(
                                homeViewController.selectedCategoryName +
                                    ' Menu is updating'),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeViewController.subCategories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 6 : 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: index % 2 == 0
                                        ? AppColors.lightBlue
                                        : AppColors.lightPurple),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 14, 0, 0),
                                        child: Text(
                                          controller.subCategories[index].name,
                                          style: AppTextStyles.h2
                                              .copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: isDesktop
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6 *
                                                0.7
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3 *
                                                0.7,
                                        child: Image.network(
                                          controller.subCategories[index].image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Recommended',
                          style: AppTextStyles.h1.copyWith(color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(ProductsScreen.routerName);
                            },
                            child: Text(
                              'View all',
                              style: AppTextStyles.nomal
                                  .copyWith(fontSize: 14, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Obx(
                    () => homeViewController.popularProducts.length == 0
                        ? Center(
                            child: Text('Popular dishes is updating'),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                homeViewController.popularProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 2 : 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                              childAspectRatio: isDesktop ? 2.8 : 2.5,
                            ),
                            itemBuilder: (context, index) {
                              ProductModel product =
                                  homeViewController.popularProducts[index];
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24)),
                                child: Stack(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){
                                        Get.toNamed(ProductDetail.routerName, arguments: {'productId': product.id});
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                child: Image.network(
                                                  product.images[0],
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      product.name,
                                                      style: AppTextStyles.h2
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                      maxLines: 1,
                                                    ),
                                                    SizedBox(
                                                        height: isDesktop
                                                            ? context.height *
                                                                0.005
                                                            : 0),
                                                    Text(
                                                        product.description
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: AppTextStyles.nomal
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black)),
                                                    SizedBox(
                                                      height: isDesktop
                                                          ? context.height * 0.003
                                                          : 0,
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: product.rating,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 14.0,
                                                      direction: Axis.horizontal,
                                                    ),
                                                    SizedBox(
                                                        height: isDesktop
                                                            ? context.height *
                                                                0.003
                                                            : context.height *
                                                                0.002),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                              "\$" +
                                                                  product.price
                                                                      .toDouble()
                                                                      .toString(),
                                                              maxLines: 2,
                                                              style: AppTextStyles
                                                                  .h2
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .red)),
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child: ElevatedButton(
                                                              onPressed: () async {
                                                                if (cartController.user?.uid != null) {
                                                                  if (await cartController
                                                                      .addToCart(
                                                                          product)) {
                                                                    showTopSnackBar(
                                                                      Overlay.of(
                                                                          context),
                                                                      displayDuration:
                                                                          Duration(
                                                                              milliseconds:
                                                                                  100),
                                                                      const CustomSnackBar
                                                                          .success(
                                                                        message:
                                                                            "The product has been added to cart",
                                                                      ),
                                                                    );
                                                                  } else {
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
                                                                } else {
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
                                                                          "Please login to perform this action",
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primaryColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Add to cart',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white),
                                                              ),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Obx(() => IconButton(
                                              icon: Icon(
                                                favoriteController
                                                        .isFavorite(product.id)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                if (FirebaseAuth
                                                        .instance.currentUser !=
                                                    null) {
                                                  if (favoriteController
                                                      .isFavorite(product.id)) {
                                                    favoriteController
                                                        .removeFavorite(
                                                            product.id);
                                                    showTopSnackBar(
                                                      Overlay.of(context),
                                                      displayDuration: Duration(
                                                          milliseconds: 100),
                                                      CustomSnackBar.error(
                                                        message:
                                                            "The product has been removed from your favorites",
                                                      ),
                                                    );
                                                  } else {
                                                    favoriteController
                                                        .addFavorite(
                                                            product.id);
                                                    showTopSnackBar(
                                                      Overlay.of(context),
                                                      displayDuration: Duration(
                                                          milliseconds: 100),
                                                      CustomSnackBar.success(
                                                        message:
                                                            "The product has been added to your favorites",
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    displayDuration: Duration(
                                                        milliseconds: 100),
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
                              );
                            },
                          ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
