import 'dart:io';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/auth/datasource/auth_remote_datasource.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUsecase {
  final AuthRemoteDatasource _repo = AuthRemoteDatasource();

  Future<Either<Failure, bool>> call({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) {
    return _repo.updateProfile(
      name: name,
      email: email,
      phone: phone,
      image: image,
    );
  }
}
