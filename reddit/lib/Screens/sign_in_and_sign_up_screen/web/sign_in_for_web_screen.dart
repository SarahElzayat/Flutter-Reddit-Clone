// /// @author Abdelaziz Salah
// /// @date 12/11/2022

// import 'package:flutter/material.dart';
// import '../../../Components/Button.dart';
// import '../../../Components/Helpers/color_manager.dart';
// import '../../../Components/default_text_field.dart';
// import '../../../Screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
// import '../../../data/sign_in_And_sign_up_models/validators.dart';
// import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_fb_or_google_web.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// /// this screen is built to show the UI in case that the user is using the app through the web
// class SignInForWebScreen extends StatelessWidget {
//   SignInForWebScreen({super.key});

//   static const routeName = '/sign_in_for_web_screen_route';
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     return ResponsiveSizer(
//       builder: (context, orientation, screenType) {
//         return Scaffold(
//           body: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // the image box
//               SizedBox(

//                   // in the website it is fixed not relative
//                   width: mediaQuery.size.width > 600 ? 140 : 120,
//                   height: 100.h,
//                   child: Image.asset(
//                     'assets/images/WebSideBarBackGroundImage.png',
//                     fit: BoxFit.fitHeight,
//                   )),

//               // the main screen.
//               Container(
//                 margin: const EdgeInsets.only(left: 28),
//                 height: 100.h,

//                 // in the website it is fixed
//                 width: 295,
//                 child: Column(
//                   children: [
//                     // the text container
//                     Container(
//                         margin: const EdgeInsets.only(bottom: 30, top: 120),
//                         height: 15.h,
//                         width: 295,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 child: const Text(
//                                   'Log in',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                             const Text(
//                               'By continuing, you agree to our User Agreement and Privacy Policy',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'Arial',
//                                   fontWeight: FontWeight.w100),
//                             ),
//                           ],
//                         )),
//                     Container(
//                         margin: const EdgeInsets.only(bottom: 40),
//                         child: const ContinueWithGoogleOrFbWeb()),
//                     const Text('OR'),
//                     SizedBox(
//                       height: 30.h,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           DefaultTextField(
//                             formController: usernameController,
//                             labelText: 'USERNAME',
//                           ),
//                           DefaultTextField(
//                             formController: passwordController,
//                             labelText: 'PASSWORD',
//                           ),
//                           Button(
//                               text: 'LOG IN',
//                               textColor: ColorManager.white,
//                               backgroundColor: ColorManager.hoverOrange,
//                               buttonWidth: 25.w,
//                               boarderRadius: 5,
//                               buttonHeight: 40,
//                               textFontSize: 14,
//                               onPressed: () {
//                                 if (Validator.validUserName(
//                                         usernameController.text) &&
//                                     Validator.validPasswordValidation(
//                                         passwordController.text)) {
//                                   debugPrint('valid');
//                                 } else {
//                                   debugPrint('Invalid');
//                                 }
//                               }),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: const Text(
//                               'Forget your username or password?',
//                               style: TextStyle(
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(top: 10),
//                             child: Row(
//                               children: [
//                                 const Text(
//                                   'New to Reddit?',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w200),
//                                 ),
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.pushReplacementNamed(context,
//                                           SignUpForWebScreen.routeName);
//                                     },
//                                     child: const Text('SIGN UP',
//                                         style: TextStyle(
//                                             color: ColorManager.blue)))
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
