import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_delivery_app/config/helper/dialog_helper.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controllers/edit_order_controller.dart';

class EditOrder extends StatelessWidget  {
  EditOrder({Key? key}) : super(key: key);

  static String routerName = '/edit_order';
  final  editOrderController = Get.put(EditOrderController());
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
          if(editOrderController.isLoading.value){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:30),
                child: isDesktop ?FormBuilder(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left:20),
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
                              initialValue: editOrderController.order?.recipient??'',
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
                              initialValue: editOrderController.order?.phoneNo??'',
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
                              initialValue: editOrderController.order?.address??'',
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
                                      color: editOrderController.order?.payment == 'Paypal'
                                          ? AppColors.blueMain
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Pay by PayPal'),
                                      activeColor: AppColors.white,
                                      selected: editOrderController.order?.payment == 'Paypal',
                                      value: 'Paypal',
                                      groupValue: editOrderController.order?.payment,
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
                                      color: editOrderController.order?.payment == 'Cash'
                                          ? AppColors.primaryColor
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Pay by Cash'),
                                      activeColor: AppColors.white,
                                      selected: editOrderController.order?.payment == 'Cash',
                                      value: 'Cash',
                                      groupValue: editOrderController.order?.payment,
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
                          ],
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
                                      editOrderController.order?.items.length??0,
                                          (index) => DataRow(
                                        cells: [
                                          DataCell(Text(editOrderController.order?.items[index].name??"")),
                                          DataCell(Text("\$"+(editOrderController.order?.items[index].price).toString())),
                                          DataCell(Text((editOrderController.order?.items[index].quantity).toString())),
                                          DataCell(Text("\$"+((editOrderController.order?.items[index].quantity??0)*(editOrderController.order?.items[index].price??0)).toStringAsFixed(2))),
                                        ],
                                      ),
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
                                  'Status',
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
                                  child: Obx(
                                    ()=>Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: editOrderController.status.value == 'Completed'
                                            ? AppColors.primaryColor
                                            : AppColors.grayMain,
                                      ),
                                      child: RadioListTile(
                                        title: Text('Completed'),
                                        activeColor: AppColors.white,
                                        selected: editOrderController.status.value == 'Completed',
                                        value: 'Completed',
                                        groupValue: editOrderController.status.value,
                                        // onChanged: (String? value) {
                                        //   checkoutController.setPaymentMethod(value!);
                                        // },
                                        controlAffinity: ListTileControlAffinity.trailing,
                                        onChanged: (String? value) {
                                          editOrderController.setStatus(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1,child: SizedBox(),),
                                Expanded(
                                  flex: 7,
                                  child:
                                  Obx(()=>Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: editOrderController.status.value == 'Pending'
                                          ? AppColors.yellow
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Pending'),
                                      activeColor: AppColors.white,
                                      selected: editOrderController.status.value == 'Pending',
                                      value: 'Pending',
                                      groupValue: editOrderController.status.value,
                                      onChanged: (String? value) {
                                        editOrderController.setStatus(value!);
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                    ),
                                  ),)
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Obx(()=>Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: editOrderController.status.value == 'Paid'
                                          ? AppColors.blueMain
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Paid'),
                                      activeColor: AppColors.white,
                                      selected: editOrderController.status.value == 'Paid',
                                      value: 'Paid',
                                      groupValue: editOrderController.status.value,
                                      // onChanged: (String? value) {
                                      //   checkoutController.setPaymentMethod(value!);
                                      // },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      onChanged: (String? value) {
                                        editOrderController.setStatus(value!);
                                      },
                                    ),
                                  )),
                                ),
                                Expanded(flex: 1,child: SizedBox(),),
                                Expanded(
                                  flex: 7,
                                  child:
                                  Obx(()=>Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: editOrderController.status.value == 'Canceled'
                                          ? AppColors.red
                                          : AppColors.grayMain,
                                    ),
                                    child: RadioListTile(
                                      title: Text('Canceled'),
                                      activeColor: AppColors.white,
                                      selected: editOrderController.status.value == 'Canceled',
                                      value: 'Canceled',
                                      groupValue: editOrderController.status.value,
                                      // onChanged: (String? value) {
                                      //   checkoutController.setPaymentMethod(value!);
                                      // },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      onChanged: (String? value) {
                                        editOrderController.setStatus(value!);
                                      },
                                    ),
                                  ),)
                                ),
                              ],
                            ),
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
                                  if(await editOrderController.updateOrder()){
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      displayDuration:
                                      Duration(milliseconds: 100),
                                      CustomSnackBar.success(
                                        message:
                                        "Order updated successfully",
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
                                  child: Text(
                                    'Update',
                                  )
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ))
                    ],
                  ),
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
                        initialValue: editOrderController.order?.recipient??'',
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
                            prefixIcon: const Icon(
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
                        initialValue: editOrderController.order?.phoneNo??'',
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
                        initialValue: editOrderController.order?.address??'',
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
                                color: editOrderController.order?.payment == 'Paypal'
                                    ? AppColors.blueMain
                                    : AppColors.grayMain,
                              ),
                              child: RadioListTile(
                                title: Text('Pay by PayPal'),
                                activeColor: AppColors.white,
                                selected: editOrderController.order?.payment == 'Paypal',
                                value: 'Paypal',
                                groupValue: editOrderController.order?.payment,
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
                                color: editOrderController.order?.payment == 'Cash'
                                    ? AppColors.primaryColor
                                    : AppColors.grayMain,
                              ),
                              child: RadioListTile(
                                title: Text('Pay by Cash'),
                                activeColor: AppColors.white,
                                selected: editOrderController.order?.payment == 'Cash',
                                value: 'Cash',
                                groupValue: editOrderController.order?.payment,
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
                            editOrderController.order?.items.length??0,
                                (index) => DataRow(
                              cells: [
                                DataCell(Text(editOrderController.order?.items[index].name??"")),
                                DataCell(Text("\$"+(editOrderController.order?.items[index].price).toString())),
                                DataCell(Text((editOrderController.order?.items[index].quantity).toString())),
                                DataCell(Text("\$"+((editOrderController.order?.items[index].quantity??0)*(editOrderController.order?.items[index].price??0)).toStringAsFixed(2))),
                              ],
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(
                              left: 16.0),
                          child: Text(
                            'Status',
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
                            child: Obx(
                                  ()=>Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: editOrderController.status.value == 'Completed'
                                      ? AppColors.primaryColor
                                      : AppColors.grayMain,
                                ),
                                child: RadioListTile(
                                  title: Text('Completed'),
                                  activeColor: AppColors.white,
                                  selected: editOrderController.status.value == 'Completed',
                                  value: 'Completed',
                                  groupValue: editOrderController.status.value,
                                  // onChanged: (String? value) {
                                  //   checkoutController.setPaymentMethod(value!);
                                  // },
                                  controlAffinity: ListTileControlAffinity.trailing,
                                  onChanged: (String? value) {
                                    editOrderController.setStatus(value!);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(flex: 1,child: SizedBox(),),
                          Expanded(
                              flex: 7,
                              child:
                              Obx(()=>Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: editOrderController.status.value == 'Pending'
                                      ? AppColors.yellow
                                      : AppColors.grayMain,
                                ),
                                child: RadioListTile(
                                  title: Text('Pending'),
                                  activeColor: AppColors.white,
                                  selected: editOrderController.status.value == 'Pending',
                                  value: 'Pending',
                                  groupValue: editOrderController.status.value,
                                  onChanged: (String? value) {
                                    editOrderController.setStatus(value!);
                                  },
                                  controlAffinity: ListTileControlAffinity.trailing,
                                ),
                              ),)
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Obx(()=>Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: editOrderController.status.value == 'Paid'
                                    ? AppColors.blueMain
                                    : AppColors.grayMain,
                              ),
                              child: RadioListTile(
                                title: Text('Paid'),
                                activeColor: AppColors.white,
                                selected: editOrderController.status.value == 'Paid',
                                value: 'Paid',
                                groupValue: editOrderController.status.value,
                                // onChanged: (String? value) {
                                //   checkoutController.setPaymentMethod(value!);
                                // },
                                controlAffinity: ListTileControlAffinity.trailing,
                                onChanged: (String? value) {
                                  editOrderController.setStatus(value!);
                                },
                              ),
                            )),
                          ),
                          Expanded(flex: 1,child: SizedBox(),),
                          Expanded(
                              flex: 7,
                              child:
                              Obx(()=>Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: editOrderController.status.value == 'Canceled'
                                      ? AppColors.red
                                      : AppColors.grayMain,
                                ),
                                child: RadioListTile(
                                  title: Text('Canceled'),
                                  activeColor: AppColors.white,
                                  selected: editOrderController.status.value == 'Canceled',
                                  value: 'Canceled',
                                  groupValue: editOrderController.status.value,
                                  // onChanged: (String? value) {
                                  //   checkoutController.setPaymentMethod(value!);
                                  // },
                                  controlAffinity: ListTileControlAffinity.trailing,
                                  onChanged: (String? value) {
                                    editOrderController.setStatus(value!);
                                  },
                                ),
                              ),)
                          ),
                        ],
                      ),
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
                              if(await editOrderController.updateOrder()){
                                showTopSnackBar(
                                  Overlay.of(context),
                                  displayDuration:
                                  Duration(milliseconds: 100),
                                  CustomSnackBar.success(
                                    message:
                                    "Order updated successfully",
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
                            child: Text(
                              'Update',
                            )
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        })
    );
  }
}
