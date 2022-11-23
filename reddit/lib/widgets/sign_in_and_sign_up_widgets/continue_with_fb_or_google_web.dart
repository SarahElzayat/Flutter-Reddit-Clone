import 'package:flutter/material.dart';
import '../../Components/Button.dart';
import 'package:reddit/components/helpers/color_manager.dart';

import '../../data/facebook_api/facebook_api.dart';
import '../../data/google_api/google_sign_in_api.dart';

class ContinueWithGoogleOrFbWeb extends StatelessWidget {
  const ContinueWithGoogleOrFbWeb({super.key});

  Future signInWithFacebook() async {
    await FacebookLoginAPI.login();
  }

  Future signInWithGoogle() async {
    await GoogleSignInApi.login();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
            text: 'CONTINUE WITH GOOGLE',
            textColor: ColorManager.blue,
            backgroundColor: ColorManager.darkGrey,
            buttonWidth: 300,
            borderRadius: 10,
            borderColor: ColorManager.blue,
            buttonHeight: 55,
            imagePath: 'assets/icons/googleIcon.png',
            textFontSize: 16,
            onPressed: signInWithGoogle),
        const SizedBox(
          height: 10,
        ),
        Button(
            text: 'CONTINUE WITH FACEBOOK',
            textColor: ColorManager.blue,
            backgroundColor: ColorManager.darkGrey,
            buttonWidth: 300,
            borderRadius: 10,
            borderColor: ColorManager.blue,
            buttonHeight: 55,
            imagePath: 'assets/icons/facebookIcon.png',
            textFontSize: 16,
            onPressed: signInWithFacebook)
      ],
    );
  }
}
