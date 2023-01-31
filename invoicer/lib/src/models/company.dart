import 'dart:convert';

import 'address.dart';

class Company {
  final String name;
  final Address address;
  final String tel;
  final String email;
  final String web;
  final String ustid;
  final String owner;
  final String bankName;
  final String bankAccount;
  final String blz;
  final String iban;
  final String bic;
  Company({
    required this.name,
    required this.address,
    required this.tel,
    required this.email,
    required this.web,
    required this.ustid,
    required this.owner,
    required this.bankName,
    required this.bankAccount,
    required this.blz,
    required this.iban,
    required this.bic,
  });

  Company copyWith({
    String? name,
    Address? address,
    String? tel,
    String? email,
    String? web,
    String? ustid,
    String? owner,
    String? bankName,
    String? bankAccount,
    String? blz,
    String? iban,
    String? bic,
  }) {
    return Company(
      name: name ?? this.name,
      address: address ?? this.address,
      tel: tel ?? this.tel,
      email: email ?? this.email,
      web: web ?? this.web,
      ustid: ustid ?? this.ustid,
      owner: owner ?? this.owner,
      bankName: bankName ?? this.bankName,
      bankAccount: bankAccount ?? this.bankAccount,
      blz: blz ?? this.blz,
      iban: iban ?? this.iban,
      bic: bic ?? this.bic,
    );
  }

    List<List<String>> footerData(){
    return [
      [
        name,
        ...address.toList(),
      ],
      [
        "Tel: $tel",
        "E-Mail: $email",
        "Web: $web",
      ],
      [
        "Ust.-ID: $ustid",
        "Inhaber: $owner"
      ],
      [
        bankName,
        "Konto: $bankAccount",
        "BLZ: $blz",
        "IBAN: $iban",
        "BIC: $bic",
      ]
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address.toMap(),
      'tel': tel,
      'email': email,
      'web': web,
      'ustid': ustid,
      'owner': owner,
      'bankName': bankName,
      'bankAccount': bankAccount,
      'blz': blz,
      'iban': iban,
      'bic': bic,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'] ?? '',
      address: Address.fromMap(map['address']),
      tel: map['tel'] ?? '',
      email: map['email'] ?? '',
      web: map['web'] ?? '',
      ustid: map['ustid'] ?? '',
      owner: map['owner'] ?? '',
      bankName: map['bankName'] ?? '',
      bankAccount: map['bankAccount'] ?? '',
      blz: map['blz'] ?? '',
      iban: map['iban'] ?? '',
      bic: map['bic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company(name: $name, address: $address, tel: $tel, email: $email, web: $web, ustid: $ustid, owner: $owner, bankName: $bankName, bankAccount: $bankAccount, blz: $blz, iban: $iban, bic: $bic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Company &&
      other.name == name &&
      other.address == address &&
      other.tel == tel &&
      other.email == email &&
      other.web == web &&
      other.ustid == ustid &&
      other.owner == owner &&
      other.bankName == bankName &&
      other.bankAccount == bankAccount &&
      other.blz == blz &&
      other.iban == iban &&
      other.bic == bic;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      address.hashCode ^
      tel.hashCode ^
      email.hashCode ^
      web.hashCode ^
      ustid.hashCode ^
      owner.hashCode ^
      bankName.hashCode ^
      bankAccount.hashCode ^
      blz.hashCode ^
      iban.hashCode ^
      bic.hashCode;
  }
}
