import 'dart:convert';

import 'package:chitter/models/PostModel.dart';
import 'package:chitter/services/dio_config.dart';
import 'package:chitter/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestAPI {
  final Dio _dio = DioConfig.dio;
  final Dio _dioWithAuth = DioConfig.dioWithAuth;

  registerUser(data, BuildContext context) async {
    try {
      final resp = await _dio.post('register', data: jsonEncode(data));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        if (e.response?.data?.containsKey('message')) {
          Utility().logger.e(e.response?.data?['message']);
          Utility.showAlertDialog(
              context, "error", e.response?.data?['message']);
        } else {
          Utility().logger.e("ไม่สามารถดำเนินการได้ กรุณาลองใหม่อีกครั้ง");
        }
      } else {
        Utility.showAlertDialog(context, "error", e.response?.data?['message']);
      }
    }
  }

  loginUser(data, BuildContext context) async {
    try {
      final resp = await _dio.post('login', data: jsonEncode(data));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      if (e.response?.data?.containsKey('message')) {
        Utility().logger.e(e.response?.data?['message']);
        Utility.showAlertDialog(context, "error", e.response?.data?['message']);
      } else {
        Utility.showAlertDialog(
            context, "error", "เกิดข้อผิดพลาดบางอย่างโปรดลองอีกครั้งภายหลัง !");
        Utility().logger.e(e.response?.data);
      }
    }
  }

  CurUser(data) async {
    try {
      final resp = await _dio.post('checkCurUser',options:Options(
        headers:{
          "authtoken":data,
        }
      ));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      if (e.response?.data?.containsKey('message')) {
        Utility().logger.e(e.response?.data?['message']);
      }else{
        Utility().logger.e(e.response?.data);
      }
    }
  }

  Future<List<PostModel>> getFeeds() async {
    final response = await _dioWithAuth.get('posts/feed');

    if(response.statusCode == 200){
      final List<PostModel> feeds = postModelFromJson(json.encode(response.data));
      return feeds;
    }

    throw Exception("Failed to load Posts");
  }
}
