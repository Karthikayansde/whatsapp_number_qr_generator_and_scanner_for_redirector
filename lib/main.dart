import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_colors.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_strings.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/constants.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/views/splash_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyString.appName,
        home: const SplashUI(),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: ()=>const SplashUI())
        ],
        theme: ThemeData(
          fontFamily: Constants.font,
          colorScheme: ColorScheme.fromSeed(
            seedColor: MyColor.greenBTN,
            brightness: Brightness.dark,
            // background: MyColor.blackBG,
          ),
          useMaterial3: true,
        ),
      );
    },);
  }
}
