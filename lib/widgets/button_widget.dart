import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: AppGradient.dfGradientBg,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: Offset(1, 4), // changes position of shadow
              ),
            ]
          ),
          child: Text(
            " " + title + " ",
            style: AppTextStyles.h2.copyWith(fontSize: 16 ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
