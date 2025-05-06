import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/chat/datasources/chat_remote_datasource.dart';
import 'package:dartz/dartz.dart';
class SendChat {
  final ChatRemoteDataSource repo = ChatRemoteDataSource();
  Future<Either<Failure, String>> call(String pesan) => repo.sendChat(pesan);
}
