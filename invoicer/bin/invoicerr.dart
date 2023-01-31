import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';

class Color {
  static final footerText = PdfColor.fromHex("707070");
}

void main(List<String> args) async {
  final logoBytes = File("ressources/logo.jpg").readAsBytesSync();
  final logo = MemoryImage(logoBytes);
  print("Hello");
  final pdf = Document();
  pdf.addPage(
    // Page(
    //   pageFormat: PdfPageFormat.a4,
    //   build: (context) {
    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Logo(logo),
    //         Header(),
    //         Expanded(
    //           child: Align(alignment: Alignment.bottomCenter, child: Footer()),
    //         ),
    //       ],
    //     );
    //   },
    // ),
    MultiPage(build: (context) {
      return [Text("sometext")];
    },footer: (context) => Footer(),)
  );
  final file = File("example.pdf");
  await file.writeAsBytes(await pdf.save());
}

class Footer extends StatelessWidget {
  static const footerData = [
    [
      "Digital Confidence",
      "Mittelbergstrasse 27",
      "36251 Bad Hersfeld",
      "Deutschland",
    ],
    [
      "Tel: +49 15730026426",
      "E-Mail: digitalConfidence@web.de",
      "Web: www.digital-confidence.de"
    ],
    ["Ust.-ID: DE343223056", "Inhaber: Jonathan Dück"],
    [
      "VR-Bank NordRhön eG",
      "Konto: 7112416",
      "BLZ: 53061230",
      "IBAN: DE34 5306 1230 0007 1124 16",
      "BIC: GENODEF1HUE"
    ]
  ];

  @override
  Widget build(Context context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PageNumber(context.pageNumber, context.pagesCount),
        Container(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final dataSet in footerData) InformationColumn(dataSet),
          ],
        ),
      ],
    );
  }
}

class InformationColumn extends StatelessWidget {
  InformationColumn(this.content);

  final List<String> content;

  @override
  Widget build(Context context) {
    final style = TextStyle(fontSize: 8, color: Color.footerText);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: content.map((text) => Text(text, style: style)).toList(),
    );
  }
}

class PageNumber extends StatelessWidget {
  PageNumber(this.current, this.max);

  final int current;
  final int max;

  @override
  Widget build(Context context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text("Seite $current von $max", style: TextStyle(fontSize: 8))
    ]);
  }
}

class Logo extends StatelessWidget {
  Logo(this.image);

  final ImageProvider image;

  @override
  Widget build(Context context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Image(image, height: 50)]);
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [HeaderLeft(), HeaderRight()]);
  }
}

class Address extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Text(
      "Digital Confidence - Mittelbergstrasse 27 - 36251 Bad Hersfeld",
      style: TextStyle(fontSize: 7),
    );
  }
}

class HeaderLeft extends StatelessWidget {
  static const content = [
    "Stieber GmbH & CO. KG",
    "Hofstatt 12",
    "36282",
    "Deutschland",
  ];

  @override
  Widget build(Context context) {
    final style = TextStyle(fontSize: 10, lineSpacing: 1.5);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Address(), margin: EdgeInsets.only(bottom: 25)),
        ...content.map((text) => Text(text, style: style))
      ],
    );
  }
}

class HeaderRight extends StatelessWidget {
  @override
  Widget build(Context context) {
    final titleStyle = TextStyle(fontSize: 15);
    final subTitleStyle = TextStyle(fontSize: 11);

    return Container(
      color: Color.footerText,
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
        ],
      ),
    );
  }
}


