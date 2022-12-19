// To parse this JSON data, do
//
//     final subredditModel = subredditModelFromJson(jsonString);

import 'dart:convert';

SubredditModel subredditModelFromJson(String str) =>
    SubredditModel.fromJson(json.decode(str));

String subredditModelToJson(SubredditModel data) => json.encode(data.toJson());

class SubredditModel {
  SubredditModel({
    this.before,
    this.after,
    this.children,
  });

  String? before;
  String? after;
  List<Child>? children;

  factory SubredditModel.fromJson(Map<String, dynamic> json) => SubredditModel(
        before: json['before'],
        after: json['after'],
        children: (json['children'] == null || json['children'] == [])
            ? []
            : List<Child>.from(json['children'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'before': before,
        'after': after,
        'children': (children!.isNotEmpty)
            ? List<dynamic>.from(children!.map((x) => x))
            : [],
      };
}

class Child {
  Child({
    this.username,
    this.avatar,
    this.dateOfModeration,
    this.permissions,
  });

  String? username;
  String? avatar;
  String? dateOfModeration;
  List<String>? permissions;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        username: json['username'],
        avatar: json['avatar'],
        dateOfModeration: json['dateOfModeration'],
        permissions: (json['permissions'] == null || json['permissions'] == [])
            ? []
            : List<String>.from(json['children'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'avatar': avatar,
        'dateOfModeration': dateOfModeration,
        'permissions': (permissions!.isNotEmpty)
            ? List<dynamic>.from(permissions!.map((x) => x))
            : [],
      };
}
