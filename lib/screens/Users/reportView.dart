import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nuthoop/model/addressBook.dart';
import 'package:nuthoop/model/ordered.dart';
import 'package:nuthoop/screens/Users/pdf_viewer_page.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' as material;
import 'package:pdf/widgets.dart' as pw;

reportView(context, OrderedModel data, List<AddressBook> addressbook) async {
  final Document pdf = Document();
  Future _readImageData(String name) async {
    final data = await rootBundle.load('asset/$name');
    return data.buffer.asUint8List();
  }

  final image = pw.MemoryImage(await _readImageData('nuthoop_g.png'));
  var purchasesAsMap = <Map<String, String>>[
    for (int i = 0; i < data.items.length; i++)
      {
        "Product": "${data.items[i].product.name}",
        "Unit Cost": "${data.items[i].priceRegular}",
        "Measurement": "${data.items[i].unitDetails.name}",
        "quantity": "${data.items[i].quantity}",
        "Total": "${data.items[i].price}",
      },
  ];

  List<List<String>> listOfPurchases = List();
  for (int i = 0; i < purchasesAsMap.length; i++) {
    listOfPurchases.add(purchasesAsMap[i].values.toList());
  }
  pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (pw.Context context) {
        // if (context.pageNumber == 1) {
        //   return null;
        // }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            // decoration: const BoxDecoration(
            //     border:
            //     BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('Nuthoop',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
            // Header(
            //     // level: 0,
            //     child:
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // Text('Reciept for ${data.items.length} Product',
                    //     textScaleFactor: 2),
                    pw.Image(image, width: 50),
                    Text(
                        'Order Date: ${DateFormat('yyyy-MM-dd').parse(data.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(data.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(data.createdAt).day}'),
                    Text('Order Number: ${data.orderNo}'),
                    Text('Invoice Total:${data.total}'),
                    Text('Status: ${data.orderStatus.name}',
                        style: Theme.of(context)
                            .defaultTextStyle
                            .copyWith(color: PdfColors.black)),

                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            bottom: 3.0 * PdfPageFormat.mm),
                        padding: const EdgeInsets.only(
                            bottom: 3.0 * PdfPageFormat.mm),
                        // decoration: const BoxDecoration(
                        //     border:
                        //     BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Name: ${(addressbook == null) ? '' : addressbook.where((e) => e.id == data.addressId).map((e) => e.firstName).join()} ${addressbook.where((e) => e.id == data.addressId).map((e) => e.lastName).join()}',
                                style: Theme.of(context)
                                    .defaultTextStyle
                                    .copyWith(color: PdfColors.black)),
                            Text(
                                'Address: ${(addressbook == null) ? '' : addressbook.where((e) => e.id == data.addressId).map((e) => e.houseNo).join()} ${addressbook.where((e) => e.id == data.addressId).map((e) => e.street).join()} ${addressbook.where((e) => e.id == data.addressId).map((e) => e.city).join()}',
                                style: Theme.of(context)
                                    .defaultTextStyle
                                    .copyWith(color: PdfColors.black)),
                          ],
                        ))
                  ]),
            ),
            // ),
            // Header(level: 1, text: 'What is Lorem Ipsum?'),
            // Paragraph(
            //     text:
            //         '${data.items.map((e) => e.product.name).join()} Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            // Paragraph(
            //     text:
            //         'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using "Content here, content here", making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for "lorem ipsum" will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'),
            // Header(level: 1, text: 'Where does it come from?'),
            // Paragraph(
            //     text:
            //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            // Paragraph(
            //     text:
            //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            // Padding(padding: const EdgeInsets.all(10)),

            Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Table.fromTextArray(
                    defaultColumnWidth: FixedColumnWidth(140.0),
                    border: TableBorder.all(
                        color: PdfColors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    headers: <dynamic>[
                      'Product',
                      'Unit Cost',
                      'Measurement',
                      'Qty',
                      'Total'
                    ],
                    headerStyle: TextStyle(fontWeight: FontWeight.bold),
                    cellAlignment: Alignment.centerLeft,
                    headerAlignment: Alignment.centerLeft,
                    data: listOfPurchases),
              ),
            ]),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Subtotal: ${data.subTotal}'),
                    Text('Shipping Fee:${data.deliveryCharges}'),
                    Text('Total:${data.total}'),
                  ]),
            )
          ]));
  //save PDF

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path, pdd: pdf),
    ),
  );
}
