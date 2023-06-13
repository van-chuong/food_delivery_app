import 'package:get/get.dart';

import '../models/Productmodel.dart';
import '../services/store_service.dart';

class ProductManageController extends GetxController {
  final StoreService _storeService = StoreService();
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = true.obs;
  RxList<ProductModel> finalProducts = <ProductModel>[].obs;
  List<ProductModel> outOfStockProducts = <ProductModel>[];
  @override
  void onInit() {
    isLoading.value = true;
    _storeService.getProducts().listen((List<ProductModel> data) {
      products.value = data;
    });
    products.listen((data) async {
      finalProducts.value = products.value;
      outOfStockProducts = products.value.where((item) => item.quantity == 0).toList();
      isLoading.value = false;
    });
    super.onInit();
  }
  Future<bool> removeProduct(String id) async {
    try {
      await _storeService.removeProduct(id);
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
