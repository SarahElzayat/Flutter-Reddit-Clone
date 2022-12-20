// To parse this JSON data, do
//
//     final aboutUserModel = aboutUserModelFromJson(jsonString);

import 'dart:convert';

AboutUserModel aboutUserModelFromJson(String str) =>
    AboutUserModel.fromJson(json.decode(str));

String aboutUserModelToJson(AboutUserModel data) => json.encode(data.toJson());

class AboutUserModel {
  AboutUserModel({
    this.displayName,
    this.about,
    this.banner,
    this.picture,
    this.karma,
    this.cakeDate,
    this.socialLinks,
    this.nsfw,
    this.followed,
    this.blocked,
    this.moderatorOf,
  });

  String? displayName;
  String? about;
  String? banner;
  String? picture;
  int? karma;
  DateTime? cakeDate;
  List<SocialLink>? socialLinks;
  bool? nsfw;
  bool? followed;
  bool? blocked;
  List<ModeratorOf>? moderatorOf;

  factory AboutUserModel.fromJson(Map<String, dynamic> json) => AboutUserModel(
        displayName: json['displayName'],
        about: json['about'],
        banner: json['banner'],
        picture: json['picture'],
        karma: json['karma'],
        cakeDate: DateTime.parse(json['cakeDate']),
        socialLinks: List<SocialLink>.from(
            json['socialLinks'].map((x) => SocialLink.fromJson(x))),
        nsfw: json['nsfw'],
        followed: json['followed'],
        blocked: json['blocked'],
        moderatorOf: (json['moderatorOf'] == null || json['moderatorOf'] == [])
            ? []
            : List<ModeratorOf>.from(
                json['moderatorOf'].map((x) => ModeratorOf.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'about': about,
        'banner': banner,
        'picture': picture,
        'karma': karma,
        'cakeDate':
            "${cakeDate!.year.toString().padLeft(4, '0')}-${cakeDate!.month.toString().padLeft(2, '0')}-${cakeDate!.day.toString().padLeft(2, '0')}",
        'socialLinks': List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        'nsfw': nsfw,
        'followed': followed,
        'blocked': blocked,
        'moderatorOf': List<dynamic>.from(moderatorOf!.map((x) => x.toJson())),
      };
}

class ModeratorOf {
  ModeratorOf({
    this.subredditId,
    this.subredditName,
    this.numOfMembers,
    this.nsfw,
    this.followed,
  });

  String? subredditId;
  String? subredditName;
  int? numOfMembers;
  bool? nsfw;
  bool? followed;

  factory ModeratorOf.fromJson(Map<String, dynamic> json) => ModeratorOf(
        subredditId: json['subredditId'],
        subredditName: json['subredditName'],
        numOfMembers: json['numOfMembers'],
        nsfw: json['nsfw'],
        followed: json['followed'],
      );

  Map<String, dynamic> toJson() => {
        'subredditId': subredditId,
        'subredditName': subredditName,
        'numOfMembers': numOfMembers,
        'nsfw': nsfw,
        'followed': followed,
      };
}

class SocialLink {
  SocialLink({
    this.type,
    this.displayText,
    this.link,
  });

  String? type;
  String? displayText;
  String? link;

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        type: json['type'],
        displayText: json['displayText'],
        link: json['link'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'displayText': displayText,
        'link': link,
      };
}
