import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/address/datasources/address_remote_datasource.dart';
import 'package:dartz/dartz.dart';

class DeleteAddress {
  final AddressRemoteDatasource remoteDatasource;
  DeleteAddress(this.remoteDatasource);

  Future<Either<Failure, bool>> call({required int id}) {
    return remoteDatasource.deleteAddress(id: id);
  }
}
