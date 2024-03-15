import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/Services/pdf_generator.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_colors.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_sizes.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_strings.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/text.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/components/back_button.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/components/buttons.dart';
import '../Services/validator.dart';
import '../commons/constants.dart';
import '../components/pop_ups.dart';
import '../components/country_ph_code_getter.dart';
import '../controllers/generator_controller.dart';

class GeneratorUI extends StatelessWidget {
  GeneratorUI({super.key});
  final phDataController = Get.put(CountryPhCodeGetterController());
  final controller = Get.put(GeneratorController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.appScaffold(
      body: Padding(
        padding: CustomPadding.page,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MySizedBox.height2h(),
                MySizedBox.headText(child: CustomText.headingWhite(MyString.whatsApp)),
                MySizedBox.headText(child: CustomText.headingGreen(MyString.redirect)),
                const SizedBox(height: 40),
                const CountryPhCodeGetter(),
                MySizedBox.height20(),
                MySizedBox.height20(),
                Center(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: MyColor.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: RepaintBoundary(
                      key: controller.qrkey,
                      child: Obx(
                        ()=> QrImageView(
                          data: phDataController.phoneNo.value == ''?'Enter Phone Number':'${Constants.baseURL}+${phDataController.countryISO.value.phoneCode}${phDataController.phoneNo.value}',
                          version: QrVersions.auto,
                          size: 200.0,
                          embeddedImage: const AssetImage(Constants.whatsAppIcon),
                          gapless: true,
                          errorStateBuilder: (ctx, err) {
                            return const Center(
                              child: Text(
                                'Something went wrong!!!',
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Center(child: Container(height: 200,width: 200, decoration: const BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.all(Radius.circular(MyWidgetSize.radiusCommon)))),),
                const Spacer(),
                Center(
                    child: ActionBtn(
                  onPressed: () async {
                    final plugin = DeviceInfoPlugin();
                    final android = await plugin.androidInfo;
                    ph.PermissionStatus status;
                    if(android.version.sdkInt < 33){
                      status = await ph.Permission.storage.request();
                    }
                    else{
                      status = ph.PermissionStatus.granted;
                    }
                    // PermissionStatus status = PermissionStatus.granted;

                    if(status == ph.PermissionStatus.granted){
                      int isValidCheck = Validator.validatePhNoDownload(phDataController.countryISO.value, phDataController.phNoTextController.text);
                      switch (isValidCheck) {
                        case 3:
                          {
                            PopUp.showPopup(context, MyString.selectCountryCode);
                            break;
                          }
                        case 0:
                          {
                            if(await pdfGenerator(await controller.imageQRGenerator(), '+${phDataController.countryISO.value.phoneCode} ${phDataController.phNoTextController.text}')){
                              if(context.mounted){
                          {PopUp.showPopup(context, MyString.downloadSuccess);}
                              }
                          }else{
                              if(context.mounted){
                                PopUp.showPopup(context, MyString.wrong);
                              }
                            }
                            break;
                          }
                        case 1:
                          {
                            if(context.mounted){
                              PopUp.showPopup(context, MyString.noEmpty);
                            }
                            break;
                          }
                      }
                    }
                    else if(status == ph.PermissionStatus.denied){
                      PopUp.showPopup(context, MyString.deniedMsg);
                    }
                    else if(status == ph.PermissionStatus.permanentlyDenied){
                      PopUp.showPopupOpenSettingsForStorage(context);
                    }
                    else{
                      PopUp.showPopup(context, MyString.wrong);
                    }


                },
                  label: MyString.download,)
                ),
              ],
            ),
            CustomBackButton(onPressed: (){Get.back();}),
          ],
        ),
      ),
    );
  }
}
