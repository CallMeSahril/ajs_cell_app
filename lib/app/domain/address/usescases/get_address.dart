import 'package:ajs_cell_app/app/data/address/datasources/address_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';

class GetAddress {
  final AddressRemoteDatasource remoteDatasource;
  GetAddress(this.remoteDatasource);

  Future<Either<Failure, List<AddressEntities>>> call() {
    return remoteDatasource.getAddress();
  }
}
