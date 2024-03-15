import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_colors.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_sizes.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/controllers/scanner_controller.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../Services/internet_checker.dart';
import '../Services/shared_pref.dart';
import '../Services/url_opener.dart';
import '../commons/app_strings.dart';
import '../components/pop_ups.dart';
import '../components/back_button.dart';
import '../components/country_ph_code_getter.dart';

class ScannerUI extends StatelessWidget {
  ScannerUI({super.key});

  final controller = Get.put(ScannerController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.appScaffold(
        body: Stack(
      children: [
        const QRViewScan(),
        Padding(
          padding: CustomPadding.page,
          child: CustomBackButton(onPressed: () {
            Get.back();
          }),
        ),
      ],
    ));
  }
}

class QRViewScan extends StatefulWidget {
  const QRViewScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewScanState();
}

class _QRViewScanState extends State<QRViewScan> {
  // Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isFlashOn = false;
  bool isCamFront = false;

  final controllerS = Get.put(ScannerController());
  final phDataController = Get.put(CountryPhCodeGetterController());
  final internetController = Get.put(InternetConnection());

  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Data: ',
                          style: TextStyle(
                              color: MyColor.greenBTN,
                              fontSize: screenWidth <= 280
                                  ? MyFontSizes.buttonTextSmall
                                  : screenWidth <= 480
                                      ? MyFontSizes.buttonTextPhone
                                      : MyFontSizes.buttonText),
                        ),
                      ),
                    ),
                    if (controllerS.result.value.code != null)
                      // Text('Barcode Type: ${describeEnum(controllerS.result.value.format)}   Data: ${controllerS.result.value.code}')
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 1, bottom: 8.0, right: 8.0),
                        child: Text(
                          '${controllerS.result.value.code}',
                          style: TextStyle(
                              color: MyColor.white,
                              fontSize: screenWidth <= 280
                                  ? MyFontSizes.buttonTextSmall
                                  : screenWidth <= 480
                                      ? MyFontSizes.buttonTextPhone
                                      : MyFontSizes.buttonText),
                        ),
                      )
                    // Text('Data: ${controllerS.result.value.code}')
                    else
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 1, bottom: 8.0, right: 8.0),
                        child: Text(
                          'Scan a QR code',
                          style: TextStyle(
                              color: MyColor.white,
                              fontSize: screenWidth <= 280
                                  ? MyFontSizes.buttonTextSmall
                                  : screenWidth <= 480
                                      ? MyFontSizes.buttonTextPhone
                                      : MyFontSizes.buttonText),
                        ),
                      ),
                    // Text('Scan a QR code'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                                onTap: () async {
                                  if (isCamFront == false && isFlashOn) {
                                    await controller?.toggleFlash();
                                    await controller?.flipCamera();
                                  } else if (isCamFront == true && isFlashOn) {
                                    await controller?.toggleFlash();
                                    await controller?.flipCamera();
                                  } else {
                                    await controller?.flipCamera();
                                  }
                                  isCamFront = isCamFront ? false : true;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 350,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(MyWidgetSize.radiusCommon),
                                      color: MyColor.blackBG,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: MyColor.greenBTN,
                                        width: 0.5,
                                      )),
                                  child: FutureBuilder(
                                    future: controller?.getCameraInfo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        return Center(
                                          child: Text(
                                            'Camera facing ${describeEnum(snapshot.data!)}',
                                            style: TextStyle(
                                                color: MyColor.greenBTN,
                                                fontSize: screenWidth <= 280
                                                    ? MyFontSizes.buttonTextSmall
                                                    : screenWidth <= 480
                                                        ? MyFontSizes.buttonTextPhone
                                                        : MyFontSizes.buttonText),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: Text(
                                            'loading',
                                            style: TextStyle(
                                                color: MyColor.greenBTN,
                                                fontSize: screenWidth <= 280
                                                    ? MyFontSizes.buttonTextSmall
                                                    : screenWidth <= 480
                                                        ? MyFontSizes.buttonTextPhone
                                                        : MyFontSizes.buttonText),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (await controller?.getCameraInfo() == CameraFacing.front) {
                                  PopUp.showToast(MyString.flashWarning);
                                } else {
                                  await controller?.toggleFlash();
                                  isFlashOn = isFlashOn ? false : true;
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                width: 350,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MyWidgetSize.radiusCommon),
                                    color: MyColor.blackBG,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: MyColor.greenBTN,
                                      width: 0.5,
                                    )),
                                child: FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    return Center(
                                      child: Text(
                                        'Flash: ${snapshot.data}',
                                        style: TextStyle(
                                            color: MyColor.greenBTN,
                                            fontSize: screenWidth <= 280
                                                ? MyFontSizes.buttonTextSmall
                                                : screenWidth <= 480
                                                    ? MyFontSizes.buttonTextPhone
                                                    : MyFontSizes.buttonText),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: MyColor.greenBTN,
        borderRadius: MyWidgetSize.radiusCommon,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        controllerS.result.value = scanData;
        if (await UrlOpener().launch(controllerS.result.value.code!) == false) {
          if (internetController.isInternetConnected() == false) {
            if (context.mounted) PopUp.showPopup(context, MyString.internetFalse);
          } else {
            if (context.mounted) PopUp.showPopup(context, MyString.wrong);
          }
        } else {
          SharedPrefIO.putPhISONo(phDataController.countryISO.value.phoneCode ?? '');
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
