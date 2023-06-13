import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/models/CategoryModel.dart';
import 'package:food_delivery_app/screens/cart/confirm_order_screen.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/admin/order/edit_order.dart';
import '../../screens/admin/product/add_product.dart';
import '../../screens/admin/product/edit_product.dart';
import '../../screens/auth/home_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/cart/check_out_status.dart';
import '../../screens/category/sub_categories_screen.dart';
import '../../screens/intro_screen.dart';
import '../../screens/order/order_detail.dart';
import '../../screens/pages/home_view_screen.dart';
import '../../screens/product/product_detail.dart';
import '../../screens/profile/change_password_screen.dart';
import '../../screens/product/products_screen.dart';
import '../../screens/profile/my_profile_sreen.dart';
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
    GetPage(name: MyProfileScreen.routerName, page: () => MyProfileScreen()),
    GetPage(name: ChangePasswordScreen.routerName, page: () => ChangePasswordScreen()),
    GetPage(name: CartScreen.routerName, page: () => CartScreen()),
    GetPage(name: ConfirmOrderScreen.routerName, page: () => ConfirmOrderScreen()),
    GetPage(name: CheckOutStatus.routerName, page: () => CheckOutStatus()),
    GetPage(name: OrderDetail.routerName, page: () => OrderDetail()),
    GetPage(name: AddProduct.routerName, page: () => AddProduct()),
    GetPage(name: EditProduct.routerName, page: () => EditProduct()),
    GetPage(name: EditOrder.routerName, page: () => EditOrder()),
    GetPage(name: ProductDetail.routerName, page: () => ProductDetail()),
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
