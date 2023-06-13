import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_delivery_app/controllers/profile_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../../config/helper/dialog_helper.dart';
import '../../config/helper/image_helper.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../auth/home_screen.dart';

class MyProfileScreen extends GetView<ProfileController> {
  MyProfileScreen({Key? key}) : super(key: key);
  static String routerName = '/my_profile_screen';
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    var isDesktop = context.width > 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
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
      body: profileController.firebaseUser != null ?
      SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children:[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30,0,15),
                  child: Center(
                      child: Obx(()=>CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profileController.photoUrl.value ?? ImageHelper.imgAvatarNet)
                      ))
                  ),
                ),
                Align(
                  child: TextButton(
                    onPressed: (){
                      profileController.pickGalleryImage(context);
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.edit_outlined,size: 16,color: AppColors.white,),
                    ),
                  ),
                )
              ]
            ),
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
                          'Full Name',
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
                      onSaved: (value) {
                        profileController.fullName.value = value;
                      },
                      initialValue: profileController.user.value?.fullName ?? '',
                      name: 'fullName',
                      decoration: InputDecoration(
                          labelText: 'Full Name',
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
                          hintText: 'Enter Full Name',
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
                      initialValue: profileController.user.value?.phoneNo ?? '',
                      onSaved: (value) {
                        profileController.phoneNo.value = value;
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
                      onSaved: (value) {
                        profileController.address.value = value;
                      },
                      initialValue: profileController.user.value?.address ?? '',
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
                                      'Gender',
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
                                          'Select Gender',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme
                                                .of(context)
                                                .hintColor,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          profileController.selectedGender
                                              .value = value as String;
                                        },
                                        value: profileController.selectedGender
                                            .value,
                                        items: profileController.genders.map((
                                            gender) =>
                                            DropdownMenuItem<String>(
                                              value: gender,
                                              child: Text(
                                                gender,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                        ).toList(),
                                        buttonStyleData: ButtonStyleData(
                                          decoration: BoxDecoration(
                                            color: AppColors.grayMain,
                                            borderRadius: BorderRadius.circular(
                                                24),
                                          ),
                                          elevation: 0,
                                        ),
                                      ),
                                    )),
                              ],
                            )
                        ),
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
                                      'Birth Day',
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
                                    FormBuilderTextField(
                                      onSaved: (value) {
                                        profileController.birthDay.value = value;
                                      },
                                      name: 'birthDay',
                                      initialValue: profileController.birthDay.value,
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1900, 1, 1),
                                            maxTime: DateTime.now(),
                                            onConfirm: (date) {
                                              _formKey.currentState?.fields['birthDay']?.setValue(DateFormat('yyyy/MM/dd').format(date).toString());
                                              profileController.birthDay.value = DateFormat('yyyy/MM/dd').format(date).toString();
                                            },
                                            onChanged:(date){
                                              _formKey.currentState?.fields['birthDay']?.setValue(DateFormat('yyyy/MM/dd').format(date).toString());
                                              profileController.birthDay.value = DateFormat('yyyy/MM/dd').format(date).toString();
                                            },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              24),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              24),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                        ),
                                        prefixIcon: Icon(
                                            Icons.calendar_month_outlined),
                                        filled: true,
                                        fillColor:
                                        AppColors.grayMain,
                                      ),
                                    ),)
                              ],
                            )
                        )
                      ],
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
                              profileController.onSaveProfile(
                                  profileController.fullName.value,
                                  profileController.phoneNo.value,
                                  profileController.address.value,
                                  profileController.selectedGender.value,
                                  profileController.birthDay.value,
                                  profileController.user.value?.email);
                            }
                          },
                          child: Text(
                            'Save Profile',
                          )
                      ),
                    ),
                    SizedBox(height: 20),
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
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? context.width * 0.2 : 30),
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: isDesktop ? context.width * 0.1 : context.width *
                        0.4,
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
                        child: Text(
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
