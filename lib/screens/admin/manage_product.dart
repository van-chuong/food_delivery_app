import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/admin/product/add_product.dart';
import 'package:food_delivery_app/screens/admin/product/edit_product.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/product_manage_controller.dart';
class ManageProducts extends StatelessWidget {
   ManageProducts({Key? key}) : super(key: key);
  final productManageController = Get.put(ProductManageController());
  @override
  Widget build(BuildContext context) {
    final isDesktop = context.width > 1000;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AddProduct.routerName);
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Products Management',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,

      ),
        body: Obx(() {
          if (productManageController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          GridView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio:  isDesktop?4.5:1.8,
                            ),
                            children: [
                              Obx(()=>
                                  Container(
                                    // padding: EdgeInsets.symmetric(),
                                    decoration:
                                    BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(24)),
                                    child: InkWell(
                                      onTap: () {
                                        productManageController.finalProducts.value = productManageController.products;
                                      },
                                      child: Padding(
                                        padding: isDesktop
                                            ? EdgeInsets.all(20.0)
                                            : EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Total of Product",
                                                  style: AppTextStyles.h2.copyWith(
                                                    fontSize: isDesktop ? 18 : 12,
                                                  ),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(shape: BoxShape.circle),
                                                    child: Icon(Icons.shopping_bag_rounded, color: AppColors.white,
                                                    ))
                                              ],
                                            ),
                                            Text(
                                              productManageController.products.length.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.h2.copyWith(
                                                fontSize: isDesktop ? 20 : 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(),
                                decoration:
                                BoxDecoration(color: AppColors.blueMain, borderRadius: BorderRadius.circular(24)),
                                child: InkWell(
                                  onTap: () {
                                    productManageController.finalProducts.value = productManageController.outOfStockProducts;
                                  },
                                  child: Padding(
                                    padding: isDesktop
                                        ? EdgeInsets.all(20.0)
                                        : EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Out Of Stock",
                                              style: AppTextStyles.h2.copyWith(
                                                fontSize: isDesktop ? 18 : 12,
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                child: Icon(Icons.access_time_filled_rounded, color: AppColors.white,
                                                ))
                                          ],
                                        ),
                                        Text(
                                          productManageController.outOfStockProducts.length.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.h2.copyWith(
                                            fontSize: isDesktop ? 20 : 13,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          isDesktop?Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Obx(()=>DataTable(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              dataRowHeight: 120,
                              border: TableBorder.all(borderRadius: BorderRadius.circular(24),color: AppColors.grayMain),
                              columns: [
                                DataColumn(label: Text('Image')),
                                DataColumn(label: Text( 'Name')),
                                DataColumn(label: Text('Description')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Sales')),
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Created At')),
                                DataColumn(label: Text('Action')),
                              ],
                              rows: productManageController.finalProducts.map(
                                    (product) => DataRow(cells: [
                                  DataCell(
                                    Container(
                                      width: 120,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: ClipRRect( // Sử dụng ClipRRect để cắt bớt phần tràn ra
                                        borderRadius: BorderRadius.circular(24),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.network(
                                            product.images[0],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(product.name)),
                                  DataCell(Center(child: Text(product.description,maxLines: 3,),)),
                                  DataCell(Text("\$ ${product.price.toString()}")),
                                  DataCell(Text(product.sales.toString())),
                                  DataCell(Text(product.quantity.toString())),
                                  DataCell(Text(product.created_at)),
                                  DataCell(Center(child: Row(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.blueMain,
                                        ),
                                        onTap: () {
                                          Get.toNamed(EditProduct.routerName, arguments: {'productId': product.id});
                                        },
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Icon(
                                          Icons.highlight_remove_rounded,
                                          color: AppColors.red,
                                        ),
                                        onTap: () async {
                                          Get.defaultDialog(
                                            title: 'Notification',
                                            middleText: 'Are you sure want to remove product?',
                                            textConfirm: 'Ok',
                                            textCancel: 'No',
                                            onConfirm: () async {
                                              Get.back();
                                              if(await productManageController.removeProduct(product.id)){
                                                showTopSnackBar(
                                                  Overlay.of(context),
                                                  displayDuration:
                                                  Duration(milliseconds: 100),
                                                  CustomSnackBar.success(
                                                    message:
                                                    "Product removed successfully",
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
                                            },
                                            onCancel: (){Get.back();}
                                          );

                                        },
                                      ),

                                    ],
                                  ),)),
                                ]),
                              ).toList(),
                            )),
                          ):SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0),
                              child: Obx(()=>DataTable(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                dataRowHeight: 120,
                                border: TableBorder.all(borderRadius: BorderRadius.circular(24),color: AppColors.grayMain),
                                columns: [
                                  DataColumn(label: Text('Image')),
                                  DataColumn(label: Text( 'Name')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Sales')),
                                  DataColumn(label: Text('Quantity')),
                                  DataColumn(label: Text('Created At')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: productManageController.finalProducts.map(
                                      (product) => DataRow(cells: [
                                    DataCell(
                                      Container(
                                        width: 120,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: ClipRRect( // Sử dụng ClipRRect để cắt bớt phần tràn ra
                                          borderRadius: BorderRadius.circular(24),
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.network(
                                              product.images[0],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(product.name)),
                                    DataCell(Text("\$ ${product.price.toString()}")),
                                    DataCell(Text(product.sales.toString())),
                                    DataCell(Text(product.quantity.toString())),
                                    DataCell(Text(product.created_at)),
                                    DataCell(Center(child: Row(
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(24),
                                          child: Icon(
                                            Icons.edit_outlined,
                                            color: AppColors.blueMain,
                                          ),
                                          onTap: () {
                                            Get.toNamed(EditProduct.routerName, arguments: {'productId': product.id});
                                          },
                                        ),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(24),
                                          child: Icon(
                                            Icons.highlight_remove_rounded,
                                            color: AppColors.red,
                                          ),
                                          onTap: () async {
                                            Get.defaultDialog(
                                                title: 'Notification',
                                                middleText: 'Are you sure want to remove product?',
                                                textConfirm: 'Ok',
                                                textCancel: 'No',
                                                onConfirm: () async {
                                                  Get.back();
                                                  if(await productManageController.removeProduct(product.id)){
                                                    showTopSnackBar(
                                                      Overlay.of(context),
                                                      displayDuration:
                                                      Duration(milliseconds: 100),
                                                      CustomSnackBar.success(
                                                        message:
                                                        "Product removed successfully",
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
                                                },
                                                onCancel: (){Get.back();}
                                            );

                                          },
                                        ),

                                      ],
                                    ),)),
                                  ]),
                                ).toList(),
                              )),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            );
          }
        })
    );
  }
}
