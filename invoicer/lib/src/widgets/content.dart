import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' hide Theme;
import 'package:invoicer/src/theme.dart';
import 'package:invoicer/src/config.dart';

import '../models/models.dart';

extension DoubleExtension on double {
  String prettify() {
    String rounded = (this * 100).round().toString();
    String left = rounded.substring(0, rounded.length - 2);
    String right = rounded.substring(rounded.length - 2, rounded.length);
    return "$left,$right";
  }

  String toHours() {
    return "${prettify()} Std";
  }

  String toEur() {
    return "${prettify()} EUR";
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(Context context) {
    final titleStyle = Theme.of(context).title;
    final body = Theme.of(context).body;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rechnung Nr. RE-${invoice.id}\n\n", style: titleStyle),
        Text("${invoice.introduction}\n\n", style: body),
        Table(
          columnWidths: <int, FractionColumnWidth>{
            0: FractionColumnWidth(0.1),
            1: FractionColumnWidth(0.5),
            2: FractionColumnWidth(0.2),
            3: FractionColumnWidth(0.2),
            4: FractionColumnWidth(0.2)
          },
          children: [
            _columnNames(context),
            for (int i = 0; i < invoice.products.length; i++)
              _productData(context, invoice.products[i], i + 1),
            _netto(context),
            _ustgClause(context),
            _brutto(context),
          ],
        ),
        Container(height: 5),
        Text(invoice.closingText, style: body),
      ],
    );
  }
}

TableRow _columnNames(Context context) {
  final style = Theme.of(context).bodyEmphasized;
  return _ContentRow.filled(
    backgroundColor: Theme.of(context).colorScheme.textBackground,
    position: Text("Pos.", style: style),
    description: Text("Beschreibung", style: style),
    amount: Text("Menge", style: style),
    price: Text("Einzelpreis", style: style),
    total: Text("Gesamtpreis", style: style),
  );
}

TableRow _productData(Context context, Product product, int index) {
  final body = Theme.of(context).body;
  final bodyEmphasized = Theme.of(context).bodyEmphasized;
  final pricePerHour = product.pricePerHour ?? invoice.pricePerHour;
  return _ContentRow.filled(
      position: Text("$index.", style: body),
      description: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title, style: bodyEmphasized),
          if (product.subtitle != null) Container(height: 3),
          if (product.subtitle != null) Text(product.subtitle!, style: body),
        ],
      ),
      amount: Text(product.amount.toHours(), style: body),
      price: Text(pricePerHour.toEur(), style: body),
      total: Text((pricePerHour * product.amount).toEur(), style: body));
}

TableRow _netto(Context context) {
  final backgroundColor = Theme.of(context).colorScheme.textBackground;
  final style = Theme.of(context).body;
  final invisible = TextStyle(fontSize: style.fontSize, color: backgroundColor);
  return _ContentRow.filled(
    backgroundColor: backgroundColor,
    position: Text("D", style: invisible),
    description: Text("Gesamtbetrag netto", style: style),
    amount: Text("D", style: invisible),
    price: Text("D", style: invisible),
    total: Text(invoice.getTotal().toEur(), style: style),
  );
}

TableRow _brutto(Context context) {
  final backgroundColor = Theme.of(context).colorScheme.textBackground;
  final style = Theme.of(context).bodyEmphasized;
  final invisible = TextStyle(fontSize: style.fontSize, color: backgroundColor);
  return _ContentRow.filled(
    position: Text("D", style: invisible),
    backgroundColor: Theme.of(context).colorScheme.textBackground,
    description: Text("Gesamtbetrag brutto", style: style),
    amount: Text("D", style: invisible),
    price: Text("D", style: invisible),
    total: Text(invoice.getTotal().toEur(), style: style),
  );
}

TableRow _ustgClause(Context context) {
  final style = Theme.of(context).body;
  return _ContentRow.filled(
    description:
        Text("Umsatzsteuerfreie Leistungen gemäß §19 UStG.", style: style),
  );
}

class _ContentRow extends TableRow {
  _ContentRow({required super.children});
  factory _ContentRow.filled({
    Widget? position,
    Widget? description,
    Widget? amount,
    Widget? price,
    Widget? total,
    PdfColor? backgroundColor,
  }) {
    backgroundColor = backgroundColor ?? PdfColor.fromHex("ffffff");
    position = position ?? Container();
    description = description ?? Container();
    amount = amount ?? Container();
    price = price ?? Container();
    total = total ?? Container();
    position = Container(margin: EdgeInsets.only(left: 3), child: position);
    total = Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 3),
        child: total,
      ),
    );
    amount = Align(alignment: Alignment.topRight, child: amount);
    price = Align(alignment: Alignment.topRight, child: price);
    final children = [position, description, amount, price, total];
    return _ContentRow(
      children: children
          .map(
            (child) => Container(
                color: backgroundColor,
                child: child,
                padding: EdgeInsets.symmetric(vertical: 2),
                margin: EdgeInsets.only(bottom: 3)),
          )
          .toList(),
    );
  }
}
