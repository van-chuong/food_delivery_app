import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:food_delivery_app/config/helper/image_helper.dart';
import 'package:food_delivery_app/config/helper/local_storage_helper.dart';
import 'package:food_delivery_app/screens/auth/home_screen.dart';
import 'package:food_delivery_app/screens/intro_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routerName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirectIntroScreen();
  }

  void redirectIntroScreen() async {
    final ignoreIntroScreen =
        LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      Get.offAllNamed('/home_screen');
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      Get.offAllNamed('/intro_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    var condition = context.isLandscape ||
        context.isDesktop;
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
              child: Image.asset(
                ImageHelper.imgBgSplash,
                fit: BoxFit.fitWidth,
              ),
            ),
        Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            heightFactor: 0.6,
            widthFactor: condition?0.3:0.5,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset(
                ImageHelper.imgLogoFood,
              ),
            ),
          ),
        )

      ],
    ));
  }
}
