import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/pages/profile_screen.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:flutter_adaptive_navigation/flutter_adaptive_navigation.dart';
import '../config/themes/app_colors.dart';
import '../controllers/profile_controller.dart';
import 'admin/dashboard_screen.dart';
import 'admin/manage_order.dart';
import 'admin/manage_product.dart';
import 'admin/manage_user.dart';
import 'pages/favorite_screen.dart';
import 'pages/home_view_screen.dart';
import 'pages/order_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  static String routerName = '/main_screen';
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx((){
          if(profileController.isLoading.value){
            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
          }else{
            if(profileController.user.value?.role == true ) {
                return FlutterAdaptiveNavigationScaffold(
                  labelDisplayType: LabelDisplayType.all,
                  drawerWidthFraction: 0.15,
                  destinations: [
                    NavigationElement(
                      icon: const Icon(Icons.dashboard_outlined),
                      selectedIcon:  Icon(Icons.dashboard,color: AppColors.primaryColor),
                      label: 'Dashboard',
                      builder: () => DashboardScreen(),
                    ),
                    NavigationElement(
                      icon: const Icon(Icons.fastfood_outlined),
                      selectedIcon:  Icon(Icons.fastfood,color: AppColors.primaryColor),
                      label: 'Products',
                      builder: () =>  ManageProducts(),
                    ),
                    NavigationElement(
                      icon: const Icon(Icons.category_outlined),
                      selectedIcon:  Icon(Icons.category,color: AppColors.primaryColor),
                      label: 'Orders',
                      builder: () =>  ManageOrder(),
                    ),
                    NavigationElement(
                      icon: const Icon(Icons.manage_accounts_outlined),
                      selectedIcon:  Icon(Icons.manage_accounts,color: AppColors.primaryColor,),
                      label: 'User',
                      builder: () =>  ManageUser(),
                    ),
                  ],
                );
              }else{
              return FlutterAdaptiveNavigationScaffold(
                labelDisplayType: LabelDisplayType.all,
                drawerWidthFraction: 0.15,
                destinations: [
                  NavigationElement(
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon:  Icon(Icons.home,color: AppColors.primaryColor),
                    label: 'Home',
                    builder: () => HomeViewScreen(),
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
        })
    );
  }
}

class MenuUser extends StatelessWidget {
  const MenuUser({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return FlutterAdaptiveNavigationScaffold(
      labelDisplayType: LabelDisplayType.all,
      drawerWidthFraction: 0.15,
      destinations: [
        NavigationElement(
          icon: const Icon(Icons.home_outlined),
          selectedIcon:  Icon(Icons.home,color: AppColors.primaryColor),
          label: 'Home',
          builder: () => HomeViewScreen(),
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
