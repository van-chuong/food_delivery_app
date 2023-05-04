import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'main_screen.dart';
import 'pages/profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_adaptive_navigation/flutter_adaptive_navigation.dart';

import '../widgets/custom_grid_widget.dart';
import '../widgets/custom_list_widget.dart';
import 'pages/favorite_screen.dart';
import 'pages/order_screen.dart';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
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
          builder: () =>  MainScreen(),
        ),
        NavigationElement(
          icon: const Icon(Icons.shopping_bag_outlined),
          selectedIcon:  Icon(Icons.shopping_bag,color: AppColors.primaryColor),
          label: 'Order',
          builder: () =>  OrderScreen(),
        ),
        NavigationElement(
          icon: const Icon(Icons.favorite_outline),
          selectedIcon:  Icon(Icons.favorite,color: AppColors.primaryColor),
          label: 'Favorite',
          builder: () => FavoriteScreen(),
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

  // NavigationRail buildNavigationRail() {
  //   return NavigationRail(
  //         selectedIndex: _selectedIndex,
  //         groupAlignment: groupAligment,
  //         onDestinationSelected: (int index) {
  //           setState(() {
  //             _selectedIndex = index;
  //           });
  //         },
  //         labelType: labelType,
  //         leading: showLeading
  //             ? FloatingActionButton(
  //           elevation: 0,
  //           onPressed: () {
  //             // Add your onPressed code here!
  //           },
  //           child: const Icon(Icons.add),
  //         )
  //             : const SizedBox(),
  //         trailing: showTrailing
  //             ? IconButton(
  //           onPressed: () {
  //             // Add your onPressed code here!
  //           },
  //           icon: const Icon(Icons.more_horiz_rounded),
  //         )
  //             : const SizedBox(),
  //         destinations: const <NavigationRailDestination>[
  //           NavigationRailDestination(
  //             icon: Icon(Icons.favorite_border),
  //             selectedIcon: Icon(Icons.favorite),
  //             label: Text('First'),
  //           ),
  //           NavigationRailDestination(
  //             icon: Icon(Icons.bookmark_border),
  //             selectedIcon: Icon(Icons.book),
  //             label: Text('Second'),
  //           ),
  //           NavigationRailDestination(
  //             icon: Icon(Icons.star_border),
  //             selectedIcon: Icon(Icons.star),
  //             label: Text('Third'),
  //           ),
  //         ],
  //       );
  // }
}
