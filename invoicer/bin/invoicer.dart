import 'package:invoicer/invoicer.dart';

void main(List<String> args) async{
  await createPdf(customerName: args[0], invoiceName: args[1]);
  //await createCover();
}