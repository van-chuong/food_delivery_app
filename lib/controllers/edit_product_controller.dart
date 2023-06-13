import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../config/helper/random_string_helper.dart';
import '../models/CategoryModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';

class EditProductController extends GetxController {
  final StoreService _storeService = StoreService();
  Rx<ProductModel?> productModel = Rx<ProductModel?>(null);
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<CategoryModel?> selectedSubCategory = Rx<CategoryModel?>(null);
  RxBool isLoading = true.obs;
  RxString productName=''.obs;
  RxDouble price=0.0.obs;
  RxInt quantity=0.obs;
  RxString description=''.obs;
  final productId = Get.arguments?['productId'];
  Future<void> loadCategories() async {
    _storeService.getCategories().listen((data) {
      categories.value = data;
    });
  }
  Future<void> loadSubCategories(String? categoryId) async {
    if (categoryId != null) {
      _storeService.getSubCategories(categoryId).listen((data) {
        subCategories.value = data;
      });
    }
  }

  void getProductById(String productId) async {
    productModel.value = await _storeService.getProductById(productId);
    isLoading.value = false;
  }
  Future<bool> editProduct() async {
    try {
      ProductModel product = ProductModel(
        id: productModel.value?.id??'',
        name: productName?.value ?? '',
        description: description?.value ?? '',
        price: price?.value ?? 0.0,
        categoryId: selectedCategory.value?.id??'',
        subCategoryId: selectedSubCategory.value?.id??'',
        created_at: productModel.value?.created_at??'',
        quantity: quantity?.value ?? 0,
        rating: productModel.value?.rating??0.0,
        sales: productModel.value?.sales??0,
        images: productModel.value?.images??[],
      );
      await _storeService.updateProduct(product);
      return true;
      print('Product added successfully!');
    } catch (error) {
      return false;
      print('Error adding product: $error');
    }
  }
  @override
  void onInit() {
    loadCategories();
  }

  @override
  void refresh() {}

  @override
  void onClose() {}

  @override
  void onReady() {}
}