import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/screens/product/product_detail.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../controllers/product_controller.dart';
import '../../models/CategoryModel.dart';
import '../../models/Productmodel.dart';

class ProductsScreen extends GetView<ProductsController> {
  static String routerName = '/products_screen';

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductsController());
    final favoriteController = Get.put(FavoriteController());
    final cartController = Get.put(CartController());
    var isDesktop = context.width > 1000;
    final overlayState = Overlay.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30,10,30,20),
            child: SizedBox(
              height: 30,
              child: ListView(
                //itemExtent: 300,
                scrollDirection: Axis.horizontal,
                children: [
                  Obx(() =>
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select Category',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                          ),
                          value: productController.selectedCategory.value,
                          items: productController.categories.map((category) => DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Text(category.name,
                              style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                                ),
                              ),
                            )
                          ).toList(),
                          onChanged: (value) {
                            // Do something when the selected category changes
                            productController.selectedCategory.value = value;
                            productController.loadSubCategories(productController.selectedCategory.value?.id);
                            productController.selectedSubCategory.value = null;
                            productController.filterProductsByCategory(productController.selectedCategory.value?.id);
                            productController.isLoading.value = false;
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                              color: AppColors.grayMain,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                        ),
                      )
                  ),
                  // SizedBox(height: context.width*0.05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Obx(() =>
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Select Menu',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            value: productController.selectedSubCategory.value,
                            items: productController.subCategories.map((category) => DropdownMenuItem<CategoryModel>(
                              value: category,
                              child: Text(category.name,
                                style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),),
                            )).toList(),
                            onChanged: (value) {
                              // Do something when the selected category changes
                              productController.selectedSubCategory.value = value;
                              productController.filterProductsBySubCategory(productController.selectedSubCategory.value?.id);
                              productController.isLoading.value = false;
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration: BoxDecoration(
                                color: AppColors.grayMain,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                            ),
                          ),
                        )
                    ),
                  ),
                  Obx(() =>
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Filter By',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          value: productController.selectedSortType.value,
                          items: productController.sortType.map((String sortType) => DropdownMenuItem(
                            value: sortType,
                            child: Text(sortType,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),),
                          )).toList(),
                          onChanged: (value) {
                            // Do something when the selected category changes
                            productController.selectedSortType.value = value!;
                            productController.sortProducts(value);
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                              color: AppColors.grayMain,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: (){
                          productController.loadProducts();
                          productController.selectedSortType.value = null;
                          productController.selectedCategory.value = null;
                          productController.selectedSubCategory.value = null;
                        },
                        child: Text('Remove Filter')
                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primaryColor,),
                );
              } else {
                if(productController.products.length >0) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productController.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 3 : 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: isDesktop ? 2.8 : 2.5,
                        ),
                        itemBuilder: (context, index) {
                          ProductModel product =
                          productController.products[index];
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
                                            borderRadius: BorderRadius.circular(
                                                24),
                                            child: Image.network(
                                              product.images[0],
                                              fit: BoxFit.cover,
                                              height: double.infinity,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
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
                                                      color: Colors.black),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                    height: isDesktop
                                                        ? context.height * 0.005
                                                        : 0),
                                                Text(product.description
                                                    .toString(),
                                                    maxLines: 2,
                                                    style: AppTextStyles.nomal
                                                        .copyWith(
                                                        fontSize: 12,
                                                        color: Colors.black)),
                                                SizedBox(
                                                  height: isDesktop
                                                      ? context.height * 0.003
                                                      : 0,
                                                ),
                                                RatingBarIndicator(
                                                  rating: product.rating,
                                                  itemBuilder: (context, index) =>
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
                                                        ? context.height * 0.003
                                                        : context.height * 0.002),
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
                                                          style: AppTextStyles.h2
                                                              .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                              Colors.red)),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            if(cartController.user?.uid !=null){
                                                              if(await cartController.addToCart(product)){
                                                                showTopSnackBar(
                                                                  Overlay.of(context),
                                                                  displayDuration: Duration(milliseconds: 100),
                                                                  const CustomSnackBar.success(
                                                                    message:
                                                                    "The product has been added to cart",
                                                                  ),
                                                                );
                                                              }else{
                                                                showTopSnackBar(
                                                                  Overlay.of(context),
                                                                  displayDuration: Duration(milliseconds: 100),
                                                                  const CustomSnackBar.error(
                                                                    message:
                                                                    "An error occurred, please try again later",
                                                                  ),
                                                                );
                                                              }
                                                            }else{
                                                              showTopSnackBar(
                                                                Overlay.of(context),
                                                                displayDuration: Duration(milliseconds: 100),
                                                                const CustomSnackBar.error(
                                                                  message:
                                                                  "Please login to perform this action",
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                            AppColors
                                                                .primaryColor,
                                                            shape:
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
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
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0, right:0,
                                    child: Obx(()=>IconButton(
                                      icon: Icon(
                                        favoriteController.isFavorite(product.id)?Icons.favorite:Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: (){
                                        if(FirebaseAuth.instance.currentUser != null){
                                          if(favoriteController.isFavorite(product.id)) {
                                            favoriteController.removeFavorite(product.id);
                                            showTopSnackBar(
                                              overlayState,
                                              displayDuration: Duration(milliseconds: 100),
                                              CustomSnackBar.error(
                                                message:
                                                "The product has been removed from your favorites",
                                              ),
                                            );
                                          }
                                          else{
                                            favoriteController.addFavorite(product.id);
                                            showTopSnackBar(
                                              overlayState,
                                              displayDuration: Duration(milliseconds: 100),
                                              CustomSnackBar.success(
                                                message:
                                                "The product has been added to your favorites",
                                              ),
                                            );
                                          }
                                        }else{
                                          showTopSnackBar(
                                            overlayState,
                                            displayDuration: Duration(milliseconds: 100),
                                            CustomSnackBar.error(
                                              message:
                                              "You need to be logged in to add your favorite products",
                                            ),
                                          );
                                        }
                                      },
                                    ))
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }else{
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Center(
                      child: Text('More products are being updated'),
                    ),
                  );
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
