// To parse this JSON data, do
//
//     final moderatorModel = moderatorModelFromJson(jsonString);

import 'dart:convert';

ModeratorModel moderatorModelFromJson(String str) =>
    ModeratorModel.fromJson(json.decode(str));

String moderatorModelToJson(ModeratorModel data) => json.encode(data.toJson());

class ModeratorModel {
  ModeratorModel({
    this.before,
    this.after,
    this.children,
  });

  String? before;
  String? after;
  List<Child>? children;

  factory ModeratorModel.fromJson(Map<String, dynamic> json) => ModeratorModel(
        before: json['before'] ?? '',
        after: json['after'] ?? '',
        children:
            List<Child>.from(json['children'].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'before': before,
        'after': after,
        'children': List<dynamic>.from(children!.map((x) => x.toJson())),
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
  List<dynamic>? permissions;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        username: json['username'],
        avatar: json['avatar'],
        dateOfModeration: json['dateOfModeration'],
        permissions: (json['permissions'] == null || json['permissions'] == [])
            ? []
            : List<dynamic>.from(json['permissions'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'avatar': avatar,
        'dateOfModeration': dateOfModeration,
        'permissions': List<dynamic>.from(permissions!.map((x) => x)),
      };
}
