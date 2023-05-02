import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/FavoriteModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';

class FavoriteController extends GetxController{
  final StoreService _storeService = StoreService();
  Rx<FavoriteModel> favorites= FavoriteModel(productIds: [], userId: '').obs;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  //String? userId = 'WA6QMVdHHiUiZsWFZkaTOJo34IY2';
  final RxList<ProductModel> favoriteProducts = RxList<ProductModel>([]);
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    isLoading = true.obs;
      if(userId != null){
        _storeService.getFavorites(userId!).listen((data) async {
          favorites.value = FavoriteModel(productIds: data,userId:userId);
          List<ProductModel> products = [];
          for (String productId in data) {
            ProductModel product = await _storeService.getProductById(productId);
            products.add(product);
          }
          favoriteProducts.assignAll(products);
        });
      }
      isLoading = false.obs;
    super.onInit();
  }
  void addFavorite(String productId) {
    _storeService.addFavorite(userId!, productId);

  }

  void removeFavorite(String productId) {
    _storeService.removeFavorite(userId!, productId);
  }
  bool isFavorite(String productId) {
    return favorites.value.productIds.contains(productId);
  }
}