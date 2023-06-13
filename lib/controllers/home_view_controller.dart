import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../config/helper/random_string_helper.dart';
import '../models/BannerModel.dart';
import '../models/CategoryModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';



class HomeViewController extends GetxController{
  var isVisible = false.obs;
  var displayName = FirebaseService().getCurrentUser()?.displayName;
  var selectedItem = ''.obs;
  var selectedCategoryName = ''.obs;
  final StoreService _storeService = StoreService();
  var categories = <CategoryModel>[].obs;
  var subCategories = <CategoryModel>[].obs;
  var popularProducts = <ProductModel>[].obs;
  var itemCart = 4.obs;
  var allProducts = <ProductModel>[].obs;
  var isLoading = true.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  void refreshSubCategories(String value){
    subCategories.bindStream(_storeService.getSubCategories(value));
  }
  void defaultInit(){
    selectedItem.value = categories[0].id;
    selectedCategoryName.value = categories[0].name;
    refreshSubCategories(categories[0].id);
  }
  @override
  void onInit() async {
    categories.bindStream(_storeService.getCategories());
    ever(categories, (_) => {
      if (selectedCategoryName.value == '')defaultInit()
    });
    _storeService.getBannersStream().listen((List<BannerModel> data) {
      banners.value = data;
    });
    banners.listen((data) async {
      isLoading.value = false;
    });
    _storeService.getProducts().listen((List<ProductModel> data) {
      allProducts.value = data;
    });
    popularProducts.bindStream(_storeService.getPopularProducts());
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {

  }
}