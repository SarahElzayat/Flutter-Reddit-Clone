import 'moderator_of.dart';
import 'social_link.dart';

class UserDataModel {
  String? displayName;
  String? about;
  String? banner;
  String? picture;
  int? karma;
  String? cakeDate;
  List<SocialLink>? socialLinks;
  bool? nsfw;
  bool? followed;
  bool? blocked;
  List<ModeratorOf>? moderatorOf;

  UserDataModel({
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

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        displayName: json['displayName'] as String?,
        about: json['about'] as String?,
        banner: json['banner'] as String?,
        picture: json['picture'] as String?,
        karma: json['karma'] as int?,
        cakeDate: json['cakeDate'] as String?,
        socialLinks: (json['socialLinks'] as List<dynamic>?)
            ?.map((e) => SocialLink.fromJson(e as Map<String, dynamic>))
            .toList(),
        nsfw: json['nsfw'] as bool?,
        followed: json['followed'] as bool?,
        blocked: json['blocked'] as bool?,
        moderatorOf: (json['moderatorOf'] as List<dynamic>?)
            ?.map((e) => ModeratorOf.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'about': about,
        'banner': banner,
        'picture': picture,
        'karma': karma,
        'cakeDate': cakeDate,
        'socialLinks': socialLinks?.map((e) => e.toJson()).toList(),
        'nsfw': nsfw,
        'followed': followed,
        'blocked': blocked,
        'moderatorOf': moderatorOf?.map((e) => e.toJson()).toList(),
      };
}
