import 'entities.dart';
class RegisterResponse {
  final String? accessToken;
  final String? tokenType;
  final UserEntity? user;

  RegisterResponse({
    this.accessToken,
    this.tokenType,
    this.user,
  });
}
