import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_delivery_app/models/CartItemModel.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/checkout_controller.dart';
import '../../widgets/page_not_found.dart';

class ConfirmOrderScreen extends GetView<CheckoutController> {
  ConfirmOrderScreen({super.key});

  final checkoutController = Get.put(CheckoutController());
  static String routerName = '/confirm_order_screen';

  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    final totalPrice = Get.arguments?['totalPrice']??null;
    final cartItems = Get.arguments?['cartItems'] ??null;
    if(totalPrice !=null && cartItems!=null){
      checkoutController.cartItems = cartItems as List<CartItemModel>;
      checkoutController.totalPrice = totalPrice;
    }
    final _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm Order',
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
      body: totalPrice !=null && cartItems!=null
          ?Stack(
            children: [
              OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: double.infinity,
                child:Container(
                  height: context.height - 220, // 100 is the height of bottom container
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isDesktop?200:30),
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
                                    'Name Of Recipient',
                                    style: AppTextStyles.nomal.copyWith(
                                      fontSize: 14,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Obx(() => FormBuilderTextField(
                                initialValue: checkoutController.userInfo.value?.fullName??'',
                                onSaved: (value) {
                                  checkoutController.fullName.value= value!;
                                },
                                name: 'name',
                                decoration: InputDecoration(
                                    labelText: 'Name of recipient',
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
                                    prefixIcon: Icon(
                                        Icons.person_outline),
                                    filled: true,
                                    fillColor:
                                    AppColors.grayMain,
                                    hintText: 'Enter Name of recipient',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w400,
                                        color: AppColors.lightBlack.withOpacity(0.5))),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              )),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 16.0),
                                  child: Text(
                                    'Phone Number',
                                    style: AppTextStyles.nomal.copyWith(
                                      fontSize: 14,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Obx(() => FormBuilderTextField(
                                initialValue: checkoutController.userInfo.value?.phoneNo??'',
                                onSaved: (value) {
                                  checkoutController.phoneNo.value= value!;
                                },
                                name: 'phoneNo',
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
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
                                    prefixIcon: Icon(
                                        Icons.phone_outlined),
                                    filled: true,
                                    fillColor:
                                    AppColors.grayMain,
                                    hintText: 'Enter Phone Number',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w400,
                                        color: AppColors.lightBlack.withOpacity(0.5))),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  FormBuilderValidators.maxLength(11),
                                  FormBuilderValidators.minLength(10),
                                ]),
                              ),),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 16.0),
                                  child: Text(
                                    'Address',
                                    style: AppTextStyles.nomal.copyWith(
                                      fontSize: 14,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Obx(() => FormBuilderTextField(
                                initialValue: checkoutController.userInfo.value?.address??'',
                                onSaved: (value) {
                                  checkoutController.address.value= value!;
                                },
                                name: 'address',
                                decoration: InputDecoration(
                                    labelText: 'Address',
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
                                    prefixIcon: Icon(
                                        Icons.home_outlined),
                                    filled: true,
                                    fillColor:
                                    AppColors.grayMain,
                                    hintText: 'Enter Address',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w400,
                                        color: AppColors.lightBlack.withOpacity(0.5))),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              )),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 16.0),
                                  child: Text(
                                    'Payment Method',
                                    style: AppTextStyles.nomal.copyWith(
                                      fontSize: 14,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child:
                                  Obx(() => Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: checkoutController.paymentMethod.value == 'Paypal'
                                          ? AppColors.blueMain
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Pay by PayPal'),
                                      activeColor: AppColors.white,
                                      selected: checkoutController.paymentMethod.value == 'Paypal',
                                      value: 'Paypal',
                                      groupValue: checkoutController.paymentMethod.value,
                                      onChanged: (String? value) {
                                        checkoutController.setPaymentMethod(value!);
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                    ),
                                  )),),
                                  Expanded(flex: 1,child: SizedBox(),),
                                  Expanded(
                                    flex: 7,
                                    child: Obx(() => Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: checkoutController.paymentMethod.value == 'Cash'
                                          ? AppColors.primaryColor
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Pay by Cash'),
                                      value: 'Cash',
                                      activeColor: AppColors.white,
                                      selected: checkoutController.paymentMethod.value == 'Cash',
                                      groupValue: checkoutController.paymentMethod.value,
                                      onChanged: (String?  value) {
                                        checkoutController.setPaymentMethod(value!);
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                    ),
                                  )),)
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 16.0),
                                  child: Text(
                                    'Products',
                                    style: AppTextStyles.nomal.copyWith(
                                      fontSize: 14,
                                      color: AppColors.lightBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FittedBox(child: DataTable(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24)
                                  ),
                                  border: TableBorder.all(borderRadius: BorderRadius.circular(24),color: AppColors.grayMain),
                                  columns: [
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Price')),
                                    DataColumn(label: Text('Quantity')),
                                    DataColumn(label: Text('Subtotal')),
                                  ],
                                  rows: List<DataRow>.generate(
                                    cartItems.length,
                                        (index) => DataRow(
                                      cells: [
                                        DataCell(Text(cartItems[index].name)),
                                        DataCell(Text("\$"+cartItems[index].price.toString())),
                                        DataCell(Text(cartItems[index].quantity.toString())),
                                        DataCell(Text("\$"+(cartItems[index].quantity*cartItems[index].price).toStringAsFixed(2))),
                                      ],
                                    ),
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: context.width,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(isDesktop?200:30,10,isDesktop?200:30,10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Shipping Fee: ',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text('Free',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.red
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Total To Pay: ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('\$'+totalPrice.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.red
                                )
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState != null && _formKey.currentState!.saveAndValidate()) {
                                    if(checkoutController.paymentMethod.value ==''){
                                      Get.defaultDialog(
                                        title: 'Notification',
                                        middleText: 'Please choose a payment method!',
                                        textConfirm: 'Ok',
                                        onConfirm: (){
                                          Get.back();
                                        },
                                      );
                                    }else{
                                      if(kIsWeb && checkoutController.paymentMethod.value == 'Paypal'){
                                        Get.defaultDialog(
                                          title: 'Notification',
                                          middleText: 'Payment method does not support on the web platform, please select another Payment Method!',
                                          textConfirm: 'Ok',
                                          onConfirm: (){
                                            Get.back();
                                          },
                                        );
                                      }else {
                                        checkoutController.payment(totalPrice.toStringAsFixed(2),cartItems as List<CartItemModel>);
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  'Check Out',
                                  style: AppTextStyles.h1.copyWith(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
          :PageNotFound(isDesktop: isDesktop),
    );
  }
}


