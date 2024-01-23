import 'dart:convert';

import 'package:chitter/models/PostModel.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? profilePicture;
  String? coverfilePicture;
  String? bio;
  bool? privateAccount;
  List<PostModel>? posts;
  int? followCount;
  int? followingCount;

  UserModel({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.profilePicture,
    this.coverfilePicture,
    this.bio,
    this.privateAccount,
    this.posts,
    this.followCount,
    this.followingCount,
  });




  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["user"]["ID"],
    username: json["user"]["Username"],
    fullName: json["user"]["FullName"],
    email: json["user"]["Email"],
    profilePicture: json["user"]["ProfilePicture"],
    coverfilePicture: json["user"]["CoverfilePicture"],
    bio: json["user"]["Bio"],
    privateAccount: json["user"]["PrivateAccount"],
    posts: json["posts"] == null ? null : List<PostModel>.from(json["posts"].map((x) => PostModel.fromJson(x))),
    followCount: json["follower_count"],
    followingCount : json["following_count"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Username": username,
    "FullName": fullName,
    "Email": email,
    "ProfilePicture": profilePicture,
    "CoverfilePicture": coverfilePicture,
    "Bio": bio,
    "PrivateAccount": privateAccount,
    "Posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
  };
}



