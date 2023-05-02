import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static String routerName = '/order_screen';
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Scaffold(
        body: Column(
          children: [
            Center(child: Text('OrderPage'),),
          ],
        ),
      ),
    );
  }
}
