

import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> saveAndLaunchFile(List<int> bytes, String fileName) async {

  bool dirExists = false;
  dynamic externalDir = '/storage/emulated/0/Download/Qr_code';
  try{

    Uint8List pngBytes = Uint8List.fromList(bytes);

    //Check for duplicate file name to avoid Override
    String fileName = 'qr_code';
    int i = 1;
    while(await File('$externalDir/$fileName.pdf').exists()){
      fileName = 'qr_code_$i';
      i++;
    }

    // Check if Directory Path exists or not
    dirExists = await File(externalDir).exists();
    //if not then create the path
    if(!dirExists){
      await Directory(externalDir).create(recursive: true);
      dirExists = true;
    }

    final file = await File('$externalDir/$fileName.pdf').create();
    await file.writeAsBytes(pngBytes);

    final path = (await getExternalStorageDirectory())?.path;
    OpenFile.open('$path/$fileName');

    return true;

  }catch(e){
    return false;
  }

  // final path = (await getExternalStorageDirectory())?.path;
  // final file = File('$path/$fileName');
  // await file.writeAsBytes(bytes, flush: true);
  // OpenFile.open('$path/$fileName');
}