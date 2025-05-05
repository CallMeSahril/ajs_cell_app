import 'dart:convert';

class ProvinceModel {
  final String? status;
  final String? message;
  final List<ProvinceEntities>? data;

  ProvinceModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProvinceModel.fromRawJson(String str) =>
      ProvinceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProvinceEntities>.from(
                json["data"]!.map((x) => ProvinceEntities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProvinceEntities {
  final String? provinceId;
  final String? province;

  ProvinceEntities({
    this.provinceId,
    this.province,
  });

  factory ProvinceEntities.fromRawJson(String str) =>
      ProvinceEntities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvinceEntities.fromJson(Map<String, dynamic> json) =>
      ProvinceEntities(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };
}
