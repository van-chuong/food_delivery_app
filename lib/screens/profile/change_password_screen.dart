import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../config/helper/image_helper.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/profile_controller.dart';
import '../auth/home_screen.dart';

class ChangePasswordScreen extends GetView<ProfileController> {
   ChangePasswordScreen({Key? key}) : super(key: key);
   static String routerName = '/change_password_screen';
   final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    var isDesktop = context.width > 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
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
      body: profileController.firebaseUser != null?
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? context.width * 0.3 : 30),
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
                          'Enter Old Password',
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
                      obscureText: true,
                      onSaved: (value) {
                        profileController.oldPassword.value = value;
                      },
                      name: 'oldPassword',
                      decoration: InputDecoration(
                          labelText: 'Old Password',
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
                              Icons.lock_open_outlined),
                          filled: true,
                          fillColor:
                          AppColors.grayMain,
                          hintText: 'Enter Old Password',
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
                          'Create New Password',
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
                      obscureText: true,
                      onSaved: (value) {
                        profileController.newPassword.value = value;
                      },
                      name: 'newPass',
                      decoration: InputDecoration(
                          labelText: 'New Password',
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
                              Icons.lock_outline),
                          filled: true,
                          fillColor:
                          AppColors.grayMain,
                          hintText: 'Enter New Password',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w400,
                              color: AppColors.lightBlack.withOpacity(0.5))),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6)
                      ]),
                    ),
                    SizedBox(height: 20),
                    FormBuilderTextField(
                      obscureText: true,
                      onSaved: (value) {
                        profileController.reNewPassword.value = value;
                      },
                      name: 'reNewPassword',
                      decoration: InputDecoration(
                          labelText: 'Re-enter New Password',
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
                              Icons.lock_outline),
                          filled: true,
                          fillColor:
                          AppColors.grayMain,
                          hintText: 'Re-enter New Password',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w400,
                              color: AppColors.lightBlack.withOpacity(0.5)
                          )
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6)
                      ]),
                    ),
                    SizedBox(height: 20),
                    //SizedBox(height: 20),
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
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.saveAndValidate()) {
                              if(profileController.newPassword.value == profileController.reNewPassword.value){
                                Get.defaultDialog(
                                    title: 'Change Password',
                                    middleText: 'Are you sure want to change your password?',
                                    textConfirm: 'Ok',
                                    onConfirm: (){
                                      Get.back();
                                      profileController.changePassword(profileController.user.value?.email??'', profileController.oldPassword.value??'', profileController.newPassword.value??'');
                                    },
                                    textCancel: 'No',
                                  onCancel: () {
                                    Get.back();
                                  },
                                );
                              }else{
                                _formKey.currentState!.invalidateField(name: 'reNewPassword',errorText: "Re-enter Password not match");
                              }
                            }
                          },
                          child: Text(
                            'Change Password',
                          )
                      ),
                    ),
                    // Center(
                    //     child: Text(profileController.user?.displayName?? 'Your Full Name',style: AppTextStyles.h1.copyWith(color: Colors.black) )
                    // ),
                    // Center(
                    //   child: Text(profileController.user?.email?? 'Your Email',style: AppTextStyles.nomal.copyWith(color: Colors.black) ),
                    // ),
                    // SizedBox(height: 10,),

                  ],
                ),
              ),
            )
          ],
        ),
      )
          :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop?context.width*0.2:30),
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: isDesktop?context.width*0.1:context.width*0.4,
                    child: Image.asset(ImageHelper.imgError,),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You are not logged into your account !',
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
                      'Please login first to be able to view and change personal information.',
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
      ),
    );
  }
}
