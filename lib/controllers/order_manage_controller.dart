import 'package:food_delivery_app/models/OrderModel.dart';
import 'package:get/get.dart';

import '../models/Productmodel.dart';
import '../services/store_service.dart';

class OrderManageController extends GetxController {
  final StoreService _storeService = StoreService();
  RxList<OrderModel> orders = <OrderModel>[].obs;
  List<OrderModel> pendingOrders = <OrderModel>[].obs;
  List<OrderModel> requestOrders = <OrderModel> [];
  List<OrderModel> completedOrders = <OrderModel> [];
  RxList<OrderModel> finalOrders = <OrderModel> [].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    _storeService.getOrders().listen((List<OrderModel> data) {
      orders.value = data;
    });
    _storeService.getOrdersByStatus("Completed").listen((List<OrderModel> data) {
      completedOrders = data;
    });
    orders.listen((data) async {
      finalOrders.value = orders.value;
      requestOrders = orders.value.where((item) => item.cancelRequest == true).toList();
      pendingOrders = orders.value.where((item) => item.status == 'Pending').toList();
      isLoading.value = false;
    });
    super.onInit();
  }
  Future<bool> removeOrder(String id) async {
    try {
      await _storeService.removeOrder(id);
      return true;
      print('Product removed successfully!');
    } catch (error) {
      return false;
    }
  }
  @override
  void refresh() {}

  @override
  void onClose() {}

  @override
  void onReady() {}
}
