import 'package:ajs_cell_app/app/data/chat/entities/user_chat_entities.dart';

class ChatEntities {
  final int id;
  final String pesan;
  final DateTime createdAt;
  final String type;
  final UserChatEntities user;

  ChatEntities({
    required this.type,
    required this.id,
    required this.pesan,
    required this.createdAt,
    required this.user,
  });

  factory ChatEntities.fromJson(Map<String, dynamic> json) {
    return ChatEntities(
      id: json['id'] ?? 0,
      pesan: json['pesan'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      user: UserChatEntities.fromJson(json['user']),
      type: json['type'],
    );
  }
}
