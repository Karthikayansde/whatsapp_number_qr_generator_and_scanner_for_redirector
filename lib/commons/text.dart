import 'package:flutter/material.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_colors.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_sizes.dart';

class CustomText extends Text{
  const CustomText(
      String data, {
        Key? key,
        TextAlign? textAlign,
        TextStyle? style,
      }) : super(data, key: key, style: style, textAlign: textAlign);
  factory CustomText.headingWhite(String data){
    return CustomText(data,textAlign: TextAlign.left,style: const TextStyle(color: MyColor.white,fontSize: MyFontSizes.headingSize),);
  }
  factory CustomText.headingGreen(String data){
    return CustomText(data,textAlign: TextAlign.left,style: const TextStyle(color: MyColor.greenTXT,fontSize: MyFontSizes.headingSize),);
  }
}