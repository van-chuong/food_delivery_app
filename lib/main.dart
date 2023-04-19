import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/routes/routes.dart';
import 'package:food_delivery_app/screens/splash_screen.dart';
import 'config/themes/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.bgWhite,
        backgroundColor: AppColors.bgWhite,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}


