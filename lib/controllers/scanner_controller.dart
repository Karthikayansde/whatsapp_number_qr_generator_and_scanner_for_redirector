import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends GetxController{
  var result = Barcode(null, BarcodeFormat.unknown, null).obs;
}