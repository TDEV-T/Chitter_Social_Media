import 'dart:convert';

import 'package:chitter/models/PostModel.dart';
import 'package:chitter/models/UserModel.dart';



class SearchModel{
  List<UserModel>? userFind;
  List<PostModel>? postFind;


  SearchModel({
    this.userFind,
    this.postFind,
});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    userFind: json["postFind"] == null ? [] : List<UserModel
    >.from(json["Likes"]!.map((x) => Comment.fromJson(x))),
  );

}