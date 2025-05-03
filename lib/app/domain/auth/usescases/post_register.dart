import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../repositories/repositories.dart';

class PostRegister {
  final AuthRepositories repositories;
  PostRegister(this.repositories);

  Future<Either<Failure, RegisterResponse>> call(
      RegisterRequest registerRequest) {
    return repositories.register(registerRequest: registerRequest);
  }
}
