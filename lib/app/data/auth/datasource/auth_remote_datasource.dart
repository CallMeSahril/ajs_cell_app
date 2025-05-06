import 'dart:io';

import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/core/utils/network_checker.dart';
import 'package:ajs_cell_app/app/data/auth/model/register_model.dart';
import 'package:ajs_cell_app/app/data/auth/model/user_model.dart';
import 'package:ajs_cell_app/app/domain/auth/entities/register_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasource {
  final ApiHelper apiHelper = ApiHelper();
  Future<Either<Failure, bool>> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.path.split("/").last,
          ),
      });

      final response = await apiHelper.post('/me/update', data: formData);

      final status = response.data["meta"]["code"];
      if (status == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure("Gagal update profile"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, RegisterModel>> register(
      RegisterRequest registerRequest) async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response =
          await apiHelper.post('/register', data: registerRequest.toJson());
      final data = response.data['data']; // data is a Map, not a List
      final result = RegisterModel.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, RegisterModel>> login(
      RegisterRequest registerRequest) async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response =
          await apiHelper.post('/login', data: registerRequest.toJson());
      final data = response.data['data']; // data is a Map, not a List
      final result = RegisterModel.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> profile() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await apiHelper.get('/me');

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data profile tidak ditemukan"));
      }

      final data = response.data['data'];
      print(data);
      final result = UserModel.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
