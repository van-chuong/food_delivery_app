import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/models/CategoryModel.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/auth/home_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/category/sub_categories_screen.dart';
import '../../screens/intro_screen.dart';
import '../../screens/pages/home_view_screen.dart';
import '../../screens/product/products_screen.dart';
import '../../screens/splash_screen.dart';

class Routes {
  static List<GetPage> pageRoutes = [
    GetPage(name: HomeScreen.routerName, page: () => HomeScreen()),
    GetPage(name: IntroScreen.routerName, page: () => IntroScreen()),
    GetPage(name: SplashScreen.routerName, page: () => SplashScreen()),
    GetPage(name: SignInScreen.routerName, page: () => SignInScreen()),
    GetPage(name: SignUpScreen.routerName, page: () => SignUpScreen()),
    GetPage(name: MainScreen.routerName, page: () => MainScreen()),
    GetPage(name: HomeViewScreen.routerName, page: () => HomeViewScreen()),
    GetPage(name: SubCategoriesScreen.routerName, page: () => SubCategoriesScreen()),
    GetPage(name: ProductsScreen.routerName, page: () => ProductsScreen()),
  ];
  static Map<String, WidgetBuilder> routes = {
    SplashScreen.routerName: (context) => SplashScreen(),
    IntroScreen.routerName: (context) => IntroScreen(),
    HomeScreen.routerName: (context) => HomeScreen(),
    SignInScreen.routerName: (context) => SignInScreen(),
    SignUpScreen.routerName: (context) => SignUpScreen(),
    MainScreen.routerName: (context) => MainScreen(),
    HomeViewScreen.routerName: (context) => HomeViewScreen(),
  };
}
