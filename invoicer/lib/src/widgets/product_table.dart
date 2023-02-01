import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' hide Table, TableRow;
import 'package:invoicer/src/widgets/table.dart';
import 'package:invoicer/src/theme.dart';
import 'package:invoicer/src/config.dart';
import 'package:invoicer/src/models/models.dart';

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

class ProductTable extends StatelessWidget{
  @override
  Widget build(Context context) {
    return Table(
          fractionalColumnWidths: [0.08333333, 0.4166666, 0.166666, 0.166666, 0.166666],
          children: [
            _columnNames(),
            for (int i = 0; i < invoice.products.length; i++)
              _productData(invoice.products[i], i + 1),
            _netto(),
            _ustgClause(),
            _brutto(),
          ],
        );
  }
}

TableRow _columnNames() {
  return _ContentRow.filled(
    backgroundColor: theme.colorScheme.textBackground,
    position: Text("Pos.", style: theme.bodyEmphasized),
    description: Text("Beschreibung", style: theme.bodyEmphasized),
    amount: Text("Menge", style: theme.bodyEmphasized),
    price: Text("Einzelpreis", style: theme.bodyEmphasized),
    total: Text("Gesamtpreis", style: theme.bodyEmphasized),
  );
}

TableRow _productData(Product product, int index) {
  final pricePerHour = product.pricePerHour ?? invoice.pricePerHour;
  return _ContentRow.filled(
      position: Text("$index.", style: theme.body),
      description: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title, style: theme.bodyEmphasized),
          if (product.subtitle != null) Container(height: 3),
          if (product.subtitle != null) Text(product.subtitle!, style: theme.body),
        ],
      ),
      amount: Text(product.amount.toHours(), style: theme.body),
      price: Text(pricePerHour.toEur(), style: theme.body),
      total: Text((pricePerHour * product.amount).toEur(), style: theme.body));
}

TableRow _netto() {
  final backgroundColor = theme.colorScheme.textBackground;
  final invisible = TextStyle(fontSize: theme.body.fontSize, color: backgroundColor);
  return _ContentRow.filled(
    backgroundColor: backgroundColor,
    position: Text("D", style: invisible),
    description: Text("Gesamtbetrag netto", style: theme.body),
    amount: Text("D", style: invisible),
    price: Text("D", style: invisible),
    total: Text(invoice.getTotal().toEur(), style: theme.body),
  );
}

TableRow _brutto() {
  final backgroundColor = theme.colorScheme.textBackground;
  final invisible = TextStyle(fontSize: theme.bodyEmphasized.fontSize, color: backgroundColor);
  return _ContentRow.filled(
    position: Text("D", style: invisible),
    backgroundColor: backgroundColor,
    description: Text("Gesamtbetrag brutto", style: theme.bodyEmphasized),
    amount: Text("D", style: invisible),
    price: Text("D", style: invisible),
    total: Text(invoice.getTotal().toEur(), style: theme.bodyEmphasized),
  );
}

TableRow _ustgClause() {
  return _ContentRow.filled(
    description:
        Text("Umsatzsteuerfreie Leistungen gemäß §19 UStG.", style: theme.body),
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