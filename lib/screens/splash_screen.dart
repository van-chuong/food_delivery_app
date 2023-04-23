import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:food_delivery_app/config/helper/image_helper.dart';
import 'package:food_delivery_app/config/helper/local_storage_helper.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/intro_screen.dart';

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
    await Future.delayed(const Duration(milliseconds: 2000));
    final ignoreIntroScreen =
        LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      Navigator.of(context).pushNamed(HomeScreen.routerName);
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      Navigator.of(context).pushNamed(IntroScreen.routerName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
              child: Image.asset(
                ImageHelper.imgBgSplash,
                fit: BoxFit.fill,
              ),
            ),
        Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            heightFactor: 0.6,
            widthFactor: 0.5,
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
