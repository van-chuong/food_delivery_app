import 'package:food_delivery_app/config/helper/dialog_helper.dart';
import 'package:food_delivery_app/models/OrderModel.dart';
import 'package:get/get.dart';

import '../services/store_service.dart';

class EditOrderController extends GetxController {
  final StoreService _storeService = StoreService();
  var isLoading = true.obs;
  var canceled = false.obs;
  OrderModel? order;
  var status = ''.obs;
  void setStatus(String value) {
    status.value = value;
  }
  @override
  void onInit() async {
    getOrderDetails();
    super.onInit();
  }
  Future<bool> updateOrder() async {
    try {
      await _storeService.updateOrderStatus(order!.orderid,status.value,order!);
      return true;
      print('Product added successfully!');
    } catch (error) {
      return false;
      print('Error adding product: $error');
    }
  }
  void getOrderDetails() async {
    try {
      isLoading(true);
      var orderId = Get.arguments['orderId'] ?? '';
      OrderModel orderData = await _storeService.getOrderById(orderId);
      order = orderData;
      status.value = order!.status;
      canceled.value = order?.cancelRequest ?? false;
      if (canceled.value == false && order?.status == 'Pending') {
        canceled(true);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

}
