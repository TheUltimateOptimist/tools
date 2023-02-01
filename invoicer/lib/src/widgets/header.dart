import 'package:pdf/widgets.dart' hide Theme;
import 'package:invoicer/src/config.dart';
import 'package:invoicer/src/theme.dart';

class Header extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(logo, width: theme.logoSize),
        ],
      ),
    );
  }
}