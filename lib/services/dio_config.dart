import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:dio/dio.dart';

class DioConfig {
  static final Dio _dio = Dio()
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Accept'] = 'application/json';
      options.headers['Content-Type'] = 'application/json';
      options.baseUrl = urlAPI;

      return handler.next(options);
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (DioException e, handler) async {
      switch (e.response?.statusCode) {
        case 400:
          Utility().logger.e("Bad Request");
          break;
        case 401:
          Utility().logger.e("Unauthorized");
          break;
        case 403:
          Utility().logger.e("Forbidden");
          break;
        case 404:
          Utility().logger.e("Not Found");
          break;
        case 500:
          Utility().logger.e("Internal Server Error");
          break;
        default:
          Utility().logger.e("Something went wrong !");
          break;
      }
      return handler.next(e);
    }));

  static Dio get dio => _dio;
}
