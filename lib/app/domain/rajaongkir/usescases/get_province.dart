import 'package:ajs_cell_app/app/data/rajaongkir/model/province_model.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/datasources/rajaongkir_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';

class GetProvince {
  final RajaongkirRemoteDatasource remoteDatasource;
  GetProvince(this.remoteDatasource);

  Future<Either<Failure, List<ProvinceEntities>>> call() {
    return remoteDatasource.getProvince();
  }
}
