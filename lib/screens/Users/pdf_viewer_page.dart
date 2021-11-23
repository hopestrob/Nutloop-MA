import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'dart:io';
// import 'package:pdf/widgets.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  final pdf.Document pdd;
  const PdfViewerPage({Key key, this.path, this.pdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
      appBar: AppBar(
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () async {
                Printing.sharePdf(
                    bytes: await pdd.save(), filename: 'Receipt.pdf');
              },
              child: Text('Share')),
          // ignore: deprecated_member_use
          // FlatButton(
          //     onPressed: () async {
          //       final directory = (await getExternalStorageDirectories(
          //               type: StorageDirectory.downloads))
          //           .first;

          //       File file2 = File("${directory.path}/NuthoopReceipt2.pdf");
          //       await file2.writeAsBytes(await pdd.save());

          //       // final output = await getTemporaryDirectory();
          //       // final file = File('${output.path}/NuthoopReceipt.pdf');
          //       // await file.writeAsBytes(await pdd.save());
          //       print('saved to $file2');
          //     },
          //     child: Text('Save')),
        ],
      ),
    );
  }
}
