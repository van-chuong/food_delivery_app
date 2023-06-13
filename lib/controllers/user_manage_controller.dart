
import 'package:food_delivery_app/models/UserModel.dart';
import 'package:get/get.dart';

import '../models/Productmodel.dart';
import '../services/store_service.dart';
import 'package:intl/intl.dart';

class UserManageController extends GetxController {
  final StoreService _storeService = StoreService();
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = true.obs;
  List<UserModel> newUsers = <UserModel>[];
  RxList<UserModel> finalUsers = <UserModel>[].obs;
  final dayNow = DateFormat('yyyy/MM/dd').format(DateTime.now());
  @override
  void onInit() {
    isLoading.value = true;
    _storeService.getUsers().listen((List<UserModel> data) {
      users.value = data;
      finalUsers.value = data;
    });
    users.listen((data) async {

      newUsers = users.value.where((item) => item.createAt == dayNow).toList();
      isLoading.value = false;
    });
    super.onInit();
  }
  // Future<bool> removeProduct(String id) async {
  //   try {
  //     await _storeService.removeProduct(id);
  //     return true;
  //     print('Product removed successfully!');
  //   } catch (error) {
  //     return false;
  //   }
  // }
  @override
  void refresh() {}

  @override
  void onClose() {}

  @override
  void onReady() {}
}
