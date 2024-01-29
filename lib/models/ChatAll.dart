// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Member> members;

  Chat({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.members,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["ID"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    members: List<Member>.from(json["Members"].map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
    "DeletedAt": deletedAt,
    "Members": List<dynamic>.from(members.map((x) => x.toJson())),
  };
}

class Member {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String username;
  String fullname;
  String profilepicture;
  String coverfilepicture;
  bool privateAccount;

  Member({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.username,
    required this.fullname,
    required this.profilepicture,
    required this.coverfilepicture,
    required this.privateAccount,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["ID"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    username: json["username"],
    fullname: json["fullname"],
    profilepicture: json["profilepicture"],
    coverfilepicture: json["coverfilepicture"],
    privateAccount: json["PrivateAccount"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
    "DeletedAt": deletedAt,
    "username": username,
    "fullname": fullname,
    "profilepicture": profilepicture,
    "coverfilepicture": coverfilepicture,
    "PrivateAccount": privateAccount,
  };
}
