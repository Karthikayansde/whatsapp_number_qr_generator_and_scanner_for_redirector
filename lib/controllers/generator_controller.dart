import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';


class GeneratorController extends GetxController{

  GlobalKey qrkey = GlobalKey();
  // Uint8List image = Uint8List.fromList([0]);
  // late List<int> pngBytes = extractUint8List(image).obs;
  var pngBytes = <int>[].obs;

  // List<int> extractUint8List(Uint8List source){
  //   List<int> extractedList = [];
  //   for(int x in source){
  //     extractedList.add(x);
  //   }
  //   return extractedList;
  // }

  @override
  void onInit() {
    super.onInit();
    qrkey = GlobalKey();
  }

  Future<List<int>> imageQRGenerator() async{
    try{
      RenderRepaintBoundary boundary = qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      //Drawing White Background because Qr Code is Black
      // final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,Rect.fromLTWH(0,0,image.width.toDouble(),image.height.toDouble()));
      // canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      // extractUint8List(byteData!.buffer.asUint8List());
      pngBytes.value = byteData!.buffer.asUint8List().toList();
      return byteData.buffer.asUint8List().toList();
    }
    catch(e){
      return [];
    }
  }


}