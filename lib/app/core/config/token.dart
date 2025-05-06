import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static AuthStorage? _instance;
  SharedPreferences? _prefs;
  static Future<AuthStorage> getInstance() async {
    if (_instance == null) {
      _instance = AuthStorage();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String refreshToken) async {
    print('call save token');
    print(refreshToken);
    var res = await _prefs?.setString('refresh_token', refreshToken);

    print("res :: $res");
  }

  Future<void> saveUserId(String userId) async {
    print('call save user id');
    print(userId);
    var res = await _prefs?.setString('user_id', userId);

    print("res :: $res");
  }
}

class AuthHelper {
  static Future<String?> getToken() async {
    final authStorage = await AuthStorage.getInstance();
    return authStorage._prefs?.getString('refresh_token');
  }

  static Future<String?> getUserId() async {
    final authStorage = await AuthStorage.getInstance();
    return authStorage._prefs?.getString('user_id');
  }

  static Future<void> deleteToken() async {
    final authStorage = await AuthStorage.getInstance();
    // Add your delete logic here
  }
}
