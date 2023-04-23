import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/screens/sign_in_screen.dart';

import '../../screens/home_screen.dart';
import '../../screens/intro_screen.dart';
import '../../screens/splash_screen.dart';


final Map<String,WidgetBuilder> routes = {
  SplashScreen.routerName: (context) => const SplashScreen(),
  IntroScreen.routerName: (context) => const IntroScreen(),
  HomeScreen.routerName: (context) => const HomeScreen(),
  SignInScreen.routerName: (context) => const SignInScreen(),
  MainScreen.routerName: (context) => const MainScreen(),
};