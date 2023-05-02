import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/firebase_service.dart';

class AuthController extends GetxController{
  static AuthController get instance => Get.find();
  Future checkUserAndNavigation(String trueRouter,String falseRouter) async {
    var check = await FirebaseService().checkUserIsLogged();
        if(check){
          Get.offAllNamed(trueRouter);
        }else{

        }
  }
}