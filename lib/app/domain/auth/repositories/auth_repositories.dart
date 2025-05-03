import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract class AuthRepositories {
  Future<Either<Failure, RegisterResponse>> login(
      {required RegisterRequest registerRequest});
  Future<Either<Failure, List<String>>> logout();
  Future<Either<Failure, UserEntity>> profile();
  Future<Either<Failure, RegisterResponse>> register(
      {required RegisterRequest registerRequest});
}
