import 'dart:convert';

import 'package:chitter/services/dio_config.dart';
import 'package:chitter/utils/utils.dart';
import 'package:dio/dio.dart';

class RestAPI {
  final Dio _dio = DioConfig.dio;

  registerUser(data) async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({'message': "Not Connection Network"});
    } else {
      try {
        final resp = await _dio.post('register', data: jsonEncode(data));
        Utility().logger.e(resp.data);
        return jsonEncode(resp.data);
      } catch (e) {
        Utility().logger.e(e);
        throw e;
      }
    }
  }
}
