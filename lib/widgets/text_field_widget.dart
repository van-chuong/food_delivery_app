import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/themes/app_colors.dart';

class TextFieldWidget{
  dynamic getTextField({required String hint, required Icon icon,required TextEditingController textEditingController, required bool checkUser }) {

  }

  dynamic getPasswordField({required String hint, required Icon icon,required TextEditingController textEditingController,required bool checkPass}) {
    return TextField(
      controller: textEditingController,
      obscureText: true,
      decoration: InputDecoration(
        errorText: checkPass== false ?"Invalid or incorrect username ":null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          prefixIcon: icon,
          filled: true,
          fillColor: AppColors.grayMain,
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.blueDarkColor.withOpacity(0.5))),
    );
  }
}


