import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../config/helper/dialog_helper.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  @override
  void refresh() {

  }

  registerUser(String email, String passWord,String fullName, String phoneNo) async{
    DialogHelper.showLoading('Creating');
    var e = await FirebaseService().createUserWithEmailAndPassword(email,passWord,fullName);
    DialogHelper.hideLoading();
    if(e == null){
      Get.offAllNamed('/main_screen');
    }else if(e.code == 'email-already-in-use'){
      DialogHelper.alertDialog('The account already exists for that email');
    }else{
      DialogHelper.alertDialog('An error occurred, please try again later');
    }
  }

  @override
  void onInit() async{
    if(await FirebaseService().checkUserIsLogged()){
      Get.offAllNamed(MainScreen.routerName);
    }
  }
}