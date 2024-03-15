import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../commons/app_strings.dart';

class PopUp {
  static showPopup(BuildContext context, String content){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(content),
            actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text(MyString.ok))],
          );
        });
  }
  static showPopupCancel(BuildContext context, String content) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(content),
            actions: [
              ElevatedButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: const Text(MyString.cancel)),
              ElevatedButton(onPressed: () {
                SystemNavigator.pop();
            }, child: const Text(MyString.ok))],
          );
        }
        );
  }
  static showPopupOpenSettings(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Required'),
            content: const Wrap(
              children: [
                Column(
                  children: [
                    Text('        To scan a QR code, please grant the camera permission to access the scanner on your device.'),
                    Align(
                      alignment: Alignment.center,
                      child: Text('1. Click on Open App Settings\n2. CLick on App permissions\n3. Turn on Camera'),
                    )
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
            }, child: const Text(MyString.cancel)),
              ElevatedButton(onPressed: () async {
                await openAppSettings();
            }, child: const Text(MyString.openSettings))],
          );
        }
        );
  }

  static showPopupOpenSettingsForStorage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Required'),
            content: const Wrap(
              children: [
                Column(
                  children: [
                    Text('        To download and save QR codes locally, please grant storage permission to save the QR codes on your device.'),
                    Align(
                      alignment: Alignment.center,
                      child: Text('1. Click on Open App Settings\n2. CLick on App permissions\n3. Turn on Camera'),
                    )
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
            }, child: const Text(MyString.cancel)),
              ElevatedButton(onPressed: () async {
                await openAppSettings();
            }, child: const Text(MyString.openSettings))],
          );
        }
        );
  }



  static showToast(String message){

    return Fluttertoast.showToast(
      // webPosition: 'center',webBgColor: 'linear-gradient(to right, #EFC12CFF, #FFFFFFFF)',
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
