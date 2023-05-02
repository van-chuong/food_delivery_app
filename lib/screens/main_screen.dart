import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/pages/profile_screen.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:flutter_adaptive_navigation/flutter_adaptive_navigation.dart';
import '../config/themes/app_colors.dart';
import 'pages/favorite_screen.dart';
import 'pages/home_view_screen.dart';
import 'pages/order_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routerName = '/main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var isDeskTop = context.width>=1000;
    return FlutterAdaptiveNavigationScaffold(
      labelDisplayType: LabelDisplayType.all,
      drawerWidthFraction: 0.15,

      destinations: [
        NavigationElement(
          icon: const Icon(Icons.home_outlined),
          selectedIcon:  Icon(Icons.home,color: AppColors.primaryColor),
          label: 'Home',
          builder: () =>  HomeViewScreen(),
        ),
        NavigationElement(
          icon: const Icon(Icons.favorite_outline),
          selectedIcon:  Icon(Icons.favorite,color: AppColors.primaryColor),
          label: 'Favorite',
          builder: () =>  FavoriteScreen(),
        ),
        NavigationElement(
          icon: const Icon(Icons.shopping_bag_outlined),
          selectedIcon:  Icon(Icons.shopping_bag,color: AppColors.primaryColor),
          label: 'Order',
          builder: () =>  OrderScreen(),
        ),

        NavigationElement(
          icon: const Icon(Icons.person_outline),
          selectedIcon:  Icon(Icons.person,color: AppColors.primaryColor,),
          label: 'Profile',
          builder: () =>  ProfileScreen(),
        ),
      ],
    );
  }
}
