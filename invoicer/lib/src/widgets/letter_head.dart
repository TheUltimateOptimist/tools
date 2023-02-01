import 'package:pdf/widgets.dart' hide Theme;
import 'package:invoicer/src/config.dart';
import 'package:invoicer/src/theme.dart';

class LetterHead extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [_CompanyAddress()]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CustomerAddress(),
            _InvoiceMetaData(),
          ],
        )
      ],
    );
  }
}

class _CompanyAddress extends StatelessWidget {
  @override
  Widget build(Context context) {
    final address = company.address;
    return Text(
      "${company.name} - ${address.street} - ${address.plz} ${address.city}",
      style: theme.companyAddress,
    );
  }
}

class _CustomerAddress extends StatelessWidget {
  @override
  Widget build(Context context) {
    final style = theme.customerAddress;
    final lineSpacing = theme.lineSpacing.middle;
    final address = [customer.name, ...customer.address.toList()];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: address
          .map(
            (line) => Container(
              margin: EdgeInsets.symmetric(vertical: lineSpacing),
              child: Text(line, style: style),
            ),
          )
          .toList(),
    );
  }
}

class _InvoiceMetaData extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Container(
      width: 170,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _InvoiceId(),
          _MetaData("Rechnungsdatum", invoice.invoiceDate),
          _MetaData("Lieferdatum", invoice.deliveryDate),
          Container(height: 10),
          _MetaData("Ihre Kundennummer", customer.customerId),
          _MetaData("Ihr Ansprechpartner", customer.contactPerson),
        ],
      ),
    );
  }
}

class _InvoiceId extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Rechnungs-Nr.", style: theme.invoiceId),
      Text("RE-${invoice.id}", style: theme.invoiceId),
    ]);
  }
}

class _MetaData extends StatelessWidget {
  _MetaData(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(Context context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: theme.lineSpacing.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.invoiceMetaData),
          Text(value, style: theme.invoiceMetaData),
        ],
      ),
    );
  }
}
