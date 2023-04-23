import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/image_helper.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../config/themes/app_button_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routerName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var condition = Device.orientation == Orientation.landscape ||
        Device.screenType == ScreenType.desktop;
    var conditionMobile = Device.screenType == ScreenType.mobile;
    Size size = MediaQuery.of(context).size;
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
    return Column(
      children: [
        Flexible(
            flex: conditionMobile?4:3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: conditionMobile?0.8:0.6,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: ElevatedButton(
                          style: AppButtonStyle.buttonPrimary,
                          onPressed: () {},
                          child: Text(
                            'Sign In',
                            style: AppTextStyles.h2
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: conditionMobile?0.8:0.6,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: ElevatedButton(
                          style: AppButtonStyle.buttonSecond,
                          onPressed: () {},
                          child: Text(
                            'Sign Up',
                            style: AppTextStyles.h2
                                .copyWith(color: Colors.black),
                          )),
                    ),
                  ),
                )
              ],
            )),
        Spacer(flex: conditionMobile?2:1),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Flexible(
                  flex: conditionMobile?6:10,
                  child: Divider(
                    color: AppColors.primaryColor,
                  )),
              Flexible(
                flex: 3,
                child: AutoSizeText(
                  ' Or connect with',
                  style:
                  AppTextStyles.nomal.copyWith(color: Colors.black,fontSize: conditionMobile?16:22),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Flexible(
          flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Flexible(
                      flex: 5,
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Image.asset(ImageHelper.imgHamburger_2),
                        ),
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                      flex: 4,
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
