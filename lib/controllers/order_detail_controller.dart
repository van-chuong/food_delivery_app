import 'package:food_delivery_app/config/helper/dialog_helper.dart';
import 'package:food_delivery_app/models/OrderModel.dart';
import 'package:get/get.dart';

import '../services/store_service.dart';

class OrderDetailController extends GetxController {
  final StoreService _storeService = StoreService();
  var isLoading = true.obs;
  var canceled = false.obs;
  OrderModel? order;

  @override
  void onInit() async {
    getOrderDetails();
    super.onInit();
  }

  void getOrderDetails() async {
    try {
      isLoading(true);
      var orderId = Get.arguments['orderId'] ?? '';
      OrderModel orderData = await _storeService.getOrderById(orderId);
      order = orderData;
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

   Future<bool> sendRequestCancel(String? orderId) async {
     try {
       DialogHelper.showLoading('Submitting');
       _storeService.updateOrderCancelRequest(orderId!);
       DialogHelper.hideLoading();
       return true;
     } catch (e) {
       print(e.toString());
       DialogHelper.hideLoading();
       return false;
     }
  }
}
