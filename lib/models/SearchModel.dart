// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:chitter/models/PostModel.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

// String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  List<PostModel>? postFind;
  List<User>? userFind;

  SearchModel({
    this.postFind,
    this.userFind,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    postFind: json["postFind"] == null ? [] : List<PostModel>.from(json["postFind"]!.map((x) => PostModel.fromJson(x))),
    userFind: json["userFind"] == null ? [] : List<User>.from(json["userFind"]!.map((x) => User.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "postFind": postFind == null ? [] : List<dynamic>.from(postFind!.map((x) => x.toJson())),
  //   "userFind": userFind == null ? [] : List<dynamic>.from(userFind!.map((x) => x.toJson())),
  // };
}

class PostFind {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? userId;
  String? content;
  String? contenttype;
  String? image;
  bool? public;
  List<Comment>? likes;
  List<Comment>? comments;
  User? user;

  PostFind({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.content,
    this.contenttype,
    this.image,
    this.public,
    this.likes,
    this.comments,
    this.user,
  });

  factory PostFind.fromJson(Map<String, dynamic> json) => PostFind(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    userId: json["UserID"],
    content: json["content"],
    contenttype: json["contenttype"],
    image: json["Image"],
    public: json["public"],
    likes: json["Likes"] == null ? [] : List<Comment>.from(json["Likes"]!.map((x) => Comment.fromJson(x))),
    comments: json["Comments"] == null ? [] : List<Comment>.from(json["Comments"]!.map((x) => Comment.fromJson(x))),
    user: json["User"] == null ? null : User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "UserID": userId,
    "content": content,
    "contenttype": contenttype,
    "Image": image,
    "public": public,
    "Likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x.toJson())),
    "Comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "User": user?.toJson(),
  };
}

class Comment {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? userId;
  int? pid;
  String? content;
  User? user;

  Comment({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.pid,
    this.content,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    userId: json["UserID"],
    pid: json["pid"],
    content: json["content"],
    user: json["User"] == null ? null : User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "UserID": userId,
    "pid": pid,
    "content": content,
    "User": user?.toJson(),
  };
}

class User {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? username;
  String? password;
  String? fullname;
  String? email;
  String? profilepicture;
  String? coverfilepicture;
  String? bio;
  bool? privateAccount;
  String? role;
  dynamic posts;
  dynamic likes;
  dynamic comments;
  dynamic followers;
  dynamic blockedUsers;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.profilepicture,
    this.coverfilepicture,
    this.bio,
    this.privateAccount,
    this.role,
    this.posts,
    this.likes,
    this.comments,
    this.followers,
    this.blockedUsers,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    username: json["username"],
    password: json["password"],
    fullname: json["fullname"],
    email: json["email"],
    profilepicture: json["profilepicture"],
    coverfilepicture: json["coverfilepicture"],
    bio: json["bio"],
    privateAccount: json["PrivateAccount"],
    role: json["Role"],
    posts: json["Posts"],
    likes: json["Likes"],
    comments: json["Comments"],
    followers: json["Followers"],
    blockedUsers: json["BlockedUsers"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "username": username,
    "password": password,
    "fullname": fullname,
    "email": email,
    "profilepicture": profilepicture,
    "coverfilepicture": coverfilepicture,
    "bio": bio,
    "PrivateAccount": privateAccount,
    "Role": role,
    "Posts": posts,
    "Likes": likes,
    "Comments": comments,
    "Followers": followers,
    "BlockedUsers": blockedUsers,
  };
}
