import 'package:flutter/material.dart';

import '../../components/Helpers/color_manager.dart';
import '../../data/facebook_api/facebook_api.dart';
import '../../data/google_api/google_sign_in_api.dart';

class ContinueWithGoOrFB extends StatelessWidget {
  const ContinueWithGoOrFB({super.key});

  Future signInWithGoogle() async {
    await GoogleSignInApi.login();
  }

  Future signInWithFacebook() async {
    await FacebookLoginAPI.login();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(width: 2, color: ColorManager.white))),
                backgroundColor:
                    MaterialStatePropertyAll(ColorManager.darkGrey)),
            onPressed: signInWithGoogle,
            child: Row(
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.04,
                  child: Image.asset(
                    'assets/icons/googleIcon.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.15,
                ),
                Text(
                  'Continue with google',
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: (18 * mediaQuery.textScaleFactor),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )),
        ElevatedButton(
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(width: 2, color: ColorManager.white))),
                backgroundColor:
                    MaterialStatePropertyAll(ColorManager.darkGrey)),
            onPressed: signInWithGoogle,
            child: Row(
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.035,
                  child: Image.asset(
                    'assets/icons/facebookIcon.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.15,
                ),
                Text(
                  'Continue with facebook',
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: (18 * mediaQuery.textScaleFactor),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )),
        Text(
          'OR',
          style: TextStyle(
            color: ColorManager.greyColor,
            fontWeight: FontWeight.bold,
            fontSize: 14 * mediaQuery.textScaleFactor,
          ),
        ),
      ],
    );
  }
}
