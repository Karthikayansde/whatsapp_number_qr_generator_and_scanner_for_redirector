import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'mobile_download.dart';
// import 'mobile_download.dart' if (dart.library.html) 'web_download.dart' as dl;

Future<bool> pdfGenerator(List<int> qrImage, String phno) async {
  try{

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: pw.Font.ttf(
          await rootBundle.load('assets/fonts/Roboto-Light.ttf'),
        ),
      ),
    );

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(0),
      orientation: pw.PageOrientation.portrait,
      build: (pw.Context context) {

        final imageBytes = Uint8List.fromList(qrImage);
        // pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));

        return pw.Container(
            height: double.infinity,
            width: double.infinity,
            color: const PdfColor.fromInt(0xFF252525),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(40),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text('Scan to Share on',
                    style: const pw.TextStyle(
                      color: PdfColor.fromInt(0xFF1D9400),
                      fontSize: 70,
                    )),
                pw.Text('WhatsApp',
                    style: const pw.TextStyle(
                      color: PdfColor.fromInt(0xFFFFFFFF),
                      fontSize: 70,
                    )),
                pw.SizedBox(height: 44),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Container(
                      decoration: pw.BoxDecoration(
                        color: const PdfColor.fromInt(0xFFFFFFFF),
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      width: 300,
                      height: 300,
                      child: pw.Center(
                        child: pw.Image(pw.MemoryImage(imageBytes)),
                      )),
                ),
                pw.SizedBox(height: 30),
                pw.Text('WhatsApp No:',
                    style: const pw.TextStyle(
                      color: PdfColor.fromInt(0xFF1D9400),
                      fontSize: 60,
                    )),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(phno,
                      style: const pw.TextStyle(
                        color: PdfColor.fromInt(0xFFFFFFFF),
                        fontSize: 43,
                      )),
                )
              ]),
            ));
      },
    ));
    saveAndLaunchFile(await pdf.save(), 'whatsAppQR.pdf');
    return true;
  }
  catch(e){
    return false;
  }
}
