import 'dart:convert';

class Product {
  final String title;
  final String? subtitle;
  final double amount;
  final double? pricePerHour;
  Product({
    required this.title,
    this.subtitle,
    required this.amount,
    this.pricePerHour,
  });

  Product copyWith({
    String? title,
    String? subtitle,
    double? amount,
    double? pricePerHour,
  }) {
    return Product(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      amount: amount ?? this.amount,
      pricePerHour: pricePerHour ?? this.pricePerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'pricePerHour': pricePerHour,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] ?? '',
      subtitle: map['subtitle'],
      amount: map['amount']?.toDouble() ?? 0.0,
      pricePerHour: map['pricePerHour']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(title: $title, subtitle: $subtitle, amount: $amount, pricePerHour: $pricePerHour)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.amount == amount &&
      other.pricePerHour == pricePerHour;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      subtitle.hashCode ^
      amount.hashCode ^
      pricePerHour.hashCode;
  }
}
