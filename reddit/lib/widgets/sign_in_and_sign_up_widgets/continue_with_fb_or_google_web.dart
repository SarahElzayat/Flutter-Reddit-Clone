import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/data/facebook_api/facebook_api.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import '../../../components/button.dart';
import '../../../components/helpers/color_manager.dart';
import '../../data/google_api/google_sign_in_api.dart';

class ContinueWithGoogleOrFbWeb extends StatelessWidget {
  const ContinueWithGoogleOrFbWeb({super.key});

  Future signInWithFacebook() async {
    print('trying to log in to facebook');
    await FacebookLoginAPI.login();
    print('logged in to facebook successfully');
  }

  Future signInWithGoogle(context) async {
    // FacebookLoginAPI.logOut();
    // print('Sign out');

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
            onPressed: () => signInWithGoogle(context)),
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
