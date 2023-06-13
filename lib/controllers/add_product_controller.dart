import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../config/helper/random_string_helper.dart';
import '../models/CategoryModel.dart';
import '../models/Productmodel.dart';
import '../services/store_service.dart';

class AddProductController extends GetxController {
  final StoreService _storeService = StoreService();
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<CategoryModel?> selectedSubCategory = Rx<CategoryModel?>(null);
  RxBool isLoading = true.obs;
  final ImagePicker imagePicker = ImagePicker();
  RxList<String> imageFileList = <String>[].obs;
  RxString productName=''.obs;
  RxDouble price=0.0.obs;
  RxInt quantity=0.obs;
  RxString description=''.obs;
  void selectImage() async{
    final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    var imageUrl;
    if(file == null) return;
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDir = referenceRoot.child('images');
      Reference referenceToUpload =referenceDir.child(DateTime.now().microsecondsSinceEpoch.toString());
      try{
        await referenceToUpload.putFile(File(file!.path));
        imageUrl = await referenceToUpload.getDownloadURL();
        imageFileList?.add(imageUrl);
      }catch(e){
      }
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


  Future<bool> addProduct() async {
    try {
      ProductModel product = ProductModel(
        id: RandomStringHelper.generateRandomString(20),
        name: productName?.value ?? '',
        description: description?.value ?? '',
        price: price?.value ?? 0.0,
        categoryId: selectedCategory.value?.id??'',
        subCategoryId: selectedSubCategory.value?.id??'',
        created_at: DateTime.now().toString(),
        quantity: quantity?.value ?? 0,
        rating: 5.0,
        sales: 0,
        images: imageFileList?.value??[],
      );
      await _storeService.addProduct(product);
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