

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controllers/add_product_controller.dart';
import '../../../controllers/edit_product_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/CategoryModel.dart';
class EditProduct extends StatelessWidget {
  EditProduct({super.key});
  static String routerName = '/edit_product';
  final editProductController = Get.put(EditProductController());
  @override
  Widget build(BuildContext context) {
    final productId = Get.arguments?['productId']??null;
    editProductController.getProductById(productId);
    final _formKey = GlobalKey<FormBuilderState>();
    var isDesktop = context.width > 1000;
    return  Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Product',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Obx((){
            if(editProductController.isLoading.value){
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }else{
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isDesktop?context.width*0.2:30),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 16.0),
                              child: Text(
                                'Enter Product Name',
                                style: AppTextStyles.nomal.copyWith(
                                  fontSize: 14,
                                  color: AppColors.lightBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            initialValue: editProductController.productModel.value?.name??'',
                            onSaved: (value) {
                              editProductController.productName?.value = value!;
                            },
                            name: 'productName',
                            decoration: InputDecoration(
                                labelText: 'Product Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0),
                                ),
                                filled: true,
                                fillColor:
                                AppColors.grayMain,
                                hintText: 'Enter Product Name',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w400,
                                    color: AppColors.lightBlack.withOpacity(0.5))),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 16.0),
                                        child: Text(
                                          'Category',
                                          style: AppTextStyles.nomal.copyWith(
                                            fontSize: 14,
                                            color: AppColors.lightBlack,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Obx(()=>DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        hint: Text(
                                          'Select Category',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: editProductController.selectedCategory.value,
                                        items: editProductController.categories.map((category) => DropdownMenuItem<CategoryModel>(
                                          value: category,
                                          child: Text(category.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                        ).toList(),
                                        onChanged: (value) {
                                          // Do something when the selected category changes
                                          editProductController.selectedCategory.value = value;
                                          editProductController.loadSubCategories(editProductController.selectedCategory.value?.id);
                                          editProductController.selectedSubCategory.value = null;
                                          editProductController.isLoading.value = false;
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          decoration: BoxDecoration(
                                            color: AppColors.grayMain,
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          elevation: 0,
                                        ),
                                      ),
                                    ))
                                  ],
                                ),),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 16.0),
                                      child: Text(
                                        'Menu',
                                        style: AppTextStyles.nomal.copyWith(
                                          fontSize: 14,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Obx(() =>
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                            'Select Menu',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          value: editProductController.selectedSubCategory.value,
                                          items: editProductController.subCategories.map((category) => DropdownMenuItem<CategoryModel>(
                                            value: category,
                                            child: Text(category.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),),
                                          )).toList(),
                                          onChanged: (value) {
                                            // Do something when the selected category changes
                                            editProductController.selectedSubCategory.value = value;
                                            editProductController.isLoading.value = false;
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            decoration: BoxDecoration(
                                              color: AppColors.grayMain,
                                              borderRadius: BorderRadius.circular(24),
                                            ),
                                            elevation: 0,
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),),
                            ],
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 16.0),
                              child: Text(
                                'Description',
                                style: AppTextStyles.nomal.copyWith(
                                  fontSize: 14,
                                  color: AppColors.lightBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            initialValue: editProductController.productModel.value?.description??'',
                            maxLines: 3,
                            onSaved: (value) {
                              editProductController.description?.value = value!;
                            },
                            name: 'description',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              filled: true,
                              fillColor: AppColors.grayMain,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 16.0),
                                        child: Text(
                                          'Price',
                                          style: AppTextStyles.nomal.copyWith(
                                            fontSize: 14,
                                            color: AppColors.lightBlack,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FormBuilderTextField(
                                      initialValue: editProductController.productModel.value?.price.toString()??"",
                                      onSaved: (value) {
                                        editProductController.price?.value = double.parse(value!);
                                      },
                                      name: 'price',
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: BorderSide(
                                                color: Colors.transparent, width: 0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: BorderSide(
                                                color: Colors.transparent, width: 0),
                                          ),
                                          filled: true,
                                          fillColor:
                                          AppColors.grayMain,
                                          hintText: 'Enter Price',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w400,
                                              color: AppColors.lightBlack.withOpacity(0.5))),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.numeric(),
                                      ]),
                                    ),
                                  ],
                                ),),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 16.0),
                                      child: Text(
                                        'Quantity',
                                        style: AppTextStyles.nomal.copyWith(
                                          fontSize: 14,
                                          color: AppColors.lightBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  FormBuilderTextField(
                                    initialValue: editProductController.productModel.value?.quantity.toString()??"",
                                    onSaved: (value) {
                                      editProductController.quantity?.value = int.parse(value!);
                                    },
                                    name: 'quantity',
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(24),
                                          borderSide: BorderSide(
                                              color: Colors.transparent, width: 0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(24),
                                          borderSide: BorderSide(
                                              color: Colors.transparent, width: 0),
                                        ),
                                        filled: true,
                                        fillColor:
                                        AppColors.grayMain,
                                        hintText: 'Enter Quantity',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w400,
                                            color: AppColors.lightBlack.withOpacity(0.5))),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.numeric(),
                                    ]),
                                  ),
                                ],
                              ),),
                            ],
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Images',
                                style: AppTextStyles.nomal.copyWith(
                                  fontSize: 14,
                                  color: AppColors.lightBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(() {
                            if(editProductController.productModel.value!=null){
                              return GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                children: List.generate(editProductController.productModel.value!.images.length, (index) {
                                  String imageUrl = editProductController.productModel.value!.images[index];
                                  return AspectRatio(
                                    aspectRatio: 1.2,
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }),
                              )
                              ;
                            }
                            return Container();
                          }),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState != null && _formKey.currentState!.saveAndValidate()) {
                                    if(editProductController.selectedSubCategory.value !=null && editProductController.selectedCategory.value !=null){
                                      if(await editProductController.editProduct()){
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          displayDuration:
                                          Duration(milliseconds: 100),
                                          CustomSnackBar.success(
                                            message:
                                            "Product updated successfully",
                                          ),
                                        );
                                      }else{
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          displayDuration:
                                          Duration(milliseconds: 100),
                                          CustomSnackBar.error(
                                            message:
                                            "An error occurred, please try again later",
                                          ),
                                        );
                                      }
                                    }else{
                                      Get.defaultDialog(
                                        title: 'Notification',
                                        middleText: 'Please select category and menu!',
                                        textConfirm: 'Ok',
                                        onConfirm: (){
                                          Get.back();
                                        },
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'Update',
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          }),
        )
    );
  }
}