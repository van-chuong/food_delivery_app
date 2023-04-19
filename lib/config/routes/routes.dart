import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/screens/intro_screen.dart';
import 'package:food_delivery_app/screens/splash_screen.dart';

final Map<String,WidgetBuilder> routes = {
  SplashScreen.routerName: (context) => const SplashScreen(),
  IntroScreen.routerName: (context) => const IntroScreen(),
};