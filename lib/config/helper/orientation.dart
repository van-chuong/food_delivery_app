import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrientationHelper{
  static styleMedia(int mobile, int tablet, int desktop){
      if(Device.screenType == ScreenType.mobile ){
        return mobile;
      }else if (Device.screenType == ScreenType.tablet){
        return tablet;
      }else if (Device.screenType == ScreenType.desktop){
        return desktop;
      }
  }
  static styleMediaDouble(double mobile, double tablet, double desktop){
    if(Device.screenType == ScreenType.mobile ){
      return mobile;
    }else if (Device.screenType == ScreenType.tablet){
      return tablet;
    }else if (Device.screenType == ScreenType.desktop){
      return desktop;
    }
  }
}