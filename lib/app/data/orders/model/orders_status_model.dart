import 'dart:convert';

class OrdersStatusModel {
    final Meta? meta;
    final List<OrderStatusEntities>? data;

    OrdersStatusModel({
        this.meta,
        this.data,
    });

    factory OrdersStatusModel.fromRawJson(String str) => OrdersStatusModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrdersStatusModel.fromJson(Map<String, dynamic> json) => OrdersStatusModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<OrderStatusEntities>.from(json["data"]!.map((x) => OrderStatusEntities.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class OrderStatusEntities {
    final int? id;
    final String? userId;
    final String? totalAmount;
    final String? addressId;
    final String? merchantOrderId;
    final String? paymentUrl;
    final String? vaNumber;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    OrderStatusEntities({
        this.id,
        this.userId,
        this.totalAmount,
        this.addressId,
        this.merchantOrderId,
        this.paymentUrl,
        this.vaNumber,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory OrderStatusEntities.fromRawJson(String str) => OrderStatusEntities.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderStatusEntities.fromJson(Map<String, dynamic> json) => OrderStatusEntities(
        id: json["id"],
        userId: json["user_id"].toString(),
        totalAmount: json["total_amount"].toString(),
        addressId: json["address_id"].toString(),
        merchantOrderId: json["merchant_order_id"],
        paymentUrl: json["payment_url"],
        vaNumber: json["va_number"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_amount": totalAmount,
        "address_id": addressId,
        "merchant_order_id": merchantOrderId,
        "payment_url": paymentUrl,
        "va_number": vaNumber,
        "status": status,
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
