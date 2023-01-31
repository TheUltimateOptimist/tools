import 'dart:io';

import 'package:invoicer/src/theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' hide Footer, Header, Theme;

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
        return [Theme(child: LetterHead()),Container(height: 30), Theme(child: Content())];
      },
      header: (context) => Theme(child: Header()),
      footer: (context) => Theme(child: Footer())));
  final file = File(outputPath());
  await file.writeAsBytes(await pdf.save());
}

String loadJson(String filePath) {
  return File(filePath).readAsStringSync();
}
