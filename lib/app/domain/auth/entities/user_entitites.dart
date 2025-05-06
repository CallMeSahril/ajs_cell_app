class UserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? phone,image;
  final String? role;
  final String? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });
}
