import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/banner/model/banner_model.dart';
import 'package:ajs_cell_app/app/data/banner/service/banner_service.dart';
import 'package:dartz/dartz.dart';

class GetIklan {
  final BannerService _repository = BannerService();

  Future<Either<Failure, BannerEntities>> call() {
    return _repository.getIklan();
  }
}
