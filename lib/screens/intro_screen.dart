import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/image_helper.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../config/themes/app_colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static String routerName = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  Widget _buildItemIntroScreen(
      String image, String title, String description, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 160, fit: BoxFit.fitHeight),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(title,
                style: AppTextStyles.h1.copyWith(color: AppColors.white)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(description,
                  style: AppTextStyles.nomal.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
            alignment: Alignment.bottomLeft,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(30,0,0,30),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: AppColors.gray,
                    activeDotColor: AppColors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
