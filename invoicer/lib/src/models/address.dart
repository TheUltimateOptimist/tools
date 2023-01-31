import 'dart:convert';

class Address {
  final String street;
  final String plz;
  final String city;
  final String country;
  Address({
    required this.street,
    required this.plz,
    required this.city,
    required this.country,
  });

  Address copyWith({
    String? street,
    String? plz,
    String? city,
    String? country,
  }) {
    return Address(
      street: street ?? this.street,
      plz: plz ?? this.plz,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  List<String> toList(){
    return [
      street,
      "$plz $city",
      country,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'plz': plz,
      'city': city,
      'country': country,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      plz: map['plz'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(street: $street, plz: $plz, city: $city, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Address &&
      other.street == street &&
      other.plz == plz &&
      other.city == city &&
      other.country == country;
  }

  @override
  int get hashCode {
    return street.hashCode ^
      plz.hashCode ^
      city.hashCode ^
      country.hashCode;
  }
}
