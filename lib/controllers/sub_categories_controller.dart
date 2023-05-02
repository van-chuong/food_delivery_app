import 'package:get/get.dart';

import '../models/CategoryModel.dart';
import '../services/store_service.dart';

class SubCategoriesController extends GetxController{

  final StoreService _storeService = StoreService();
  var isLoading = true.obs;
  var subCategories = <CategoryModel>[].obs;
  var categoryId= ''.obs;
  var categoryName = ''.obs;
  @override
  void refresh() {

  }

  void loadProductsForCategory(String categoryId) async {
    isLoading.value = true; // Bật cờ loading
    update(); // Cập nhật lại trạng thái của sản phẩm
    try {
      // Fetch the products from Firebase for the selected category
      final products = await _storeService.getAllSubCategories(categoryId);

      // Update the product list in the state management
      subCategories.assignAll(products);
      print(categoryId);
    } catch (e) {
      // Handle the error
      print('Error loading products: $e');
    }

    isLoading.value = false; // Tắt cờ loading
    update(); // Cập nhật lại trạng thái của sản phẩm
  }

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    categoryId.value = arguments['categoryId'];
    categoryName.value = arguments['categoryName'];
    // Load products for the selected category
    loadProductsForCategory(categoryId.value);
  }

  @override
  void onReady() {

  }

  @override
  void onClose() {

  }
}