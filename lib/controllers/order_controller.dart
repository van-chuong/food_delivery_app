import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/models/CartItemModel.dart';
import 'package:food_delivery_app/models/OrderModel.dart';
import 'package:food_delivery_app/services/store_service.dart';
import 'package:get/get.dart';

import '../services/storage_service.dart';

class OrderController extends GetxController{
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final StoreService _storeService = StoreService();
  final RxList<OrderModel> orders = RxList<OrderModel>();
  var isLoading = false.obs;
  @override
  void onInit() {
    if(firebaseUser?.uid!=null){
      isLoading.value = true;
      orders.bindStream(_storeService.getOrdersByUid(firebaseUser?.uid));
      ever(orders, (_) => {
        isLoading.value = false
      });
    }
  }

}