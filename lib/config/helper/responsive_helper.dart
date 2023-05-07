import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class ResponsiveHelper{
  static styleMedia(int mobile, int tablet, int desktop, BuildContext context){
    if(context.isPhone ){
      return mobile;
    }else if (context.isTablet){
      return tablet;
    }else if (context.width > 1000){
      return desktop;
    }
  }
  static styleMediaDouble(double mobile, double tablet, double desktop, BuildContext context){
    if(context.isPhone ){
      return mobile;
    }else if (context.isTablet){
      return tablet;
    }else if (context.width > 1000){
      return desktop;
    }
  }

}