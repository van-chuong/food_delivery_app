import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_delivery_app/config/helper/dialog_helper.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/order_detail_controller.dart';
import '../../widgets/page_not_found.dart';

class OrderDetail extends StatelessWidget  {
  OrderDetail({Key? key}) : super(key: key);

  static String routerName = '/order_detail';
  final OrderDetailController orderDetailController = Get.put(OrderDetailController());
  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments?['orderId']??null;
    var isDesktop = context.width > 1000;
    final _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Order',
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
      body: Obx((){
        if(orderDetailController.isLoading.value){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(orderDetailController.order == null){
            return PageNotFound(isDesktop: isDesktop);
          }else{
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:30),

                child: isDesktop
                    ?Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(left:20),
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
                                FormBuilderTextField(
                                  enabled: false,
                                  initialValue: orderDetailController.order?.recipient??'',
                                  onSaved: (value) {
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
                                ),
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
                                FormBuilderTextField(
                                  enabled: false,
                                  initialValue: orderDetailController.order?.phoneNo??'',
                                  onSaved: (value) {

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
                                ),
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
                                FormBuilderTextField(
                                  enabled: false,
                                  initialValue: orderDetailController.order?.address??'',
                                  onSaved: (value) {
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
                                ),
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
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          color: orderDetailController.order?.payment == 'Paypal'
                                              ? AppColors.blueMain
                                              : AppColors.grayMain,
                                        ),
                                        child: RadioListTile(
                                          title: Text('Pay by PayPal'),
                                          activeColor: AppColors.white,
                                          selected: orderDetailController.order?.payment == 'Paypal',
                                          value: 'Paypal',
                                          groupValue: orderDetailController.order?.payment,
                                          // onChanged: (String? value) {
                                          //   checkoutController.setPaymentMethod(value!);
                                          // },
                                          controlAffinity: ListTileControlAffinity.trailing,
                                          onChanged: (String? value) {  },
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1,child: SizedBox(),),
                                    Expanded(
                                      flex: 7,
                                      child:
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          color: orderDetailController.order?.payment == 'Cash'
                                              ? AppColors.primaryColor
                                              : AppColors.grayMain,
                                        ),
                                        child: RadioListTile(
                                          title: Text('Pay by Cash'),
                                          activeColor: AppColors.white,
                                          selected: orderDetailController.order?.payment == 'Cash',
                                          value: 'Cash',
                                          groupValue: orderDetailController.order?.payment,
                                          // onChanged: (String? value) {
                                          //   checkoutController.setPaymentMethod(value!);
                                          // },
                                          controlAffinity: ListTileControlAffinity.trailing,
                                          onChanged: (String? value) {  },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                        child: orderDetailController.canceled.value
                                            ?Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Container(
                                            height: 50,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  final id = orderDetailController.order?.orderid??null;
                                                  if(orderDetailController.order?.cancelRequest == true ){
                                                    showTopSnackBar(
                                                      Overlay.of(context),
                                                      displayDuration: Duration(milliseconds: 100),
                                                      const CustomSnackBar.error(
                                                        message:
                                                        "You have already submitted a request",
                                                      ),
                                                    );
                                                  }else{
                                                    Get.defaultDialog(
                                                        title: 'Status',
                                                        middleText: 'Are you sure want to submit a cancellation request?',
                                                        textConfirm: 'Ok',
                                                        onConfirm: () async {
                                                          Get.back();
                                                          if(await orderDetailController.sendRequestCancel(id)){
                                                            showTopSnackBar(
                                                              Overlay.of(context),
                                                              displayDuration: Duration(milliseconds: 100),
                                                              const CustomSnackBar.success(
                                                                message: "Submit successfully, waiting for approval",
                                                              ),
                                                            );
                                                          }else{
                                                            showTopSnackBar(
                                                              Overlay.of(context),
                                                              displayDuration: Duration(milliseconds: 100),
                                                              const CustomSnackBar.error(
                                                                message: "An error occurred, please try again later",
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        textCancel: 'No',
                                                        onCancel: () {}
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  'Request Cancel Order',
                                                  style: AppTextStyles.h1.copyWith(fontSize: 20),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(24)
                                                  ),
                                                  backgroundColor: AppColors.error,
                                                  elevation: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                            :Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: SizedBox(
                                          ),
                                        )

                                    ),
                                  ],)

                              ],
                            ),
                          ),
                        ),),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children: [
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
                              Row(
                                children: [
                                  Expanded(
                                    child: DataTable(
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
                                        orderDetailController.order?.items.length??0,
                                            (index) => DataRow(
                                          cells: [
                                            DataCell(Text(orderDetailController.order?.items[index].name??"")),
                                            DataCell(Text("\$"+(orderDetailController.order?.items[index].price).toString())),
                                            DataCell(Text((orderDetailController.order?.items[index].quantity).toString())),
                                            DataCell(Text("\$"+((orderDetailController.order?.items[index].quantity??0)*(orderDetailController.order?.items[index].price??0)).toStringAsFixed(2))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ))
                      ],
                    )
                    :FormBuilder(
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
                      FormBuilderTextField(
                        enabled: false,
                        initialValue: orderDetailController.order?.recipient??'',
                        onSaved: (value) {
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
                      ),
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
                      FormBuilderTextField(
                        enabled: false,
                        initialValue: orderDetailController.order?.phoneNo??'',
                        onSaved: (value) {

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
                      ),
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
                      FormBuilderTextField(
                        enabled: false,
                        initialValue: orderDetailController.order?.address??'',
                        onSaved: (value) {
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
                      ),
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
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: orderDetailController.order?.payment == 'Paypal'
                                    ? AppColors.blueMain
                                    : AppColors.grayMain,
                              ),
                              child: RadioListTile(
                                title: Text('Pay by PayPal'),
                                activeColor: AppColors.white,
                                selected: orderDetailController.order?.payment == 'Paypal',
                                value: 'Paypal',
                                groupValue: orderDetailController.order?.payment,
                                // onChanged: (String? value) {
                                //   checkoutController.setPaymentMethod(value!);
                                // },
                                controlAffinity: ListTileControlAffinity.trailing,
                                onChanged: (String? value) {  },
                              ),
                            ),
                          ),
                          Expanded(flex: 1,child: SizedBox(),),
                          Expanded(
                            flex: 7,
                            child:
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: orderDetailController.order?.payment == 'Cash'
                                    ? AppColors.primaryColor
                                    : AppColors.grayMain,
                              ),
                              child: RadioListTile(
                                title: Text('Pay by Cash'),
                                activeColor: AppColors.white,
                                selected: orderDetailController.order?.payment == 'Cash',
                                value: 'Cash',
                                groupValue: orderDetailController.order?.payment,
                                // onChanged: (String? value) {
                                //   checkoutController.setPaymentMethod(value!);
                                // },
                                controlAffinity: ListTileControlAffinity.trailing,
                                onChanged: (String? value) {  },
                              ),
                            ),
                          ),
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

                      SizedBox(height: 20),
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
                            orderDetailController.order?.items.length??0,
                                (index) => DataRow(
                              cells: [
                                DataCell(Text(orderDetailController.order?.items[index].name??"")),
                                DataCell(Text("\$"+(orderDetailController.order?.items[index].price).toString())),
                                DataCell(Text((orderDetailController.order?.items[index].quantity).toString())),
                                DataCell(Text("\$"+((orderDetailController.order?.items[index].quantity??0)*(orderDetailController.order?.items[index].price??0)).toStringAsFixed(2))),
                              ],
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: orderDetailController.canceled.value
                                  ?Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  height: 50,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final id = orderDetailController.order?.orderid??null;
                                        if(orderDetailController.order?.cancelRequest == true ){
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            displayDuration: Duration(milliseconds: 100),
                                            const CustomSnackBar.error(
                                              message:
                                              "You have already submitted a request",
                                            ),
                                          );
                                        }else{
                                          Get.defaultDialog(
                                              title: 'Status',
                                              middleText: 'Are you sure want to submit a cancellation request?',
                                              textConfirm: 'Ok',
                                              onConfirm: () async {
                                                Get.back();
                                                if(await orderDetailController.sendRequestCancel(id)){
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    displayDuration: Duration(milliseconds: 100),
                                                    const CustomSnackBar.success(
                                                      message: "Submit successfully, waiting for approval",
                                                    ),
                                                  );
                                                }else{
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    displayDuration: Duration(milliseconds: 100),
                                                    const CustomSnackBar.error(
                                                      message: "An error occurred, please try again later",
                                                    ),
                                                  );
                                                }
                                              },
                                              textCancel: 'No',
                                              onCancel: () {}
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Request Cancel Order',
                                        style: AppTextStyles.h1.copyWith(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24)
                                        ),
                                        backgroundColor: AppColors.error,
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  :Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: SizedBox(
                                ),
                              )
                          ),
                        ],)
                    ],
                  ),
                ),
              ),
            );
          }
        }
      })
    );
  }
}
