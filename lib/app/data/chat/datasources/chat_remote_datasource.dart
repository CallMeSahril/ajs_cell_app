import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/chat/entities/chat_entities.dart';
import 'package:dartz/dartz.dart';

class ChatRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<ChatEntities>>> getChat() async {
    try {
      final response = await apiHelper.get('/chat');
      final data = response.data['data'] as List;
      final result = data.map((e) => ChatEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> sendChat(String pesan) async {
    try {
      final response = await apiHelper.post('/chat', data: {"pesan": pesan});
      final message = response.data['data'] ?? "Chat terkirim";
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}