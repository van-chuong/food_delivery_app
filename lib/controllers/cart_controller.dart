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
  var totalPrice = 0.0.obs;
  @override
  void onInit() {
    print(user?.uid);
    if(user?.uid!=null){
      isLoading.value = true;
      cartItems.bindStream(_storeService.getCartItems(user?.uid));
      ever(cartItems, (_) => {
        isLoading.value = false
      });
      ever(cartItems, _calculateTotalPrice);
    }
  }
  void _calculateTotalPrice(List<CartItemModel> items) {
    double total = 0.0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    totalPrice.value = total;
  }

  Future<bool> addToCart(ProductModel productModel) async {
    final uid = user?.uid;
    final cartItem = CartItemModel(
        id: productModel.id,
        name: productModel.name,
        image: productModel.images[0],
        price: productModel.price,
        quantity: 1,
        description: productModel.description
    );
      if(await _storeService.addCartItem(uid!,cartItem)){
        return true;
      }
      return false;
  }
  Future<bool> addToCartWithQuantity(ProductModel productModel,quantity) async {
    final uid = user?.uid;
    final cartItem = CartItemModel(
        id: productModel.id,
        name: productModel.name,
        image: productModel.images[0],
        price: productModel.price,
        quantity: quantity,
        description: productModel.description
    );
    if(await _storeService.addCartItem(uid!,cartItem)){
      return true;
    }
    return false;
  }
  decrementQuantity(String itemId)async{
    if(user?.uid !=null){
      final uid = user?.uid;
      if( await _storeService.decrementQuantity(uid!, itemId)){
        return true;
      }else{
        return false;
      }
    }

  }
  incrementQuantity(String itemId) async {
    if(user?.uid !=null){
      final uid = user?.uid;
      if( await _storeService.incrementQuantity(uid!, itemId)){
        return true;
      }else{
        return false;
      }
    }
  }
  removeCartItem(String itemId)async{
    if(user?.uid !=null){
      final uid = user?.uid;
      if( await _storeService.removeCartItem(uid!, itemId)){
        return true;
      }else{
        return false;
      }
    }
  }
}