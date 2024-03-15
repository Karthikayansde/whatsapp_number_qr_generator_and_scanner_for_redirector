import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_sizes.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/constants.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/views/redirector_ui.dart';

import '../commons/app_strings.dart';

class SplashUI extends StatelessWidget {
  const SplashUI({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.appScaffold(
      body: Padding(
        padding: CustomPadding.page,
        child: FutureBuilder(
          future: splashTime(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RedirectorUI();
            }
            return Center(
              child: Wrap(
                children: [
                  Column(
                    children: [
                      // Container(
                      //   height: 200,
                      //   width: 200,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     // color: MyColor.logoBG,
                        //     shape: BoxShape.rectangle,),
                        // child:
                        ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset(Constants.logo, width: 100, height: 100,)),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(MyString.appName,textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ],
              )
            );
          },
        ),
      ),
    );
  }

  Future<bool> splashTime() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
