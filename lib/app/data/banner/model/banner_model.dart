import 'dart:convert';

class BannerModel {
  final Meta? meta;
  final List<BannerEntities>? data;

  BannerModel({this.meta, this.data});

  factory BannerModel.fromRawJson(String str) =>
      BannerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<BannerEntities>.from(
                json["data"].map((x) => BannerEntities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.map((x) => x.toJson()).toList(),
      };
}
class IklanModel {
  final Meta? meta;
  final BannerEntities? data;

  IklanModel({this.meta, this.data});

  factory IklanModel.fromJson(Map<String, dynamic> json) => IklanModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : BannerEntities.fromJson(json["data"]),
      );
}

class BannerEntities {
  final int? id;
  final String? title;
  final String? image;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BannerEntities({
    this.id,
    this.title,
    this.image,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerEntities.fromJson(Map<String, dynamic> json) =>
      BannerEntities(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Meta {
  final int? code;
  final String? status;
  final String? message;

  Meta({this.code, this.status, this.message});

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
