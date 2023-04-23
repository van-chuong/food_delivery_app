import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firebase_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routerName = '/home_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(
        onPressed: () async{
          FirebaseService().signOut();
        },
        child: Text('SignOut'),
      )),
    );
  }
}
