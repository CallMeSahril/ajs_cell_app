
class UserChatEntities {
  final int id;
  final String name;
  final String email;
  final String phone;

  UserChatEntities({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserChatEntities.fromJson(Map<String, dynamic> json) {
    return UserChatEntities(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}