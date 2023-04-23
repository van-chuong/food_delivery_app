import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/helper/image_helper.dart';
import 'package:food_delivery_app/config/helper/orientation.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../config/themes/app_colors.dart';
import '../widgets/button_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static String routerName = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  final StreamController<int> _pageStreamController =
      StreamController.broadcast();

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toInt());
    });
  }

  Widget _buildItemIntroScreen(
      String image, String title, String description, Size size) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Stack(
            children: [
              Column(
                children: [
                  Row(children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex: 1,
                      child:
                      Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(child: Image.asset(image, fit: BoxFit.fitHeight))),),
                    Spacer(flex: 1),
                  ],),
                  Text(title,
                      style:
                      AppTextStyles.h1.copyWith(color: AppColors.primaryColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(description,
                        style: AppTextStyles.nomal
                            .copyWith(color: AppColors.primaryColor),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
            ],
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double paddingLeft ;
    final double paddingTop ;
    final double paddingBottom ;
    final double paddingRight;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildItemIntroScreen(
                  ImageHelper.intro1,
                  "Delicious Food",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  size),
              _buildItemIntroScreen(
                  ImageHelper.intro2,
                  "Fast Shipping",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  size),
              _buildItemIntroScreen(
                  ImageHelper.intro3,
                  "Certificate Food",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  size),
              _buildItemIntroScreen(
                  ImageHelper.intro4,
                  "Payment Online",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  size),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: OrientationHelper.styleMediaDouble(10, 20, 30)),
                child: Row(
                  children: [
                    Spacer(flex:1),
                    Expanded(
                      flex: OrientationHelper.styleMedia(6, 8, 16),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: ExpandingDotsEffect(
                          dotHeight: OrientationHelper.styleMedia(10, 15,30),
                          dotWidth: OrientationHelper.styleMedia(10, 15,30),
                          dotColor: AppColors.gray,
                          activeDotColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    StreamBuilder<int>(
                        initialData: 0,
                        stream: _pageStreamController.stream,
                        builder: (context, snapshot) {
                          return Expanded(
                              flex: OrientationHelper.styleMedia(4, 2, 1),
                              child: ButtonWidget(
                                title:
                                    snapshot.data != 3 ? 'Next' : 'Get started',
                                onTap: () {
                                  if (_pageController.page != 3) {
                                    _pageController.nextPage(
                                        duration: Duration(microseconds: 200),
                                        curve: Curves.decelerate
                                    );
                                  } else {
                                    Navigator.of(context)
                                        .pushNamed(HomeScreen.routerName);
                                  }
                                },
                              ));
                        }),
                    Spacer(flex:1),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
