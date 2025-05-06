import 'dart:convert';

class HistoryModel {
  final Meta? meta;
  final List<HistoryEntities>? data;

  HistoryModel({
    this.meta,
    this.data,
  });

  factory HistoryModel.fromRawJson(String str) =>
      HistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<HistoryEntities>.from(
                json["data"]!.map((x) => HistoryEntities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HistoryEntities {
  final String? totalAmount;
  final String? status;
  final DateTime? completedAt;
  final String? name;
  final String? address;

  HistoryEntities({
    this.totalAmount,
    this.status,
    this.completedAt,
    this.name,
    this.address,
  });

  factory HistoryEntities.fromRawJson(String str) =>
      HistoryEntities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryEntities.fromJson(Map<String, dynamic> json) =>
      HistoryEntities(
        totalAmount: json["total_amount"],
        status: json["status"],
        completedAt: json["completed_at"] == null
            ? null
            : DateTime.parse(json["completed_at"]),
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "status": status,
        "completed_at": completedAt?.toIso8601String(),
        "name": name,
        "address": address,
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
