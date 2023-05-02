import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/image_helper.dart';
import 'package:food_delivery_app/config/helper/local_storage_helper.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:food_delivery_app/screens/auth/sign_up_screen.dart';
import 'package:food_delivery_app/screens/main_screen.dart';
import 'package:get/get.dart';

import '../../config/themes/app_button_style.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen( {Key? key}) : super(key: key);
  static String routerName = '/home_screen';
  final  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var condition = context.width >= 1000 ;
    var conditionMobile = context.isPhone;
    return Scaffold(
      body: SafeArea(
          child: condition != true
              ? Stack(
            children: [
              Column(
                children: [
                  Flexible(
                      flex: conditionMobile?5:3,
                      child: HomeHeader(conditionMobile: conditionMobile)),
                  Flexible(
                      flex: conditionMobile?4:3,
                      child: HomeBody(conditionMobile: conditionMobile))
                ],
              )
            ],
          )
              :Row(
            children: [
              Expanded(child: HomeHeader(conditionMobile: conditionMobile),),
              Expanded(child: HomeBody(conditionMobile: conditionMobile)
              )
            ],
          )
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.conditionMobile,
  });

  final bool conditionMobile;

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return Column(
      children: [
        Flexible(
            flex: conditionMobile?4:3,
            child: Column(
              children: [
                SizedBox(height: conditionMobile?0:height * 0.2),
                FractionallySizedBox(
                  widthFactor: conditionMobile?0.8:0.6,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: ElevatedButton(
                        style: AppButtonStyle.buttonPrimary,
                        onPressed: () {
                          Get.toNamed('/sign_in');
                        },
                        child: Text(
                          'Sign In',
                          style: AppTextStyles.h2
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(height: conditionMobile?height *0.02:height * 0.05),
                FractionallySizedBox(
                  widthFactor: conditionMobile?0.8:0.6,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: ElevatedButton(
                        style: AppButtonStyle.buttonSecond,
                        onPressed: () {
                          Get.toNamed('/sign_up');
                        },
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.h2
                              .copyWith(color: Colors.black),
                        )),
                  ),
                )
              ],
            )),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Flexible(
                flex: conditionMobile?6:8,
                child: Divider(
                  color: AppColors.primaryColor,
                ),
              ),
              Flexible(
                flex: conditionMobile?3:3,
                child: AutoSizeText(
                  ' Or connect with',
                  style:
                  AppTextStyles.nomal.copyWith(color: Colors.black,fontSize: conditionMobile?16:20),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Flexible(
          flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Flexible(
                      flex: conditionMobile?4:2,
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Image.asset(ImageHelper.imgHamburger_2),
                        ),
                      )),
                  Spacer(
                    flex: conditionMobile?3:4,
                  ),
                  Flexible(
                      flex: conditionMobile?4:2,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Image.asset(ImageHelper.facebook_1),
                                    style: AppButtonStyle.iConButtonCircle,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                child: FittedBox(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Image.asset(ImageHelper.google_plus_1),
                                    style: AppButtonStyle.iConButtonCircle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ))

      ],
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.conditionMobile,
  });

  final bool conditionMobile;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FractionallySizedBox(
          widthFactor: conditionMobile?0.6:0.8,
          heightFactor: conditionMobile?0.7:0.8,
          child: FittedBox(
              child: Image.asset(ImageHelper.imgHamburger_1))),
    );
  }
}
