import 'package:get/get.dart';

import '../models/CategoryModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';

class ProductsController extends GetxController {
  final StoreService _storeService = StoreService();
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<CategoryModel?> selectedSubCategory = Rx<CategoryModel?>(null);
  RxBool isLoading = true.obs;
  var  sortType = ['Price: Low to High','Price: High to Low','Rating: Low to High','Rating: High to Low'].obs;
  Rx<String?> selectedSortType = Rx<String?>(null);

  Future<void> loadProducts() async {
    isLoading.value = true;
    update(); // Cập nhật lại trạng thái của sản phẩm
    try {
      // Fetch the products from Firebase for the selected category
      final fetchProducts = await _storeService.getAllProducts();
      // Update the product list in the state management
      products.assignAll(fetchProducts);
    } catch (e) {
      // Handle the error
      print('Error loading products: $e');
    }
    isLoading.value = false;
    update();
  }

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

  Future<void> filterProductsByCategory(String? categoryId) async {
    if (categoryId == '') {
      loadProducts();
    } else {
      isLoading.value = true;
      products.assignAll(await _storeService.getAllProducts());
      var filteredProducts = products
          .where((product) => product.categoryId == categoryId)
          .toList();
      products.assignAll(filteredProducts);
    }
  }

  void filterProductsBySubCategory(String? subCategoryId) async {
    if (subCategoryId == '') {
      products.assignAll(products);
    } else {
      products.assignAll(await _storeService.getProductsForCategory(selectedCategory.value?.id));
      final filteredProducts = products
          .where((product) => product.subCategoryId == subCategoryId)
          .toList();
      products.assignAll(filteredProducts);
    }
  }

  void sortProducts(String selectedSortType) {
    if (sortType.value == selectedSortType) {
      return;
    }
    isLoading.value = true;
    update();
    if (selectedSortType == 'Price: Low to High') {
      // Sắp xếp tăng dần
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSortType == 'Price: High to Low') {
      // Sắp xếp giảm dần
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedSortType == 'Rating: Low to High') {
      // Sắp xếp tăng dần
      products.sort((a, b) => a.rating.compareTo(b.rating));
    } else if (selectedSortType == 'Rating: High to Low') {
      // Sắp xếp giảm dần
      products.sort((a, b) => b.rating.compareTo(a.rating));
    }
    isLoading.value = false;
    update();
  }


  @override
  void onInit() {
    loadProducts();
    loadCategories();
  }

  @override
  void refresh() {}

  @override
  void onClose() {}

  @override
  void onReady() {}
}
