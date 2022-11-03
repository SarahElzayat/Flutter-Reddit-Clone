import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _clientIDWeb =
      '446994372726-iq8v00mfusm8omb6c7l044e2b0cbjkl5.apps.googleusercontent.com';

  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  /// this will be used later to sign the user out
  static Future logOut() => _googleSignIn.disconnect();
}
