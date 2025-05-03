import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/auth/datasource/auth_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/auth/model/user_model.dart';
import 'package:ajs_cell_app/app/domain/auth/entities/register_request.dart';
import 'package:ajs_cell_app/app/domain/auth/entities/register_response.dart';
import 'package:ajs_cell_app/app/domain/auth/entities/user_entitites.dart';
import 'package:ajs_cell_app/app/domain/auth/repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepositories {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);
 
  @override
  Future<Either<Failure, UserEntity>> profile() async {
    final result = await remoteDatasource.profile();
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, RegisterResponse>> login({
    required RegisterRequest registerRequest,
  }) async {
    final result = await remoteDatasource.login(registerRequest);
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, List<String>>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RegisterResponse>> register({
    required RegisterRequest registerRequest,
  }) async {
    final result = await remoteDatasource.register(registerRequest);
    return result.map((model) => model.toEntity());
  }
}
