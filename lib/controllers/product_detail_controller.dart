import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../config/helper/random_string_helper.dart';
import '../models/CategoryModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';

class ProductDetailController extends GetxController {
  final StoreService _storeService = StoreService();
  Rx<ProductModel?> productModel = Rx<ProductModel?>(null);
  RxBool isLoading = true.obs;
  final productId = Get.arguments?['productId'];
  RxInt quantity = 1.obs;
  void getProductById(String productId) async {
    productModel.value = await _storeService.getProductById(productId);
    isLoading.value = false;
  }
  @override
  void onInit() {
    quantity.value = 1;
  }

  @override
  void refresh() {}

  @override
  void onClose() {}

  @override
  void onReady() {}
}