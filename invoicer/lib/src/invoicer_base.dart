import 'dart:io';

import 'package:invoicer/src/theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' hide Footer, Header, Theme, Table, TableRow;

import 'package:invoicer/src/config.dart';
import 'package:invoicer/src/widgets/widgets.dart';
import 'package:invoicer/src/models/models.dart';

Future<void> createPdf({
  required String customerName,
  required String invoiceName,
}) async {
  company = Company.fromJson(loadJson(companyPath));
  customer = Customer.fromJson(loadJson(customerPath(customerName)));
  invoice = Invoice.fromJson(loadJson(invoicePath(invoiceName)));
  final logoBytes = File(logoPath).readAsBytesSync();
  logo = MemoryImage(logoBytes);
  final pdf = Document();
  pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(marginTop: 30, marginBottom: 30),
      build: (context) {
        return [
          Container(height: 1.5*PdfPageFormat.cm),
          LetterHead(),
          Container(height: 30),
          Text("Rechnung Nr. RE-${invoice.id}\n\n", style: theme.title),
        Text("${invoice.introduction}\n\n", style: theme.body),
         ProductTable(),
                 Container(height: 5),
        Text(invoice.closingText, style: theme.body),
        ];
      },
      header: (context) => Header(),
      footer: (context) => Footer()));
  final file = File(outputPath());
  await file.writeAsBytes(await pdf.save());
}

String loadJson(String filePath) {
  return File(filePath).readAsStringSync();
}
