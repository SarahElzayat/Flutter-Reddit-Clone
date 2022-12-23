// To parse this JSON data, do
//
//     final subredditFlairModel = subredditFlairModelFromJson(jsonString);

import 'dart:convert';

SubredditFlairModel subredditFlairModelFromJson(String str) =>
    SubredditFlairModel.fromJson(json.decode(str));

String subredditFlairModelToJson(SubredditFlairModel data) =>
    json.encode(data.toJson());

class SubredditFlairModel {
  SubredditFlairModel({
    this.postFlairs,
  });

  List<PostFlair>? postFlairs;

  factory SubredditFlairModel.fromJson(Map<String, dynamic> json) =>
      SubredditFlairModel(
        postFlairs: List<PostFlair>.from(
            json["postFlairs"].map((x) => PostFlair.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "postFlairs": List<dynamic>.from(postFlairs!.map((x) => x.toJson())),
      };
}

class PostFlair {
  PostFlair({
    this.flairId,
    this.flairName,
    this.flairOrder,
    this.backgroundColor,
    this.textColor,
    this.settings,
  });

  String? flairId;
  String? flairName;
  int? flairOrder;
  String? backgroundColor;
  String? textColor;
  Settings? settings;

  factory PostFlair.fromJson(Map<String, dynamic> json) => PostFlair(
        flairId: json["flairId"],
        flairName: json["flairName"],
        flairOrder: json["flairOrder"],
        backgroundColor: json["backgroundColor"],
        textColor: json["textColor"],
        settings: Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "flairId": flairId,
        "flairName": flairName,
        "flairOrder": flairOrder,
        "backgroundColor": backgroundColor,
        "textColor": textColor,
        "settings": settings!.toJson(),
      };
}

class Settings {
  Settings({
    this.modOnly,
    this.allowUserEdits,
    this.flairType,
    this.emojisLimit,
  });

  bool? modOnly;
  bool? allowUserEdits;
  String? flairType;
  int? emojisLimit;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        modOnly: json["modOnly"],
        allowUserEdits: json["allowUserEdits"],
        flairType: json["flairType"],
        emojisLimit: json["emojisLimit"],
      );

  Map<String, dynamic> toJson() => {
        "modOnly": modOnly,
        "allowUserEdits": allowUserEdits,
        "flairType": flairType,
        "emojisLimit": emojisLimit,
      };
}
