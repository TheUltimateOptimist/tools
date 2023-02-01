import 'package:invoicer/src/theme.dart';
import 'package:pdf/widgets.dart' hide Theme;

import 'package:invoicer/src/config.dart';

class Footer extends StatelessWidget {
  Footer();

  @override
  Widget build(Context context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PageNumber(context.pageNumber, context.pagesCount),
        Container(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final dataSet in company.footerData())
              _InformationColumn(dataSet),
          ],
        ),
      ],
    );
  }
}

class _PageNumber extends StatelessWidget {
  _PageNumber(this.current, this.max);

  final int current;
  final int max;

  @override
  Widget build(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Seite $current von $max", style: theme.pageNumber)
      ],
    );
  }
}

class _InformationColumn extends StatelessWidget {
  _InformationColumn(this.content);

  final List<String> content;

  @override
  Widget build(Context context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: content.map((text) => Text(text, style: theme.footerText)).toList(),
    );
  }
}
