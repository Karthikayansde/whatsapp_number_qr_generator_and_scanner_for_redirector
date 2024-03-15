import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_colors.dart';

class CustomPadding {
  static const EdgeInsetsGeometry page = EdgeInsets.all(23);
}

class CustomScaffold extends Scaffold {
  const CustomScaffold({required Widget body, required Color backgroundColor, Key? key}) : super(body: body, key: key, backgroundColor: backgroundColor);
  factory CustomScaffold.appScaffold({required Widget body}) {
    return CustomScaffold(
      body: SafeArea(child: body),
      backgroundColor: MyColor.blackBG,
    );
  }
}

class MyFontSizes{
  static const double headingSize = 50;
  static const double buttonText = 24;
  static const double buttonTextPhone = 15;
  static const double buttonTextSmall = 12;
}

class MySizedBox extends SizedBox{
  const MySizedBox({Widget? child,double? height, double? width, Key? key}):super(key: key, child: child, width: width,height: height);

  factory MySizedBox.headText({required Widget child}){
    return MySizedBox(height: 60,child: child,);
  }
  factory MySizedBox.height20(){
    return const MySizedBox(height: 20);
  }
  factory MySizedBox.height6h(){
    return MySizedBox(height: 6.h);
  }
  factory MySizedBox.height2h(){
    return MySizedBox(height: 2.h);
  }
}

class MyWidgetSize{
  static const double radiusCommon = 8;
  static const double elevation = 5;
}