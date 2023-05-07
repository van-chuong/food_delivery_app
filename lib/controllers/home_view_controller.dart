import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../config/helper/random_string_helper.dart';
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
    popularProducts.bindStream(_storeService.getPopularProducts());
    String id = RandomStringHelper.generateRandomString(20);
    // _storeService.addProduct(ProductModel(
    //   id: id,
    //   name: 'Pizza Seafood',
    //   description: 'This pizza is made with seafood such as shrimp, squid, salmon and mozzarella cheese.',
    //   price: 9.99,
    //   categoryId: 'ky6DkY9WanULMZFbZoOl',
    //   subCategoryId: 'LVc90mAEWL4FS55Iw8iS',
    //   created_at: DateTime.now().toString(),
    //   quantity: 10,
    //   rating: 4.5,
    //   sales: 100,
    //   images: ['https://firebasestorage.googleapis.com/v0/b/flutter-food-1a10d.appspot.com/o/images%2Fcategories%2Fmaxresdefault.jpg?alt=media&token=ac2f9732-1def-4ba9-963c-34b41fc8b4fb'],
    // ));

  }

  @override
  void onClose() {
  }

  @override
  void onReady() {

  }
}