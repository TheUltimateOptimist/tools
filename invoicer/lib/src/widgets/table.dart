import 'package:pdf/widgets.dart' hide Table, TableRow;

class Table extends StatelessWidget{
  Table({required this.fractionalColumnWidths, this.children});

  final List<double> fractionalColumnWidths;
  final List<TableRow>? children;

  @override
  Widget build(Context context) {
    if(children == null){
      return Container();
    }
    assert(fractionalColumnWidths.fold<double>(0, (previousValue, element) => previousValue + element) < 1.05);
    assert(fractionalColumnWidths.fold<double>(0, (previousValue, element) => previousValue + element) > 0.95);
    assert(fractionalColumnWidths.every((element) => element > 0 && element < 1));
    assert(children!.every((tableRow) => tableRow.children != null));
    assert(children!.every((tableRow) => tableRow.children!.length == fractionalColumnWidths.length));
    final totalWidth = context.page.pageFormat.availableWidth;
    return Column(mainAxisSize: MainAxisSize.min,children: [
      for(final tableRow in children!)
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for(int i = 0; i < fractionalColumnWidths.length; i++)
            Container(width: fractionalColumnWidths[i]*totalWidth, child: tableRow.children![i])
        ])
    ]);

  }
}

class TableRow{
  TableRow({this.children});

  final List<Widget?>? children;
}