import 'dart:convert';
import 'package:universal_html/html.dart';

Future<bool> saveAndLaunchFile(List<int> bytes, String fileName) async {
  try{
    AnchorElement(
        href:
        "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();
    return true;
  }
  catch(e){
    return false;
  }
}