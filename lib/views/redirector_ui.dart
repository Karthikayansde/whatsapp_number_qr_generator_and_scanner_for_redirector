import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/Services/shared_pref.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_strings.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_sizes.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/constants.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/text.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/components/back_button.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/components/buttons.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/components/country_ph_code_getter.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/controllers/redirector_controller.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/views/generator_ui.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/views/scanner_ui.dart';
import '../Services/internet_checker.dart';
import '../Services/url_opener.dart';
import '../Services/validator.dart';
import '../components/pop_ups.dart';

class RedirectorUI extends StatelessWidget {
  RedirectorUI({super.key});

  final controller = Get.put(RedirectorController());
  final phDataController = Get.put(CountryPhCodeGetterController());
  final internetController = Get.put(InternetConnection());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        bool exitConfirmed = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(MyString.exitMsg),
                actions: [
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).pop(false);
                  }, child: const Text(MyString.cancel)),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).pop(true);
                  }, child: const Text(MyString.ok))],
              );
            }
        );

        return exitConfirmed;
      },
      child: CustomScaffold.appScaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MySizedBox.height6h(),
                MySizedBox.headText(child: CustomText.headingWhite(MyString.whatsApp)),
                MySizedBox.headText(child: CustomText.headingGreen(MyString.redirect)),
                const SizedBox(height: 40),
                const CountryPhCodeGetter(),
                MySizedBox.height20(),
                Row(
                  children: [
                    OutlinedBtn(
                        onPressed: () async {
                          PermissionStatus status = await Permission.camera.request();
                          if(status == PermissionStatus.granted){
                            if(context.mounted){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScannerUI(),
                                  ));
                            }
                          }
                          else if(status == PermissionStatus.denied){
                            if(context.mounted)PopUp.showPopup(context, MyString.deniedMsg);
                          }
                          else if(status == PermissionStatus.permanentlyDenied){
                            if(context.mounted)PopUp.showPopupOpenSettings(context);
                          }
                          else{
                            if(context.mounted)PopUp.showPopup(context, MyString.wrong);
                          }
                        },
                        label: MyString.qrScanner,
                        iconPath: Constants.scanningIcon,
                        isSvgIcon: true),
                    const SizedBox(
                      width: 20,
                    ),
                    OutlinedBtn(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GeneratorUI(),
                              ));
                          // Get.to(GeneratorUI());
                        },
                        label: MyString.qrGenerator,
                        icon: Icons.qr_code_scanner_sharp,
                        isSvgIcon: false),
                  ],
                ),
                const Spacer(),
                Center(
                    child: ActionBtn(
                      onPressed: () async {
                        int isValidCheck = Validator.validatePhNo(phDataController.countryISO.value, phDataController.phNoTextController.text);
                        switch (isValidCheck) {
                          case 3:
                            {
                              PopUp.showPopup(context, MyString.selectCountryCode);
                              break;
                            }
                          case 0:
                            {
                              if (await UrlOpener().launch('${Constants.baseURL}+${phDataController.countryISO.value.phoneCode}${phDataController.phNoTextController.text}') == false) {
                                if(internetController.isInternetConnected() == false){
                                  if(context.mounted)PopUp.showPopup(context, MyString.internetFalse);
                                }
                                else{
                                  if(context.mounted)PopUp.showPopup(context, MyString.wrong);
                                }
                              } else {
                                SharedPrefIO.putPhISONo(phDataController.countryISO.value.phoneCode ?? '');
                              }
                              break;
                            }
                          case 1:
                            {
                              if(context.mounted)PopUp.showPopup(context, MyString.noEmpty);
                              break;
                            }
                          case 2:
                            {
                              if(context.mounted)PopUp.showPopup(context, MyString.noInvalid);
                              break;
                            }
                        }
                      },
                      label: MyString.chat,
                    )),
              ],
            ),
            CustomBackButton(
                onPressed: () {
                  PopUp.showPopupCancel(context, MyString.exitMsg);
                }
            ),
          ],
        ),
      ),
    );
  }
}
