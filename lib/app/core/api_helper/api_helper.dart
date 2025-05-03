
import 'package:ajs_cell_app/app/core/config/token.dart';
import 'package:ajs_cell_app/app/core/config/url.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  final Dio _dio = Dio();

  ApiHelper() {
    _dio.options.baseUrl = Config.baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add token to the headers
        AuthHelper.getToken().then((token) {
          options.headers["Authorization"] = token;
          handler.next(options);
        }).catchError((e) {
          handler.reject(DioException(
              requestOptions: options,
              response: null,
              type: DioExceptionType.connectionTimeout,
              error: e));
        });
      },
      onResponse: (response, handler) {
        handler.next(response); // Continue
      },
      onError: (DioException e, handler) {
        // Handle errors based on DioExceptionType

        String errorMessage = 'Terjadi kesalahan';

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = 'Koneksi timeout';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = 'Pengiriman timeout';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Penerimaan timeout';
            break;
          case DioExceptionType.cancel:
            errorMessage = 'Permintaan dibatalkan';
            break;
          case DioExceptionType.badResponse:
            if (e.response?.data is List) {
              errorMessage =
                  'Kesalahan Respons: ${(e.response?.data as List).map((item) => item['message']).join(", ")}';
            } else {
              errorMessage = 'Kesalahan Respons: ${e.response?.data}';
            }
            break;

          default:
            errorMessage = 'Kesalahan tidak dikenal';
            break;
        }
        handler.reject(e);
      },
    ));
  }

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {required dynamic data}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, {required dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {required dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
