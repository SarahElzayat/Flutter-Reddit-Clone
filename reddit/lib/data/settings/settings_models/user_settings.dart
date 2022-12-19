import 'package:reddit/shared/local/shared_preferences.dart';

class UserSettingsModel {
  static String? email;
  static String? googleEmail;
  static String? facebookEmail;
  static String? country;
  static String? gender;
  static String? displayName;
  static String? about;
  static List<SocialLinks>? socialLinks;
  static bool? havePassword;
  static bool? hasVerifiedEmail;
  static bool? nsfw;
  static bool? allowToFollowYou;
  static bool? adultContent;
  static bool? autoplayMedia;
  static bool? newFollowerEmail;
  static bool? unsubscribeFromEmails;

  /// this is a utility function used to cache the user settings.
  /// if any of the returned was null I set it to empty string
  static void cacheUserSettings() {
    CacheHelper.putData(key: 'email', value: UserSettingsModel.email ?? '');
    CacheHelper.putData(
        key: 'googleEmail', value: UserSettingsModel.googleEmail ?? '');
    CacheHelper.putData(
        key: 'facebookEmail', value: UserSettingsModel.facebookEmail ?? '');
    CacheHelper.putData(
        key: 'country', value: UserSettingsModel.country ?? 'Egypt');
    CacheHelper.putData(
        key: 'gender', value: UserSettingsModel.gender ?? 'Male');
    CacheHelper.putData(
        key: 'displayName', value: UserSettingsModel.displayName ?? 'No Name');
    CacheHelper.putData(
        key: 'about', value: UserSettingsModel.about ?? 'No About');
    CacheHelper.putData(
        key: 'havePassword', value: UserSettingsModel.havePassword ?? 'false');
    CacheHelper.putData(
        key: 'hasVerifiedEmail',
        value: UserSettingsModel.hasVerifiedEmail ?? 'false');
    CacheHelper.putData(key: 'nsfw', value: UserSettingsModel.nsfw ?? 'false');
    CacheHelper.putData(
        key: 'allowToFollowYou',
        value: UserSettingsModel.allowToFollowYou ?? 'true');
    CacheHelper.putData(
        key: 'adultContent', value: UserSettingsModel.adultContent ?? 'false');
    CacheHelper.putData(
        key: 'autoplayMedia', value: UserSettingsModel.autoplayMedia ?? 'true');
    CacheHelper.putData(
        key: 'newFollowerEmail',
        value: UserSettingsModel.newFollowerEmail ?? 'true');
    CacheHelper.putData(
        key: 'unsubscribeFromEmails',
        value: UserSettingsModel.unsubscribeFromEmails ?? 'false');
  }

  UserSettingsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    googleEmail = json['googleEmail'];
    facebookEmail = json['facebookEmail'];
    country = json['country'];
    gender = json['gender'];
    displayName = json['displayName'];
    about = json['about'];
    if (json['socialLinks'] != null) {
      socialLinks = <SocialLinks>[];
      json['socialLinks'].forEach((v) {
        socialLinks!.add(SocialLinks.fromJson(v));
      });
    }
    havePassword = json['havePassword'];
    hasVerifiedEmail = json['hasVerifiedEmail'];
    nsfw = json['nsfw'];
    allowToFollowYou = json['allowToFollowYou'];
    adultContent = json['adultContent'];
    autoplayMedia = json['autoplayMedia'];
    newFollowerEmail = json['newFollowerEmail'];
    unsubscribeFromEmails = json['unsubscribeFromEmails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'googleEmail': googleEmail,
      'facebookEmail': facebookEmail,
      'country': country,
      'gender': gender,
      'displayName': displayName,
      'about': about,
      'socialLinks': socialLinks != null
          ? socialLinks!.map((v) => v.toJson()).toList()
          : [],
      'havePassword': havePassword,
      'hasVerifiedEmail': hasVerifiedEmail,
      'nsfw': nsfw,
      'allowToFollowYou': allowToFollowYou,
      'adultContent': adultContent,
      'autoplayMedia': autoplayMedia,
      'newFollowerEmail': newFollowerEmail,
      'unsubscribeFromEmails': unsubscribeFromEmails,
    };
    return data;
  }
}

class SocialLinks {
  String? type;
  String? displayText;
  String? link;

  SocialLinks({this.type, this.displayText, this.link});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    displayText = json['displayText'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
      'displayText': displayText,
      'link': link,
    };
    return data;
  }
}
