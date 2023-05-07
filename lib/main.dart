import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/local_storage_helper.dart';
import 'package:food_delivery_app/config/routes/routes.dart';
import 'package:food_delivery_app/screens/auth/home_screen.dart';
import 'package:food_delivery_app/screens/intro_screen.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:food_delivery_app/screens/profile/change_password_screen.dart';
import 'package:food_delivery_app/screens/product/products_screen.dart';
import 'package:food_delivery_app/screens/profile/my_profile_sreen.dart';
import 'package:food_delivery_app/screens/splash_screen.dart';
import 'package:food_delivery_app/screens/test.dart';
import 'package:food_delivery_app/services/constants_firebase.dart';
import 'package:food_delivery_app/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/themes/app_colors.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: FirebaseConstants.apiKey,
            appId: FirebaseConstants.appId,
            messagingSenderId: FirebaseConstants.messagingSenderId,
            projectId: FirebaseConstants.projectId));
  }else{
    await Firebase.initializeApp();
  }
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();

  String initialRoute;
  bool? ignoreIntroScreen = LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
  if(await FirebaseService().checkUserIsLogged()){
    initialRoute = MainScreen.routerName;
  }else{
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      initialRoute = HomeScreen.routerName;
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      initialRoute = IntroScreen.routerName;
    }
  }

  runApp(MyApp(initialRoute));
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      title: 'Food App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.bgWhite,
        backgroundColor: AppColors.bgWhite,
      ),
      initialRoute: initialRoute,  //initialRoute,
      getPages: Routes.pageRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
