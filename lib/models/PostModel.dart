// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? userId;
  String? content;
  String? image;
  bool? public;
  List<Comment>? likes;
  List<Comment>? comments;
  User? user;

  PostModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.content,
    this.image,
    this.public,
    this.likes,
    this.comments,
    this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    userId: json["UserID"],
    content: json["content"],
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
  dynamic sentChats;
  dynamic receivedChats;

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
    this.sentChats,
    this.receivedChats,
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
    sentChats: json["SentChats"],
    receivedChats: json["ReceivedChats"],
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
    "SentChats": sentChats,
    "ReceivedChats": receivedChats,
  };
}
