import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/admin/order/edit_order.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../config/helper/color_helper.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/order_manage_controller.dart';

class ManageOrder extends StatelessWidget {
   ManageOrder({Key? key}) : super(key: key);
  final managerOrderController = Get.put(OrderManageController());
  @override
  Widget build(BuildContext context) {
    final isDesktop = context.width > 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders Management',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx((){
        if (managerOrderController.isLoading.value) {
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
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 4 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: isDesktop ? 2 : 1.8,
                    ),
                    children: [
                      Obx(
                            () => InkWell(
                              onTap: (){
                                managerOrderController.finalOrders.value = managerOrderController.orders;
                              },
                              child: analytic_card(
                              title: 'All of Orders',
                              data: managerOrderController.orders.length.toString(),
                              icon: Icons.monetization_on_outlined,
                              color: AppColors.darkBlue,
                              isDesktop: isDesktop),
                            ),
                      ),
                      InkWell(
                        onTap: (){
                          managerOrderController.finalOrders.value = managerOrderController.requestOrders;
                        },
                        child: analytic_card(
                            title: 'Cancel Request ',
                            data: managerOrderController.requestOrders.length.toString(),
                            icon: Icons.shopping_bag_rounded,
                            color: AppColors.error,
                            isDesktop: isDesktop),
                      ),
                      InkWell(
                        onTap: (){
                          managerOrderController.finalOrders.value = managerOrderController.completedOrders;
                        },
                        child: analytic_card(
                            title: 'Completed Orders',
                            data: managerOrderController.completedOrders.length.toString(),
                            icon: Icons.shopping_cart_rounded,
                            color: AppColors.primaryColor,
                            isDesktop: isDesktop),
                      ),
                      InkWell(
                        onTap: () {
                          managerOrderController.finalOrders.value = managerOrderController.pendingOrders;
                        },
                        child: analytic_card(
                          title: 'Pending Orders',
                          data: managerOrderController.pendingOrders.length.toString(),
                          icon: Icons.account_circle_outlined,
                          color: AppColors.yellow,
                          isDesktop: isDesktop,
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Obx(()=>DataTable(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24)
                      ),
                      dataRowHeight: 120,
                      border: TableBorder.all(borderRadius: BorderRadius.circular(24),color: AppColors.grayMain),
                      columns: [
                        DataColumn(label: Text('Recipient')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text( 'Order Day')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Payment')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: managerOrderController.finalOrders.value.map((order) =>
                                DataRow(cells: [
                                  DataCell(Text(order.recipient)),
                                  DataCell(Text(order.address)),
                                  DataCell(Text(order.orderDay)),
                                  DataCell(Center(child: Text(order.items.length.toString()),)),
                                  DataCell(ColorHelper.paymentColor(order.payment)),
                                  DataCell(ColorHelper.statusColor(order.status)),
                                  DataCell(Center(child: Row(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.blueMain,
                                        ),
                                        onTap: () {
                                          Get.toNamed(EditOrder.routerName, arguments: {'orderId': order.orderid});
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
                                              middleText: 'Are you sure want to remove order?',
                                              textConfirm: 'Ok',
                                              textCancel: 'No',
                                              onConfirm: () async {
                                                Get.back();
                                                if(await managerOrderController.removeOrder(order.orderid)){
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    displayDuration:
                                                    Duration(milliseconds: 100),
                                                    CustomSnackBar.success(
                                                      message:
                                                      "Order removed successfully",
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
            ),
          );
        }
      }),
    );
  }
}
class analytic_card extends StatelessWidget {
  analytic_card({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
    required this.color,
    required this.isDesktop,
  });

  final String title;
  final String data;
  final IconData icon;
  final Color color;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(),
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
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
                  data.toString(),
                  style: AppTextStyles.h2.copyWith(
                    fontSize: isDesktop ? 18 : 12,
                  ),
                ),
                Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(
                      icon,
                      color: AppColors.white,
                    ))
              ],
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h2.copyWith(
                fontSize: isDesktop ? 20 : 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
