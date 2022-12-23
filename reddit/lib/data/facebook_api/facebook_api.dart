import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginAPI {
  static var _accessToken;
  static var _userData;

  static String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    String pretty = encoder.convert(json);
    return pretty;
  }

  static Future<Map<String, dynamic>?> checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;

      _userData = userData;
      (userData);
      return accessToken.toJson();
    }

    return null;
  }

  static Future<Map<String, dynamic>> login() async {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']).then((response) {
      FacebookAuth.instance.getUserData().then((userData) async {});
      return response;
    }); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    }

    return _userData;
  }

  static Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
  }
}
