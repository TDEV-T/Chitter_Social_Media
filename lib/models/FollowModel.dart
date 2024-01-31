import 'dart:convert';

FollowModel followModelFromJson(String str) => FollowModel.fromJson(json.decode(str));

String followModelToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
  List<FollowReq>? followerReq;
  List<FollowReq>? followingReq;

  FollowModel({
    this.followerReq,
    this.followingReq,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
    followerReq: json["FollowerReq"] == null ? [] : List<FollowReq>.from(json["FollowerReq"]!.map((x) => FollowReq.fromJson(x))),
    followingReq: json["FollowingReq"] == null ? [] : List<FollowReq>.from(json["FollowingReq"]!.map((x) => FollowReq.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FollowerReq": followerReq == null ? [] : List<dynamic>.from(followerReq!.map((x) => x.toJson())),
    "FollowingReq": followingReq == null ? [] : List<dynamic>.from(followingReq!.map((x) => x.toJson())),
  };
}

class FollowReq {
  int? id;
  int? followReqFollowing;
  int? followReqFollower;
  String? status;
  Follow? follower;
  Follow? following;

  FollowReq({
    this.id,
    this.followReqFollowing,
    this.followReqFollower,
    this.status,
    this.follower,
    this.following,
  });

  factory FollowReq.fromJson(Map<String, dynamic> json) => FollowReq(
    id: json["ID"],
    followReqFollowing: json["following"],
    followReqFollower: json["follower"],
    status: json["Status"],
    follower: json["Follower"] == null ? null : Follow.fromJson(json["Follower"]),
    following: json["Following"] == null ? null : Follow.fromJson(json["Following"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "following": followReqFollowing,
    "follower": followReqFollower,
    "Status": status,
    "Follower": follower?.toJson(),
    "Following": following?.toJson(),
  };
}

class Follow {
  int? id;
  String? username;
  String? fullname;
  String? profilepicture;
  bool? privateAccount;

  Follow({
    this.id,
    this.username,
    this.fullname,
    this.profilepicture,
    this.privateAccount,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    id: json["ID"],
    username: json["username"],
    fullname: json["fullname"],
    profilepicture: json["profilepicture"],
    privateAccount: json["PrivateAccount"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "username": username,
    "fullname": fullname,
    "profilepicture": profilepicture,
    "PrivateAccount": privateAccount,
  };
}
