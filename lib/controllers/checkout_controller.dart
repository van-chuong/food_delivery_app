import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:food_delivery_app/config/helper/random_string_helper.dart';
import 'package:food_delivery_app/models/CartItemModel.dart';
import 'package:food_delivery_app/screens/cart/check_out_status.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/helper/dialog_helper.dart';
import '../config/key/braintree_key.dart';
import '../config/key/paypal_key.dart';
import '../models/OrderModel.dart';
import '../models/UserModel.dart';
import '../services/firebase_service.dart';
import '../services/store_service.dart';

class CheckoutController extends GetxController {
  final StoreService _storeService = StoreService();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseService _firebaseService = FirebaseService();
  var cartItems = <CartItemModel>[];
  var totalPrice;
  var paymentMethod = ''.obs;
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);
  Rx<String> fullName = ''.obs;
  Rx<String> phoneNo = ''.obs;
  Rx<String> address = ''.obs;
  RxBool paypalStatus = false.obs;
  final orderDay = DateFormat('yyyy/MM/dd').format(DateTime.now());
  Timer? timer;
  void setPaymentMethod(String value) {
    paymentMethod.value = value;
  }

  @override
  Future<void> onInit() async {
    try {
      if(user!=null){
        userInfo.value = await loadUser(user?.uid);
      }
    } catch (error) {
      print('Error loading user data: $error');
    }
  }
  loadUser(String? uid) async {
    return await _firebaseService.getUserById(uid);
  }
  payment(String total, List<CartItemModel> items) async {
    switch (paymentMethod.value) {
      case 'Paypal':
        {
          DialogHelper.showLoading('Processing');
          List<Map<String, dynamic>> itemList = [];
          for (var item in items) {
            Map<String, dynamic> itemMap = {
              "name": item.name,
              "quantity": item.quantity,
              "price": item.price.toStringAsFixed(2),
              "currency": 'USD',
            };
            itemList.add(itemMap);
          }
          Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) => UsePaypal(
                    sandboxMode: true,
                    clientId: PaypalKey.clientId,
                    secretKey: PaypalKey.secretKey,
                    returnURL: PaypalKey.returnURL,
                    cancelURL: PaypalKey.cancelURL,
                    transactions: [
                      {
                        "amount": {
                          "total": total,
                          "currency": "USD",
                          "details": {
                            "subtotal": total,
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        "item_list": {"items": itemList}
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params)  {

                      final orderid = RandomStringHelper.generateRandomString(20);
                      try {
                        addOrder(
                            OrderModel(
                                items: cartItems,
                                orderid: orderid,
                                uid: user!.uid,
                                recipient: fullName.value,
                                phoneNo: phoneNo.value,
                                address: address.value,
                                payment: paymentMethod.value,
                                status: 'Paid',
                                total: total,
                                orderDay: orderDay,
                                cancelRequest: false
                            ), orderid);
                      } catch (e) {
                      }
                      paypalStatus.value = true;
                      print("onSuccess: $params");
                    },
                    onError: (error) {
                      print("onError: $error");
                    },
                    onCancel: (params) {
                      print('cancelled: $params');
                    }),
              )
          );
           timer = Timer.periodic(Duration(seconds: 2), (timer) {
            // Kiểm tra giá trị của biến status
            if (paypalStatus.value) {
              timer.cancel();
              Get.offAll(CheckOutStatus(status: true,));
            }
          });
        }
        break;
      case 'Cash':
        {
          DialogHelper.showLoading('Processing');
          final orderid = RandomStringHelper.generateRandomString(20);
          try {
            addOrder(OrderModel(
                    items: cartItems,
                    orderid: orderid,
                    uid: user!.uid,
                    recipient: fullName.value,
                    phoneNo: phoneNo.value,
                    address: address.value,
                    payment: paymentMethod.value,
                    status: 'Pending',
                    total: total,
                    orderDay: orderDay,
                    cancelRequest: false),
                orderid);
            await  Future.delayed(Duration(seconds: 2));
            DialogHelper.hideLoading();
            Get.offAll(CheckOutStatus(status: true,));
          } catch (e) {
            await  Future.delayed(Duration(seconds: 2));
            DialogHelper.hideLoading();
            Get.offAll(CheckOutStatus(status: false,));
          }
          break;
        }
    }
  }

  @override
  void onClose() {
    timer?.cancel();
  }

  void addOrder(OrderModel order, String orderid) async {
    await _storeService.addOrder(order, orderid);
  }
}
