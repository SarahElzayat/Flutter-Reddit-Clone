/// @author Abdelaziz Salah
/// @date 6/11/2022
/// these are the two buttons of continue with
///  facebook and containue with google.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import '../../components/helpers/color_manager.dart';
import '../../data/facebook_api/facebook_api.dart';
import '../../data/google_api/google_sign_in_api.dart';

class ContinueWithGoOrFB extends StatelessWidget {
  const ContinueWithGoOrFB({super.key, required this.width});

  final width;

  Future signInWithGoogle(context) async {
    final user = await GoogleSignInApi.login();
    GoogleSignInAuthentication googleToken = await user!.authentication;

    await DioHelper.postData(
        path: signInGoogle,
        data: {'accessToken': googleToken.idToken}).then((response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }
    }).catchError((err) {
      err = err as DioError;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.response!.data['message']),
        backgroundColor: ColorManager.red,
      ));
    });
  }

  Future signInWithFacebook() async {
    await GoogleSignInApi.logOut();
    print('Signed out');
    // await FacebookLoginAPI.login();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              key: const Key('GoogleButton'),
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(width: 2, color: ColorManager.white))),
                  backgroundColor:
                      MaterialStatePropertyAll(ColorManager.darkGrey)),
              onPressed: (() => signInWithGoogle(context)),
              child: Row(
                children: [
                  SizedBox(
                    height: mediaQuery.size.height * 0.04,
                    child: Image.asset(
                      'assets/icons/googleIcon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Continue with google',
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: (18 * mediaQuery.textScaleFactor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )),
          ElevatedButton(
              key: const Key('FacebookButton'),
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(width: 2, color: ColorManager.white))),
                  backgroundColor:
                      MaterialStatePropertyAll(ColorManager.darkGrey)),
              onPressed: signInWithFacebook,
              child: Row(
                children: [
                  SizedBox(
                    height: mediaQuery.size.height * 0.035,
                    child: Image.asset(
                      'assets/icons/facebookIcon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Continue with facebook',
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: (18 * mediaQuery.textScaleFactor),
                        fontWeight: FontWeight.bold,
                      ),
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
      ),
    );
  }
}
