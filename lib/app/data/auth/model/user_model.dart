import '../../../domain/auth/entities/entities.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.name,
    super.email,
    super.phone,
    super.role,
    super.image,
    super.emailVerifiedAt,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: role,
      emailVerifiedAt: emailVerifiedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      image: image
    );
  }
}
