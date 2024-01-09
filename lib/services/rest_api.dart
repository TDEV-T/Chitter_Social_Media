import 'dart:convert';

import 'package:chitter/services/dio_config.dart';
import 'package:chitter/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestAPI {
  final Dio _dio = DioConfig.dio;

  Future<String> registerUser(data, BuildContext context) async {
    try {
      final resp = await _dio.post('register', data: jsonEncode(data));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        if (e.response?.data?.containsKey('message')) {
          Utility().logger.e(e.response?.data?['message']);
          Utility.showAlertDialog(context, "error", e.response?.data?['message']);
        } else {
          Utility().logger.e("ไม่สามารถดำเนินการได้ กรุณาลองใหม่อีกครั้ง");
        }
      } else {
        Utility.showAlertDialog(context, "error", e.response?.data?['message']);
      }
      return "";
    }
  }
}
