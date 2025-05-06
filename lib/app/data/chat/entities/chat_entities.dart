import 'package:ajs_cell_app/app/data/chat/entities/user_chat_entities.dart';

class ChatEntities {
  final int id;
  final String pesan;
  final DateTime createdAt;
  final UserChatEntities user;

  ChatEntities({
    required this.id,
    required this.pesan,
    required this.createdAt,
    required this.user,
  });

  factory ChatEntities.fromJson(Map<String, dynamic> json) {
    return ChatEntities(
      id: json['id'],
      pesan: json['pesan'],
      createdAt: DateTime.parse(json['created_at']),
      user: UserChatEntities.fromJson(json['user']),
    );
  }
}
