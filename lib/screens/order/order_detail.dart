import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:get/get.dart';

class OrderDetail extends GetView<OrderController> {
  OrderDetail({Key? key}) : super(key: key);

  static String routerName = '/order_detail';
  final orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments?['orderId']??null;
    orderController.orderId.value =orderId;
    return Scaffold(
      body: Text(orderId),
    );
  }
}
