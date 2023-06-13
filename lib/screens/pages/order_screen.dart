import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/helper/color_helper.dart';
import '../../config/helper/image_helper.dart';
import '../../config/themes/app_colors.dart';
import '../../controllers/order_controller.dart';
import '../auth/home_screen.dart';
import '../main_screen.dart';
import '../order/order_detail.dart';

class OrderScreen extends GetView<OrderController> {
  static String routerName = '/order_screen';
  final orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Order List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: orderController.firebaseUser!=null
          ?Obx(() {
            if(orderController.isLoading.value){
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }else{
              if(orderController.orders.isEmpty){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isDesktop?context.width*0.2:30),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: isDesktop?context.width*0.1:context.width*0.4,
                              child: Image.asset(ImageHelper.imgEmptyBox,),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Your order list is empty!',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondGray
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Explore the dish and order now to display the order list here.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondGray
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: isDesktop?context.width*0.3:double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24)
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Get.toNamed(MainScreen.routerName);
                                  },
                                  child:Text(
                                    'Discover Now',
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              }else{
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                            child: DataTable(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              border: TableBorder.all(borderRadius: BorderRadius.circular(24),color: AppColors.grayMain),
                              columns: [
                                DataColumn(label: Text('Recipient Name')),
                                DataColumn(label: Text('Order day')),
                                DataColumn(label: Text('Items')),
                                DataColumn(label: Text('Payment')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('View detail')),
                              ],
                              rows: orderController.orders.map(
                                    (order) => DataRow(cells: [
                                      DataCell(Text(order.recipient)),
                                      DataCell(Text(order.orderDay)),
                                      DataCell(Center(child: Text(order.items.length.toString()),)),
                                      DataCell(ColorHelper.paymentColor(order.payment)),
                                      DataCell(ColorHelper.statusColor(order.status)),
                                      DataCell(Center(child: InkWell(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: AppColors.blueMain,
                                        ),
                                        onTap: () {
                                          Get.toNamed(OrderDetail.routerName, arguments: {
                                            'orderId': order.orderid,
                                            'status': order.status,
                                          }
                                          );
                                        },
                                      ),)),
                                ]),
                              ).toList(),
                              ),
                          ),
                          ),
                      ),
                    ],
                  ),
                );
              }
            }
        })
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop?context.width*0.2:30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: isDesktop?context.width*0.1:context.width*0.4,
                  child: Image.asset(ImageHelper.imgError,),
                ),
                const SizedBox(height: 16),
                Text(
                  'You are not logged into your account!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondGray
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Explore the dish and order now to display the order list here.',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondGray
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: isDesktop?context.width*0.3:double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                        ),
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Get.toNamed(HomeScreen.routerName);
                      },
                      child:Text(
                        'Get Started Now',
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )
    );
  }
}
