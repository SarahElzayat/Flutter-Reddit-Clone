/// @author: Abdelaziz Salah
/// this is the model for the UserSettings
/// which can get and cache all of them.
import 'package:reddit/shared/local/shared_preferences.dart';

/// this is the model for the UserSettings.
class UserSettingsModel {
  String? email;
  String? googleEmail;
  String? facebookEmail;
  String? country;
  String? gender;
  String? displayName;
  String? about;
  List<SocialLinks>? socialLinks;
  bool? havePassword;
  bool? hasVerifiedEmail;
  bool? nsfw;
  bool? allowToFollowYou;
  bool? adultContent;
  bool? autoplayMedia;
  bool? newFollowerEmail;
  bool? unsubscribeFromEmails;

  /// this is a utility function used to cache the user settings.
  /// if any of the returned was null I set it to empty string
  void cacheUserSettings() {
    CacheHelper.putData(key: 'email', value: email ?? '');
    CacheHelper.putData(key: 'googleEmail', value: googleEmail ?? '');
    CacheHelper.putData(key: 'facebookEmail', value: facebookEmail ?? '');
    CacheHelper.putData(key: 'country', value: country ?? 'Egypt');
    CacheHelper.putData(key: 'gender', value: gender ?? 'Male');
    print('${CacheHelper.getData(key: 'gender')} is my gender');
    CacheHelper.putData(key: 'displayName', value: displayName ?? 'No Name');
    CacheHelper.putData(key: 'about', value: about ?? 'No About');
    CacheHelper.putData(key: 'havePassword', value: havePassword ?? false);
    CacheHelper.putData(
        key: 'hasVerifiedEmail', value: hasVerifiedEmail ?? false);
    CacheHelper.putData(key: 'nsfw', value: nsfw ?? false);
    CacheHelper.putData(
        key: 'allowToFollowYou', value: allowToFollowYou ?? true);
    CacheHelper.putData(key: 'adultContent', value: adultContent ?? false);
    CacheHelper.putData(key: 'autoplayMedia', value: autoplayMedia ?? true);
    CacheHelper.putData(
        key: 'newFollowerEmail', value: newFollowerEmail ?? true);
    CacheHelper.putData(
        key: 'unsubscribeFromEmails', value: unsubscribeFromEmails ?? false);
  }

  /// this is a named constructor to create a new object from the json file.
  UserSettingsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    print('$email this is my mail');
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
    print(adultContent);
    autoplayMedia = json['autoplayMedia'];
    newFollowerEmail = json['newFollowerEmail'];
    unsubscribeFromEmails = json['unsubscribeFromEmails'];
  }

  /// this is a utility function to convert the object to json.
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

/// this is the model for the SocialLinks
class SocialLinks {
  String? type;
  String? displayText;
  String? link;

  SocialLinks({type, displayText, link});

  /// this is a named constructor to create a new object from the json file.
  SocialLinks.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    displayText = json['displayText'];
    link = json['link'];
  }

  /// this is a utility function to convert the object to json.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
      'displayText': displayText,
      'link': link,
    };
    return data;
  }
}
