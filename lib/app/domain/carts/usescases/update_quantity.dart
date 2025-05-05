import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/carts_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateQuantity {
  final CartsRepositories repositories;
  UpdateQuantity(this.repositories);

  Future<Either<Failure, bool>> call({required int id, required int quantity}) {
    return repositories.updateQuantity(id: id, quantity: quantity);
  }
}
