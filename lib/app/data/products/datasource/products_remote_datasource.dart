import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/core/utils/network_checker.dart';
import 'package:ajs_cell_app/app/data/products/model/products_model.dart';
import 'package:dartz/dartz.dart';

class ProductsRemoteDatasource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<ProductsModel>>> productsAll() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await apiHelper.get('/products');

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final data = response.data['data'] as List;
      final result = data.map((item) => ProductsModel.fromJson(item)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
