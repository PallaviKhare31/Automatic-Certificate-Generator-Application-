import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

class PDFCreator {
  pw.Document pdf = pw.Document();

  Future<void> createPDF(String name, String rating) async {
    var imgFile = await rootBundle.load('assets/images/CERTIFICATE.png');

    pdf.addPage(
      pw.Page(
        orientation: pw.PageOrientation.landscape,
        margin: const pw.EdgeInsets.all(0.0),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Stack(
          children: [
            pw.Image(
              pw.MemoryImage(
                imgFile.buffer
                    .asUint8List(imgFile.offsetInBytes, imgFile.lengthInBytes),
              ),
              fit: pw.BoxFit.fill,
            ),
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  height: 65.0,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      width: 298.0,
                    ),
                    pw.Text(
                      name,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 64.0,
                        color: PdfColor((51 / 255), (213 / 255), (172 / 255)),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      width: 553.0,
                    ),
                    pw.Text(
                      rating,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 28.0,
                        color: PdfColor((51 / 255), (213 / 255), (172 / 255)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$name.pdf");
    file.openWrite();
    await file.writeAsBytes(List.from(await pdf.save()));
    OpenFile.open(file.path);
  }
}
