

import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/image_helper.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:food_delivery_app/screens/profile/change_password_screen.dart';
import 'package:get/get.dart';

import '../../config/themes/app_colors.dart';
import '../../controllers/profile_controller.dart';
import '../auth/home_screen.dart';
import '../profile/my_profile_sreen.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);
  static String routerName = '/profile_screen';
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    var isDesktop = context.width > 1000;
    return SafeArea(
      child: Scaffold(
        body: profileController.firebaseUser != null?
        SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                        child: Obx(()=>CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profileController.photoUrl.value ?? ImageHelper.imgAvatarNet)
                        ))
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isDesktop?context.width*0.2:30),
                    child: Column(
                      children: [
                        Center(
                            child: Text(profileController.firebaseUser?.displayName?? 'Your Full Name',style: AppTextStyles.h1.copyWith(color: Colors.black) )
                        ),
                        Center(
                          child: Text(profileController.firebaseUser?.email?? 'Your Email',style: AppTextStyles.nomal.copyWith(color: Colors.black) ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              Get.toNamed(MyProfileScreen.routerName);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'My Profile',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              Get.toNamed(ChangePasswordScreen.routerName);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Change Password',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Payment Setting',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Notification',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'About Us',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Contact Us',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,),
                              ],
                            ),
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
                                profileController.signOut();
                              },
                              child:Text(
                                'Sign Out',
                              )
                          ),
                        ),
                      ],
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
            ),
      ),
    );
  }
}
