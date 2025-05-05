import 'dart:convert';

class CityModel {
    final String? status;
    final String? message;
    final List<CityEntities>? data;

    CityModel({
        this.status,
        this.message,
        this.data,
    });

    factory CityModel.fromRawJson(String str) => CityModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CityEntities>.from(json["data"]!.map((x) => CityEntities.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CityEntities {
    final String? cityId;
    final String? provinceId;
    final String? province;
    final String? type;
    final String? cityName;
    final String? postalCode;

    CityEntities({
        this.cityId,
        this.provinceId,
        this.province,
        this.type,
        this.cityName,
        this.postalCode,
    });

    factory CityEntities.fromRawJson(String str) => CityEntities.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CityEntities.fromJson(Map<String, dynamic> json) => CityEntities(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
    };
}
