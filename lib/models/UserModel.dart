import 'dart:convert';

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
  List<Post>? posts;

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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["ID"],
    username: json["Username"],
    fullName: json["FullName"],
    email: json["Email"],
    profilePicture: json["ProfilePicture"],
    coverfilePicture: json["CoverfilePicture"],
    bio: json["Bio"],
    privateAccount: json["PrivateAccount"],
    posts: json["Posts"] == null ? [] : List<Post>.from(json["Posts"]!.map((x) => Post.fromJson(x))),
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

class Post {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? userId;
  String? content;
  String? contenttype;
  String? image;
  bool? public;
  dynamic likes;
  dynamic comments;
  User? user;

  Post({
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

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    userId: json["UserID"],
    content: json["content"],
    contenttype: json["contenttype"],
    image: json["Image"],
    public: json["public"],
    likes: json["Likes"],
    comments: json["Comments"],
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
    "Likes": likes,
    "Comments": comments,
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
