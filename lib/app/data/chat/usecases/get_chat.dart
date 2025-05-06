import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/chat/datasources/chat_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/chat/entities/chat_entities.dart';
import 'package:dartz/dartz.dart';

class GetChat {
  final ChatRemoteDataSource repo = ChatRemoteDataSource();
  Future<Either<Failure, List<ChatEntities>>> call() => repo.getChat();
}
