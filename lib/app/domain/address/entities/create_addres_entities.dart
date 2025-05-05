import 'dart:convert';

class CreateAddressEntities {
  final String? address;
  final String? city;
  final String? postalCode;
  final String? province;
  final int? provinceId;
  final int? cityId;
  final String? name;
  final String? phone;

  CreateAddressEntities({
    this.address,
    this.city,
    this.postalCode,
    this.province,
    this.provinceId,
    this.cityId,
    this.name,
    this.phone,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "postal_code": postalCode,
        "province": province,
        "province_id": provinceId,
        "city_id": cityId,
        "name": name,
        "phone": phone,
      };
}
