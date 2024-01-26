import 'dart:convert';
import 'dart:io';

import 'package:chitter/models/PostModel.dart';
import 'package:chitter/models/UserModel.dart';
import 'package:chitter/services/dio_config.dart';
import 'package:chitter/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class RestAPI {
  final Dio _dio = DioConfig.dio;
  final Dio _dioWithAuth = DioConfig.dioWithAuth;

  registerUser(data, BuildContext context) async {
    if (await Utility.checkNetwork() == '') {
      throw ("Please Connect Internet !");
    } else {
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
          Utility.showAlertDialog(
              context, "error", e.response?.data?['message']);
        }
      }
    }
  }

  loginUser(data, BuildContext context) async {
    if (await Utility.checkNetwork() == '') {
      throw ("Please Connect Internet !");
    } else {
      try {
        final resp = await _dio.post('login', data: jsonEncode(data));
        return jsonEncode(resp.data);
      } on DioException catch (e) {
        if (e.response?.data?.containsKey('message')) {
          Utility().logger.e(e.response?.data?['message']);
          Utility.showAlertDialog(
              context, "error", e.response?.data?['message']);
        } else {
          Utility.showAlertDialog(context, "error",
              "เกิดข้อผิดพลาดบางอย่างโปรดลองอีกครั้งภายหลัง !");
          Utility().logger.e(e.response?.data);
        }
      }
    }
  }

  CurUser(data) async {
    try {
      final resp = await _dio.post('checkCurUser',
          options: Options(headers: {
            "authtoken": data,
          }));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      if (e.response?.data?.containsKey('message')) {
        Utility().logger.e(e.response?.data?['message']);
      } else {
        Utility().logger.e(e.response?.data);
      }
    }
  }

  Future<List<PostModel>> getFeeds(String typefeed) async {
    Response response;
    if (typefeed == "public") {
      response = await _dioWithAuth.get('posts/feed');
    } else {
      response = await _dioWithAuth.get("posts/follower");
    }

    if (response.statusCode == 200) {
      final List<PostModel> feeds =
          postModelFromJson(json.encode(response.data));
      return feeds;
    }

    throw Exception("Failed to load Posts");
  }

  Future<PostModel> getPostById(int id) async {
    var resp = await _dioWithAuth.get("/posts/" + id.toString());

    if (resp.statusCode == 200) {
      final PostModel post = postOneModelFromJson(json.encode(resp.data));
      return post;
    }

    throw Exception("Fail to Load Data");
  }

  Future<String> createPost(String content, List<XFile>? imageFiles) async {
    var formData = FormData();

    formData.fields.add(MapEntry('content', content));
    if (imageFiles != null && imageFiles.isNotEmpty) {
      for (var imgfile in imageFiles) {
        if (imgfile != null) {
          var multipartFile = await MultipartFile.fromFile(imgfile.path,
              filename: imgfile.name);
          formData.files.add(MapEntry('file', multipartFile));
        }
      }
    }

    try {
      final resp = await _dioWithAuth.post('posts', data: formData);
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Post");
    }
  }

  Future<String> createPostVideoContent(String content, File? video) async {
    var formData = FormData();

    formData.fields.add(MapEntry('content', content));

    if (video != null) {
      var multipartFile = await MultipartFile.fromFile(video.path,
          filename: video.path.split('/').last);
      formData.files.add(MapEntry('file', multipartFile));
      formData.fields.add(const MapEntry('contenttype', 'video'));
    }

    try {
      final resp = await _dioWithAuth.post('posts', data: formData);
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Post");
    }
  }

  Future<String> createComment(data) async {
    try {
      final resp = await _dioWithAuth.post('comment', data: jsonEncode(data));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Post");
    }
  }

  Future<String> likePost(data) async {
    try {
      final resp = await _dioWithAuth.post("like", data: jsonEncode(data));
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Like Post");
    }
  }

  Future<String> dislikePost(int pid) async {
    try {
      final resp = await _dioWithAuth.post("like/unlike/" + pid.toString());
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't  Unlike Post");
    }
  }

  getUserById(int uid) async {
    try {
      final resp = await _dioWithAuth.get("users/$uid");

      final UserModel usr = userModelFromJson(json.encode(resp.data));
      return usr;
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Get user Data");
    }
  }

  Future<String> updatePost(int pid, String content, List<XFile>? imageFiles,
      String currentImage) async {
    var formData = FormData();
    formData.fields.add(MapEntry('imageCurrent', currentImage));
    formData.fields.add(MapEntry('content', content));
    if (imageFiles != null && imageFiles.isNotEmpty) {
      for (var imgfile in imageFiles) {
        if (imgfile != null) {
          var multipartFile = await MultipartFile.fromFile(imgfile.path,
              filename: imgfile.name);
          formData.files.add(MapEntry('file', multipartFile));
        }
      }
    }
    try {
      final resp = await _dioWithAuth.patch('posts/$pid', data: formData);
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Update Post");
    }
  }

  Future<String> updatePostWithVideo(
      int pid, String content, File? video) async {
    var formData = FormData();

    formData.fields.add(MapEntry('content', content));

    if (video != null) {
      var multipartFile = await MultipartFile.fromFile(video.path,
          filename: video.path.split('/').last);
      formData.files.add(MapEntry('file', multipartFile));
      formData.fields.add(const MapEntry('contenttype', 'video'));
    }

    try {
      final resp = await _dioWithAuth.patch('posts/$pid', data: formData);
      return jsonEncode(resp.data);
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Post");
    }
  }

  searchFunc(String search) async {
    try {
      final resp = await _dioWithAuth.post("search",
          data: jsonEncode({"search": search}));
    } on DioException catch (e) {
      Utility().logger.e(e);
      throw ("Can't Get Search Data");
    }
  }
}
