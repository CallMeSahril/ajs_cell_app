import 'package:ajs_cell_app/app/data/auth/datasource/auth_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/auth/repositories/auth_repository_impl.dart';
import 'package:get/get.dart';

import '../../../../domain/auth/repositories/repositories.dart';
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepositories>(
      () => AuthRepositoryImpl(AuthRemoteDatasource()),
    );
  }
}
