/// @author Abdelaziz Salah
/// @date 11/4/2022
/// this is the API which is responsible for singing in or out
/// using google account for both web app and the mobile app
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  /// this is the ID by which we have registered on the google console
  /// it is used to make this connection possible on the web app
  static const _clientIDWeb =
      '446994372726-iq8v00mfusm8omb6c7l044e2b0cbjkl5.apps.googleusercontent.com';

  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static late GoogleSignInAuthentication googleSignInAuthentication;

  /// this is the method responsible for logging in
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  /// this is the method responsible for logging out
  static Future logOut() => _googleSignIn.disconnect();

  /// this is the method responsible for getting the token
  static Future<void> getToken() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      googleSignInAuthentication = await user!.authentication;
    } catch (error) {
      debugPrint('error in getting the token\n\n\n');
      debugPrint('error');
    }
  }
}
