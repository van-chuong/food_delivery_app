
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../config/helper/dialog_helper.dart';
import '../models/StatisticalModel.dart';
import '../screens/auth/home_screen.dart';
import '../services/firebase_service.dart';
import '../services/store_service.dart';
import 'package:intl/intl.dart';

class DashBoardController extends GetxController {
  final StoreService _storeService = StoreService();
  final FirebaseService _firebaseService = FirebaseService();
  final RxList<StatisticalModel> statisticalList = RxList<StatisticalModel>();
  final dayNow = DateFormat('yyyy/MM/dd').format(DateTime.now());
  var revenue =0.0.obs;
  var isLoading = true.obs;
  var orders = 0.obs;
  var products = 0.obs;
  var users = 0.obs;
  var categories = 0.obs;
  var dataSales =[].obs;
  var touchedIndex = 0.obs;
  RxList dataPie=[].obs;
  @override
  void onInit() async {
    isLoading.value = true;
    _storeService.getStatistical().listen((List<StatisticalModel> data) {
      statisticalList.value = data;
    });
    statisticalList.listen((data) async {
      revenue.value = statisticalList.fold(0, (sum, item) => sum + item.sales);
      orders.value = statisticalList.fold(0, (sum, item) => sum + item.ordersTotal);
      products.value = await _storeService.countProducts();
      categories.value = await _storeService.countCategories();
      users.value = await _storeService.getTotalUsersInDay(dayNow);
      dataPie.value =[
        Data(name: "Product",count: products.value,color: Colors.blue),
        Data(name: "User",count: users.value,color: Colors.yellowAccent),
        Data(name: "Order",count: orders.value,color: Colors.purple),
        Data(name: "Category",count: categories.value,color: Colors.green)
      ];
      isLoading.value = false;
    });
    super.onInit();
  }
  signOut(){
    DialogHelper.showLoading('Signing out');
    _firebaseService.signOut();
    Get.offAllNamed(HomeScreen.routerName);
  }
}
class Data{
  final String name;
  final int count;
  final Color color;
  Data({required this.name,required this.count,required this.color});
}