import 'dart:convert';

import 'address.dart';

class Customer {
  final String name;
  final String customerId;
  final String contactPerson;
  final Address address;
  Customer({
    required this.name,
    required this.customerId,
    required this.contactPerson,
    required this.address,
  });

  Customer copyWith({
    String? name,
    String? customerId,
    String? contactPerson,
    Address? address,
  }) {
    return Customer(
      name: name ?? this.name,
      customerId: customerId ?? this.customerId,
      contactPerson: contactPerson ?? this.contactPerson,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'customerId': customerId,
      'contactPerson': contactPerson,
      'address': address.toMap(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] ?? '',
      customerId: map['customerId'] ?? '',
      contactPerson: map['contactPerson'] ?? '',
      address: Address.fromMap(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(name: $name, customerId: $customerId, contactPerson: $contactPerson, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Customer &&
      other.name == name &&
      other.customerId == customerId &&
      other.contactPerson == contactPerson &&
      other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      customerId.hashCode ^
      contactPerson.hashCode ^
      address.hashCode;
  }
}

