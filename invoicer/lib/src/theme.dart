import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

final colorScheme = ColorScheme(
  footerText: PdfColor.fromHex("707070"),
  textBackground: PdfColor.fromHex("e6e6e6"),
);



final theme = ThemeData(
  colorScheme: colorScheme,
  footerText: TextStyle(color: colorScheme.footerText, fontSize: 8),
  pageNumber: TextStyle(fontSize: 8),
  companyAddress: TextStyle(fontSize: 7),
  customerAddress: TextStyle(fontSize: 10),
  invoiceId: TextStyle(fontSize: 14),
  invoiceMetaData: TextStyle(fontSize: 8),
  title: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  body: TextStyle(fontSize: 10, lineSpacing: 1.5),
  bodyEmphasized: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
  lineSpacing: LineSpacing(small: 1, middle: 1.5, large: 2),
  logoSize: 50,

);

class ThemeData extends Inherited {
  final ColorScheme colorScheme;
  final TextStyle footerText;
  final TextStyle pageNumber;
  final TextStyle companyAddress;
  final TextStyle customerAddress;
  final TextStyle invoiceId;
  final TextStyle invoiceMetaData;
  final TextStyle title;
  final TextStyle body;
  final TextStyle bodyEmphasized;
  final LineSpacing lineSpacing;
  final double logoSize;

  ThemeData({
    required this.colorScheme,
    required this.footerText,
    required this.pageNumber,
    required this.companyAddress,
    required this.customerAddress,
    required this.invoiceId,
    required this.invoiceMetaData,
    required this.title,
    required this.body,
    required this.bodyEmphasized,
    required this.lineSpacing,
    required this.logoSize,
  });
}

class ColorScheme {
  const ColorScheme({required this.footerText, required this.textBackground});
  final PdfColor footerText;
  final PdfColor textBackground;
}

class LineSpacing{
  const LineSpacing({required this.small, required this.middle, required this.large});
  final double small;
  final double middle;
  final double large;
}

class Theme extends StatelessWidget {
  Theme({
    required this.child,
  });

  final Widget child;

  static ThemeData of(Context context) {
    return context.dependsOn<ThemeData>()!;
  }

  @override
  Widget build(Context context) {
    return InheritedWidget(
      inherited: theme,
      build: (Context context) => child,
    );
  }
}
