import 'package:flutter/material.dart';

class BottomNavigationBarWidget{
  BottomNavigationBar bottomNavigationBar(int pageIndex){
    return BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (val){
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag),label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'My Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ]);
  }
}