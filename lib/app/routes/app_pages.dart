import 'package:ajs_cell_app/app/modules/auth/register/bindings/auth_binding.dart';
import 'package:ajs_cell_app/app/modules/home/bindings/profile_binding.dart';
import 'package:get/get.dart';

import '../modules/auth/loading/bindings/loading_binding.dart';
import '../modules/auth/loading/views/loading_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/splash/bindings/splash_binding.dart';
import '../modules/auth/splash/views/splash_view.dart';
import '../modules/auth/welcome/bindings/welcome_binding.dart';
import '../modules/auth/welcome/views/welcome_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/screen/katagori/detail_katagori/bindings/detail_katagori_binding.dart';
import '../modules/home/screen/katagori/detail_katagori/views/list_detail_katagori_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      bindings: [AuthBinding(), HomeBinding(), ProfileBinding()],
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(name: _Paths.LOGIN, page: () => const LoginView(), bindings: [
      AuthBinding(),
      LoginBinding(),
    ]),
    GetPage(name: _Paths.REGISTER, page: () => const RegisterView(), bindings: [
      AuthBinding(),
      RegisterBinding(),
    ]),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.VOCHER,
      page: () => const ListDetailKatagoriView(),
      binding: DetailKatagoriBinding(),
    ),
  ];
}
