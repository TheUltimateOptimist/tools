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
      style: Theme.of(context).companyAddress,
    );
  }
}

class _CustomerAddress extends StatelessWidget {
  @override
  Widget build(Context context) {
    final style = Theme.of(context).customerAddress;
    final lineSpacing = Theme.of(context).lineSpacing.middle;
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
    final style = Theme.of(context).invoiceId;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Rechnungs-Nr.", style: style),
      Text("RE-${invoice.id}", style: style),
    ]);
  }
}

class _MetaData extends StatelessWidget {
  _MetaData(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(Context context) {
    final style = Theme.of(context).invoiceMetaData;
    final lineSpacing = Theme.of(context).lineSpacing.large;
    return Container(
      margin: EdgeInsets.symmetric(vertical: lineSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
