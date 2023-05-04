import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/overlay.dart';
import 'package:food_delivery_app/services/store_service.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../models/CartItemModel.dart';
import '../models/Productmodel.dart';
import '../services/storage_service.dart';

class CartController extends GetxController {
  final StoreService _storeService = StoreService();
  final user = FirebaseAuth.instance.currentUser;
  var cartItems = <CartItemModel>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    if(user?.uid!=null){
      isLoading.value = true;
      cartItems.bindStream(_storeService.getCartItems(user?.uid));
      ever(cartItems, (_) => {
      isLoading.value = false
      });
    }
  }

  Future<bool> addToCart(ProductModel productModel) async {
    final uid = user?.uid;
    final cartItem = CartItemModel(
        id: productModel.id,
        name: productModel.name,
        image: productModel.images[0],
        price: productModel.price,
        quantity: productModel.quantity);
      if(await _storeService.addCartItem(uid!,cartItem)){
        return true;
      }
      return false;
  }
}