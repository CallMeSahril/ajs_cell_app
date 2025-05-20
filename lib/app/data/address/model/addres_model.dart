import 'dart:convert';

class AddressModel {
  final Meta? meta;
  final List<AddressEntities>? data;

  AddressModel({
    this.meta,
    this.data,
  });

  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<AddressEntities>.from(
                json["data"]!.map((x) => AddressEntities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AddressEntities {
  final int? id;
  final String? userId;
  final String? name;
  final String? phone;
  final String? address;
  final String? city;
  final String? province;
  final String? cityId;
  final String? provinceId;
  final String? posKode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddressEntities({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.address,
    this.posKode,
    this.city,
    this.province,
    this.cityId,
    this.provinceId,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressEntities.fromRawJson(String str) =>
      AddressEntities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressEntities.fromJson(Map<String, dynamic> json) =>
      AddressEntities(
        id: json["id"],
        userId: json["user_id"].toString()  ,
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        province: json["province"],
        cityId: json["city_id"].toString(),
        provinceId: json["province_id"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "province": province,
        "city_id": cityId,
        "province_id": provinceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Meta {
  final int? code;
  final String? status;
  final String? message;

  Meta({
    this.code,
    this.status,
    this.message,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
