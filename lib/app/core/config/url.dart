import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String baseUrl = dotenv.env['BASE_URL']!;
  }