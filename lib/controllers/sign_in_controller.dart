import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../config/helper/dialog_helper.dart';

class SignInController extends GetxController{
  static SignInController get instance => Get.find();

  @override
  void onInit() async{
    if(await FirebaseService().checkUserIsLogged()){
      Get.toNamed(MainScreen.routerName);
    }
  }
}