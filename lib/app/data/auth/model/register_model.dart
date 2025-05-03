import '../../../domain/auth/entities/register_response.dart';
import 'user_model.dart';

class RegisterModel extends RegisterResponse {
  RegisterModel({
    super.accessToken,
    super.tokenType,
    super.user,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user: UserModel.fromJson(json['user']),
    );
  }

  RegisterResponse toEntity() {
    return RegisterResponse(
      accessToken: accessToken,
      tokenType: tokenType,
      user: (user as UserModel?)?.toEntity(), 
    );
  }
}
