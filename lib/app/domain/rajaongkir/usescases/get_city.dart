import 'package:ajs_cell_app/app/data/rajaongkir/datasources/rajaongkir_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/model/city_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';

class GetCity {
  final RajaongkirRemoteDatasource remoteDatasource;
  GetCity(this.remoteDatasource);

  Future<Either<Failure, List<CityEntities>>> call({required int id}) {
    return remoteDatasource.getCities(id: id);
  }
}
