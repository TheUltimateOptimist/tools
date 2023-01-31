import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:invoicer/src/models/product.dart';

class Invoice {
  final String invoiceDate;
  final String deliveryDate;
  final int id;
  final double pricePerHour;
  final String introduction;
  final String closingText;
  final List<Product> products;
  Invoice({
    required this.invoiceDate,
    required this.deliveryDate,
    required this.id,
    required this.pricePerHour,
    required this.introduction,
    required this.closingText,
    required this.products,
  });

  double getTotal(){
  double total = 0;
  for(final product in products){
    total+=product.amount*(product.pricePerHour ?? pricePerHour);
  }
  return total;
}

  Invoice copyWith({
    String? invoiceDate,
    String? deliveryDate,
    int? id,
    double? pricePerHour,
    String? introduction,
    String? closingText,
    List<Product>? products,
  }) {
    return Invoice(
      invoiceDate: invoiceDate ?? this.invoiceDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      id: id ?? this.id,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      introduction: introduction ?? this.introduction,
      closingText: closingText ?? this.closingText,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceDate': invoiceDate,
      'deliveryDate': deliveryDate,
      'id': id,
      'pricePerHour': pricePerHour,
      'introduction': introduction,
      'closingText': closingText,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      invoiceDate: map['invoiceDate'] ?? '',
      deliveryDate: map['deliveryDate'] ?? '',
      id: map['id']?.toInt() ?? 0,
      pricePerHour: map['pricePerHour']?.toDouble() ?? 0.0,
      introduction: map['introduction'] ?? '',
      closingText: map['closingText'] ?? '',
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) => Invoice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Invoice(invoiceDate: $invoiceDate, deliveryDate: $deliveryDate, id: $id, pricePerHour: $pricePerHour, introduction: $introduction, closingText: $closingText, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Invoice &&
      other.invoiceDate == invoiceDate &&
      other.deliveryDate == deliveryDate &&
      other.id == id &&
      other.pricePerHour == pricePerHour &&
      other.introduction == introduction &&
      other.closingText == closingText &&
      listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return invoiceDate.hashCode ^
      deliveryDate.hashCode ^
      id.hashCode ^
      pricePerHour.hashCode ^
      introduction.hashCode ^
      closingText.hashCode ^
      products.hashCode;
  }
}
