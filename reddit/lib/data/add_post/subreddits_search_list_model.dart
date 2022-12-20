import 'dart:convert';

SubredditsSearchListModel subredditsSearchListModelFromJson(String str) =>
    SubredditsSearchListModel.fromJson(json.decode(str));

String subredditsSearchListModelToJson(SubredditsSearchListModel data) =>
    json.encode(data.toJson());

class SubredditsSearchListModel {
  SubredditsSearchListModel({
    this.before,
    this.after,
    this.children,
  });

  String? before;
  String? after;
  List<Child>? children;

  factory SubredditsSearchListModel.fromJson(Map<String, dynamic> json) =>
      SubredditsSearchListModel(
        before: json['before'],
        after: json['after'],
        children: (json['children'] == null || json['children'] == [])
            ? []
            : List<Child>.from(json['children'].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'before': before,
        'after': after,
        'children': List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}

class Child {
  Child({
    this.id,
    this.data,
  });

  String? id;
  Data? data;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json['id'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.subredditName,
    this.numberOfMembers,
    this.nsfw,
    this.picture,
    this.description,
    this.joined,
  });

  String? id;
  String? subredditName;
  int? numberOfMembers;
  bool? nsfw;
  int? picture;
  String? description;
  bool? joined;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        subredditName: json['subredditName'],
        numberOfMembers: json['numberOfMembers'],
        nsfw: json['nsfw'],
        picture: json['picture'],
        description: json['description'],
        joined: json['joined'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subredditName': subredditName,
        'numberOfMembers': numberOfMembers,
        'nsfw': nsfw,
        'picture': picture,
        'description': description,
        'joined': joined,
      };
}
