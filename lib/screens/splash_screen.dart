import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/config/image_helper.dart';
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
  void redirectIntroScreen() async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushNamed(IntroScreen.routerName);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          ImageHelper.imgBgSplash,
          fit: BoxFit.fitWidth,
        )),
        Positioned.fill(child: Image.asset(ImageHelper.imgLogoFood)),
      ],
    );
  }
}
