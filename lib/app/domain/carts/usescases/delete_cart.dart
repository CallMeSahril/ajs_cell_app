import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class DeleteCart {
  final CartsRepositories repositories;
  DeleteCart(this.repositories);

  Future<Either<Failure, bool>> call({required int id}) {
    return repositories.deleteCart(id: id);
  }
}
