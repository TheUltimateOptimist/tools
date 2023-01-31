import 'package:invoicer/src/models/models.dart';
import 'package:pdf/widgets.dart' show ImageProvider;

const companyPath = "data/company.json";
const logoPath = "ressources/logo.jpg";

String outputPath(){
  return "C:/Users/JDuec/OneDrive/Dokumente/Rechnungen/RE-${invoice.id}.pdf";
}

String customerPath(String name){
  return "data/$name.json";
}

String invoicePath(String name){
  return "data/$name.json";
}

late final Company company;
late final Customer customer;
late final Invoice invoice;
late final ImageProvider logo;


