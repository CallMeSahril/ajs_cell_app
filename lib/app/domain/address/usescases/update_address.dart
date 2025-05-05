import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/address/datasources/address_remote_datasource.dart';
import 'package:ajs_cell_app/app/domain/address/entities/create_addres_entities.dart';
import 'package:dartz/dartz.dart';

class UpdateAddress {
  final AddressRemoteDatasource remoteDatasource;
  UpdateAddress(this.remoteDatasource);

  Future<Either<Failure, bool>> call(
      {required CreateAddressEntities createAddressEntities, required int id}) {
    return remoteDatasource.updateAddress(
        id: id, createAddressEntities: createAddressEntities);
  }
}
