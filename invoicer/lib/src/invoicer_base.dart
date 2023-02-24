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
          Container(height: 1.5 * PdfPageFormat.cm),
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

Future<void> createCover() async {
  final pdf = Document();
  pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(marginBottom: 0, marginLeft: 0, marginRight: 0, marginTop: 0),
      build: (context) {
        return getRowList();
      }));
  final file = File("cover_assets.pdf");
  await file.writeAsBytes(await pdf.save());
}

String loadJson(String filePath) {
  return File(filePath).readAsStringSync();
}

class PlayingCard extends StatelessWidget {
  PlayingCard(this.title, this.amount);
  final String title;
  final int amount;
  @override
  Widget build(Context context) {
    return Container(decoration: BoxDecoration(border: Border.all(color: PdfColor(0,0,0))),
      width: 7 * PdfPageFormat.cm,
      height: (29.7 / 4) * PdfPageFormat.cm - 0.005*PdfPageFormat.cm,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text("$amount\$")],
        ),
      ),
    );
  }
}

class Card {
  final String name;
  final int amount;

  Card(this.name, this.amount);
}

List<Card> generateCards() {
  final cards = List<Card>.empty(growable: true);
  cards.addAll(List.filled(4, Card("Gold", 50000)));
  cards.addAll(List.filled(8, Card("Silver", 2500)));
  cards.addAll(List.filled(8, Card("Home", 20000)));
  cards.addAll(List.filled(10, Card("Jewels", 15000)));
  cards.addAll(List.filled(10, Card("Car", 15000)));
  cards.addAll(List.filled(10, Card("Bank Account", 10000)));
  cards.addAll(List.filled(10, Card("Coin Collection", 10000)));
  cards.addAll(List.filled(10, Card("Stocks", 10000)));
  cards.addAll(List.filled(10, Card("Baseball Cards", 5000)));
  cards.addAll(List.filled(10, Card("Cash Mattress", 5000)));
  cards.addAll(List.filled(10, Card("Stamp Collection", 5000)));
  cards.addAll(List.filled(10, Card("Piggy Bank", 5000)));
  return cards;
}

List<Row> getRowList() {
  final cards = generateCards();
  final rowList = List<Row>.empty(growable: true);
  while (cards.isNotEmpty) {
    final newCards = cards
            .take(3)
            .map((card) => PlayingCard(card.name, card.amount))
            .toList();
      rowList.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: newCards
      ),
    );
    cards.removeRange(0, newCards.length);
  }
  return rowList;
}
