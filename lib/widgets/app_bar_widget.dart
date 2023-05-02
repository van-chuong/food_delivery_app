import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget {
  appBarMobile(String? title, context) {
    if (!kIsWeb) {
      if (title == null) {
        return AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: ElevatedButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        );
      } else {
        return AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        );
      }
    }
    return null;
  }
}
