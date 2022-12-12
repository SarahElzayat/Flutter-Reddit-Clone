// To parse this JSON data, do
//
//     final subredditModel = subredditModelFromJson(jsonString);

import 'dart:convert';

SubredditModel subredditModelFromJson(String str) =>
    SubredditModel.fromJson(json.decode(str));

String subredditModelToJson(SubredditModel data) => json.encode(data.toJson());

class SubredditModel {
  SubredditModel({
    this.nsfw,
    this.type,
    this.subredditId,
    this.isFavorite,
    this.title,
    this.nickname,
    this.isModerator,
    this.category,
    this.members,
    this.description,
    this.dateOfCreation,
    this.isMember,
    this.banner,
    this.picture,
    this.views,
    this.mainTopic,
    this.subtopics,
  });

  bool? nsfw;
  String? type;
  String? subredditId;
  bool? isFavorite;
  String? title;
  String? nickname;
  bool? isModerator;
  String? category;
  int? members;
  String? description;
  String? dateOfCreation;
  bool? isMember;
  String? banner;
  String? picture;
  int? views;
  String? mainTopic;
  List<String>? subtopics;

  factory SubredditModel.fromJson(Map<String, dynamic> json) => SubredditModel(
        nsfw: json['nsfw'],
        type: json['type'],
        subredditId: json['subredditId'],
        isFavorite: json['isFavorite'],
        title: json['title'],
        nickname: json['nickname'],
        isModerator: json['isModerator'],
        category: json['category'],
        members: json['members'],
        description: json['description'],
        dateOfCreation: json['dateOfCreation'],
        isMember: json['isMember'],
        banner: json['banner'],
        picture: json['picture'],
        views: json['views'],
        mainTopic: json['mainTopic'],
        subtopics: (json['subtopics'] == [] || json['subtopics'] == null)
            ? []
            : List<String>.from(json['subtopics'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'nsfw': nsfw,
        'type': type,
        'subredditId': subredditId,
        'isFavorite': isFavorite,
        'title': title,
        'nickname': nickname,
        'isModerator': isModerator,
        'category': category,
        'members': members,
        'description': description,
        'dateOfCreation': dateOfCreation,
        'isMember': isMember,
        'banner': banner,
        'picture': picture,
        'views': views,
        'mainTopic': mainTopic,
        'subtopics': (subtopics!.isNotEmpty)
            ? List<dynamic>.from(subtopics!.map((x) => x))
            : [],
      };
}
