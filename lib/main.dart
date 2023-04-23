import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/local_storage_helper.dart';
import 'package:food_delivery_app/config/routes/routes.dart';
import 'package:food_delivery_app/screens/sign_in_screen.dart';
import 'package:food_delivery_app/screens/test.dart';
import 'package:food_delivery_app/services/constants_firebase.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: FirebaseConstants.apiKey,
            appId: FirebaseConstants.appId,
            messagingSenderId: FirebaseConstants.messagingSenderId,
            projectId: FirebaseConstants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      Device.setScreenSize(
          context, Device.boxConstraints, Device.orientation, 600, 950);
      return MaterialApp(
        title: 'Food App',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.bgWhite,
          backgroundColor: AppColors.bgWhite,
        ),
        routes: routes,
        debugShowCheckedModeBanner: false,
        home: const SignInScreen(),
      );
    });
  }
}
