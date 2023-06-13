import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/themes/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../widgets/page_not_found.dart';
class ProductDetail extends StatelessWidget {
  ProductDetail({super.key});
  static String routerName = '/product_detail';
  final productDetailController = Get.put(ProductDetailController());
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    final productId = Get.arguments?['productId'] as String? ?? '';
    productDetailController.getProductById(productId);
    if (productId != '') {
      return SafeArea(
        child: Obx(() {
          if(productDetailController.isLoading.value){
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),)
                ],
              ),
            );
          }else{
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  productDetailController.productModel.value?.name ??
                      'Product Detail',
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
              body: isDesktop
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,30,0),
                        child: Container(
                          height: 300,
                          child: CarouselSlider(
                              items: productDetailController.productModel.value!.images
                                  .map((item) => Container(
                                child: Center(
                                  child: ClipRRect(borderRadius: BorderRadius.circular(24),
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      width: context.width - 60,
                                    ),
                                  ),
                                ),
                              )).toList(),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2,
                                  enlargeCenterPage: true)),
                        ),
                      ),),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,30,0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productDetailController.productModel.value?.name??'',style: AppTextStyles.h1.copyWith(color: Colors.black),),
                                      Row(
                                        children: [
                                          Text(productDetailController.productModel.value?.rating.toStringAsFixed(2)??'',style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                          SizedBox(width: 10,),
                                          RatingBarIndicator(
                                            rating: productDetailController.productModel.value?.rating??0.0,
                                            itemBuilder:
                                                (context, index) =>
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
                                    ],),
                                  Text("\$ ${productDetailController.productModel.value?.price.toStringAsFixed(2)}",style: AppTextStyles.h1.copyWith(color: AppColors.red),),

                                ],
                              ),
                              SizedBox(height: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if(productDetailController.quantity.value>1){
                                                productDetailController.quantity.value = productDetailController.quantity.value -1;
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: AppColors.grayMain,
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            productDetailController.quantity.value.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5,),
                                          InkWell(
                                            onTap: () {
                                              productDetailController.quantity.value = productDetailController.quantity.value +1;
                                            },
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: AppColors.primaryColor,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Total: \$ ${productDetailController.quantity.value*(productDetailController.productModel.value!.price.toDouble()
                                        )}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 300,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (cartController.user?.uid != null) {
                                            if (await cartController.addToCartWithQuantity(productDetailController.productModel.value!,productDetailController.quantity.value)) {
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                displayDuration: Duration(milliseconds:100),
                                                const CustomSnackBar.success(
                                                  message:
                                                  "The product has been added to cart",
                                                ),
                                              );
                                            } else {
                                              showTopSnackBar(Overlay.of(context),
                                                displayDuration:Duration(milliseconds:100),
                                                const CustomSnackBar.error(
                                                  message:
                                                  "An error occurred, please try again later",
                                                ),
                                              );
                                            }
                                          } else {
                                            showTopSnackBar(Overlay.of(context),
                                              displayDuration:Duration(milliseconds:100),
                                              const CustomSnackBar.error(
                                                message:
                                                "Please login to perform this action",
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          'Add To Cart',
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
                                ],
                              ),
                            ],
                          ),
                        ),)
                      ],
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),child: Divider(),),
                    Row(
                      children: [
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0),
                              child:Text(
                                'Description', style: AppTextStyles.h1.copyWith(color: Colors.black,fontSize: 20), textAlign: TextAlign.left,
                              ),),
                            Padding(padding: const EdgeInsets.fromLTRB(30,10,30,0),
                                child:Text(
                                  '${productDetailController.productModel.value?.description}',
                                  style: AppTextStyles.nomal.copyWith(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify, // Căn đều dòng văn bản

                                )
                            ),
                          ],
                        ),),
                        Expanded(child: Column(
                          children: [
                            Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0),
                              child:Text(
                                'Review', style: AppTextStyles.h1.copyWith(color: Colors.black,fontSize: 20), textAlign: TextAlign.left,
                              ),),
                            Padding(padding: const EdgeInsets.fromLTRB(30,10,30,0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            "${productDetailController.productModel.value?.rating.toStringAsFixed(2)}",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.h2.copyWith(color: Colors.black),
                                          ),
                                          RatingBarIndicator(
                                            rating: productDetailController.productModel.value?.rating??0.0,
                                            itemBuilder:
                                                (context, index) => Icon(
                                              Icons.star,
                                              color: AppColors.primaryColor,
                                            ),
                                            itemCount: 5,
                                            itemSize: 24.0,
                                            direction: Axis.horizontal,
                                          ),
                                          Text(
                                            'Base on 1 reviews',
                                            textAlign: TextAlign.center,
                                            style:  AppTextStyles.h2.copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '1 Reviews',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(width: 10,),
                                              RatingBarIndicator(
                                                rating: 5.0,
                                                itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                itemCount: 5,
                                                itemSize: 14.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '0 Reviews',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(width: 10,),
                                              RatingBarIndicator(
                                                rating: 4.0,
                                                itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                itemCount: 4,
                                                itemSize: 14.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '0 Reviews',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(width: 10,),
                                              RatingBarIndicator(
                                                rating: 3.0,
                                                itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                itemCount: 3,
                                                itemSize: 14.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '0 Reviews',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(width: 10,),
                                              RatingBarIndicator(
                                                rating: 2.0,
                                                itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                itemCount: 2,
                                                itemSize: 14.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '0 Reviews',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(width: 10,),
                                              RatingBarIndicator(
                                                rating: 1.0,
                                                itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                itemCount: 1,
                                                itemSize: 14.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(30,20,30,0),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          "https://firebasestorage.googleapis.com/v0/b/flutter-food-1a10d.appspot.com/o/images%2Favatar.png?alt=media&token=8d6b1806-bb94-4391-8977-aed51aa9efb5",
                                        ),
                                        backgroundColor: AppColors.blueMain, // Màu nền
                                        radius: 50,
                                      ),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Van Chuong',
                                                    textAlign: TextAlign.center,
                                                    style:  AppTextStyles.h2.copyWith(color: Colors.black),
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingBarIndicator(
                                                        rating: 5.0,
                                                        itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                        itemCount: 5,
                                                        itemSize: 14.0,
                                                        direction: Axis.horizontal,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Text("5.0",style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                                    ],
                                                  ),
                                                  Text("2023/06/12",style: AppTextStyles.nomal.copyWith(color: Colors.black,fontSize: 16),),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          "https://firebasestorage.googleapis.com/v0/b/flutter-food-1a10d.appspot.com/o/images%2Favatar.png?alt=media&token=8d6b1806-bb94-4391-8977-aed51aa9efb5",
                                        ),
                                        backgroundColor: AppColors.blueMain, // Màu nền
                                        radius: 50,
                                      ),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Anh Thu',
                                                    textAlign: TextAlign.center,
                                                    style:  AppTextStyles.h2.copyWith(color: Colors.black),
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingBarIndicator(
                                                        rating: 5.0,
                                                        itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                        itemCount: 5,
                                                        itemSize: 14.0,
                                                        direction: Axis.horizontal,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Text("5.0",style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                                    ],
                                                  ),
                                                  Text("2023/06/12",style: AppTextStyles.nomal.copyWith(color: Colors.black,fontSize: 16),),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),),
                      ],
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
              )
                  :Stack(
                children: [
                    OverflowBox(
                      alignment: Alignment.topCenter,
                      maxHeight: double.infinity,
                      child: Container(
                        height: context.height - 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30,20,30,0),
                                child: Container(
                                  height: isDesktop?300:200,
                                  child: CarouselSlider(
                                      items: productDetailController.productModel.value!.images
                                          .map((item) => Container(
                                        child: Center(
                                          child: ClipRRect(borderRadius: BorderRadius.circular(24),
                                            child: Image.network(
                                              item,
                                              fit: BoxFit.cover,
                                              width: context.width - 60,
                                            ),
                                          ),
                                        ),
                                      )).toList(),
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          aspectRatio: 2,
                                          enlargeCenterPage: true)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20,20,30,0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(productDetailController.productModel.value?.name??'',style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                        Row(
                                          children: [
                                            Text(productDetailController.productModel.value?.rating.toStringAsFixed(2)??'',style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                            SizedBox(width: 10,),
                                            RatingBarIndicator(
                                              rating: productDetailController.productModel.value?.rating??0.0,
                                              itemBuilder:
                                                  (context, index) =>
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
                                      ],),
                                    Text("\$ ${productDetailController.productModel.value?.price.toStringAsFixed(2)}",style: AppTextStyles.h2.copyWith(color: AppColors.red),),

                                  ],
                                ),
                              ),
                              Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),child: Divider(),),
                              Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                child:Text(
                                  'Description', style: AppTextStyles.h1.copyWith(color: Colors.black,fontSize: 20), textAlign: TextAlign.left,
                                ),),
                              Padding(padding: const EdgeInsets.fromLTRB(30,10,30,0),
                                  child:Text(
                                    '${productDetailController.productModel.value?.description}',
                                    style: AppTextStyles.nomal.copyWith(
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify, // Căn đều dòng văn bản

                                  )
                              ),
                              Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),child: Divider(),),
                              Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                child:Text(
                                  'Review', style: AppTextStyles.h1.copyWith(color: Colors.black,fontSize: 20), textAlign: TextAlign.left,
                                ),),
                              Padding(padding: const EdgeInsets.fromLTRB(30,10,30,0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${productDetailController.productModel.value?.rating.toStringAsFixed(2)}",
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.h2.copyWith(color: Colors.black),
                                            ),
                                            RatingBarIndicator(
                                              rating: productDetailController.productModel.value?.rating??0.0,
                                              itemBuilder:
                                                  (context, index) => Icon(
                                                Icons.star,
                                                color: AppColors.primaryColor,
                                              ),
                                              itemCount: 5,
                                              itemSize: 24.0,
                                              direction: Axis.horizontal,
                                            ),
                                            Text(
                                              'Base on 1 reviews',
                                              textAlign: TextAlign.center,
                                              style:  AppTextStyles.h2.copyWith(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '1 Reviews',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(width: 10,),
                                                RatingBarIndicator(
                                                  rating: 5.0,
                                                  itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                  itemCount: 5,
                                                  itemSize: 14.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '0 Reviews',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(width: 10,),
                                                RatingBarIndicator(
                                                  rating: 4.0,
                                                  itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                  itemCount: 4,
                                                  itemSize: 14.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '0 Reviews',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(width: 10,),
                                                RatingBarIndicator(
                                                  rating: 3.0,
                                                  itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                  itemCount: 3,
                                                  itemSize: 14.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '0 Reviews',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(width: 10,),
                                                RatingBarIndicator(
                                                  rating: 2.0,
                                                  itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                  itemCount: 2,
                                                  itemSize: 14.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '0 Reviews',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(width: 10,),
                                                RatingBarIndicator(
                                                  rating: 1.0,
                                                  itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                  itemCount: 1,
                                                  itemSize: 14.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: const EdgeInsets.fromLTRB(30,20,30,0),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/flutter-food-1a10d.appspot.com/o/images%2Favatar.png?alt=media&token=8d6b1806-bb94-4391-8977-aed51aa9efb5",
                                          ),
                                          backgroundColor: AppColors.blueMain, // Màu nền
                                          radius: 50,
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Van Chuong',
                                                      textAlign: TextAlign.center,
                                                      style:  AppTextStyles.h2.copyWith(color: Colors.black),
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: 5.0,
                                                          itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                          itemCount: 5,
                                                          itemSize: 14.0,
                                                          direction: Axis.horizontal,
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Text("5.0",style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                                      ],
                                                    ),
                                                    Text("2023/06/12",style: AppTextStyles.nomal.copyWith(color: Colors.black,fontSize: 16),),
                                                  ],
                                                ),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/flutter-food-1a10d.appspot.com/o/images%2Favatar.png?alt=media&token=8d6b1806-bb94-4391-8977-aed51aa9efb5",
                                          ),
                                          backgroundColor: AppColors.blueMain, // Màu nền
                                          radius: 50,
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Anh Thu',
                                                      textAlign: TextAlign.center,
                                                      style:  AppTextStyles.h2.copyWith(color: Colors.black),
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: 5.0,
                                                          itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.primaryColor,),
                                                          itemCount: 5,
                                                          itemSize: 14.0,
                                                          direction: Axis.horizontal,
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Text("5.0",style: AppTextStyles.h2.copyWith(color: Colors.black),),
                                                      ],
                                                    ),
                                                    Text("2023/06/12",style: AppTextStyles.nomal.copyWith(color: Colors.black,fontSize: 16),),
                                                  ],
                                                ),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: context.width,
                      height: 130,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if(productDetailController.quantity.value>1){
                                          productDetailController.quantity.value = productDetailController.quantity.value -1;
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: AppColors.grayMain,
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      productDetailController.quantity.value.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5,),
                                    InkWell(
                                      onTap: () {
                                        productDetailController.quantity.value = productDetailController.quantity.value +1;
                                      },
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  'Total: \$ ${productDetailController.quantity.value*(productDetailController.productModel.value!.price.toDouble()
                                  )}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                        if (cartController.user?.uid != null) {
                                          if (await cartController.addToCartWithQuantity(productDetailController.productModel.value!,productDetailController.quantity.value)) {
                                            showTopSnackBar(
                                              Overlay.of(context),
                                              displayDuration: Duration(milliseconds:100),
                                              const CustomSnackBar.success(
                                                message:
                                                "The product has been added to cart",
                                                ),
                                              );
                                      } else {
                                            showTopSnackBar(Overlay.of(context),
                                            displayDuration:Duration(milliseconds:100),
                                            const CustomSnackBar.error(
                                              message:
                                              "An error occurred, please try again later",
                                              ),
                                            );
                                      }
                                      } else {
                                        showTopSnackBar(Overlay.of(context),
                                        displayDuration:Duration(milliseconds:100),
                                        const CustomSnackBar.error(
                                        message:
                                        "Please login to perform this action",
                                        ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Add To Cart',
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
              )
            );
          }
        }),
      );
    }
    return Scaffold(body:PageNotFound(isDesktop: isDesktop));
  }
}
