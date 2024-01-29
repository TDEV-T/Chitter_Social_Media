import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(json.decode(str).map((x) => MessageModel.fromJson(x)));
class MessageModel {
  int? sender;
  String? rid;
  String? message;


  MessageModel({
    this.sender,
    this.rid,
    this.message
  });

  factory MessageModel.fromJson(Map<String,dynamic> json) => MessageModel(
    sender:json["sender"],
    rid:json["rid"],
    message:json["message"],
  );
}