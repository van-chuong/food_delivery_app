import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../models/FavoriteModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';

class FavoriteController extends GetxController{
  final StoreService _storeService = StoreService();
  Rx<FavoriteModel> favorites= FavoriteModel(productIds: [], userId: '').obs;
  //String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? userId = 'WA6QMVdHHiUiZsWFZkaTOJo34IY2';
  final RxList<ProductModel> favoriteProducts = RxList<ProductModel>([]);
  @override
  void onInit() async {
    // Replace with your user ID
    _storeService.getFavorites(userId!).listen((data) async {
      favorites.value = FavoriteModel(productIds: data,userId:userId);
      List<ProductModel> products = [];
      for (String productId in data) {
        ProductModel product = await _storeService.getProductById(productId);
        if (product != null) {
          products.add(product);
        }
      }
      favoriteProducts.assignAll(products);
    });
    super.onInit();
  }
  void addFavorite(String productId) {// Replace with your user ID
    _storeService.addFavorite(userId!, productId);
  }

  void removeFavorite(String productId) {
    _storeService.removeFavorite(userId!, productId);
  }
  bool isFavorite(String productId) {
    return favorites.value.productIds.contains(productId);
  }
}