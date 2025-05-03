import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetProfile {
  final AuthRepositories repositories;
  GetProfile(this.repositories);

  Future<Either<Failure, UserEntity>> call() {
    return repositories.profile();
  }
}
