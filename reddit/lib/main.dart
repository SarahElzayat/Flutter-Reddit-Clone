// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// void main() {
//   runApp(const MyApp());
// }

// String prettyPrint(Map json) {
//   JsonEncoder encoder = const JsonEncoder.withIndent('  ');
//   String pretty = encoder.convert(json);
//   return pretty;
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Map<String, dynamic>? _userData;
//   AccessToken? _accessToken;
//   bool _checking = true;

//   @override
//   void initState() {
//     super.initState();
//     _checkIfIsLogged();
//   }

//   Future<void> _checkIfIsLogged() async {
//     final accessToken = await FacebookAuth.instance.accessToken;
//     setState(() {
//       _checking = false;
//     });
//     if (accessToken != null) {
//       print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
//       // now you can call to  FacebookAuth.instance.getUserData();
//       final userData = await FacebookAuth.instance.getUserData();
//       // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
//       _accessToken = accessToken;
//       setState(() {
//         _userData = userData;
//       });
//     }
//   }

//   void _printCredentials() {
//     print(
//       prettyPrint(_accessToken!.toJson()),
//     );
//   }

//   Future<void> _login() async {
//     final LoginResult result = await FacebookAuth.instance
//         .login(); // by default we request the email and the public profile

//     // loginBehavior is only supported for Android devices, for ios it will be ignored
//     // final result = await FacebookAuth.instance.login(
//     //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
//     //   loginBehavior: LoginBehavior
//     //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
//     // );

//     if (result.status == LoginStatus.success) {
//       _accessToken = result.accessToken;
//       _printCredentials();
//       // get the user data
//       // by default we get the userId, email,name and picture
//       final userData = await FacebookAuth.instance.getUserData();
//       // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
//       _userData = userData;
//     } else {
//       print(result.status);
//       print(result.message);
//     }

//     setState(() {
//       _checking = false;
//     });
//   }

//   Future<void> _logOut() async {
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Facebook Auth Example'),
//         ),
//         body: _checking
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         _userData != null
//                             ? prettyPrint(_userData!)
//                             : "NO LOGGED",
//                       ),
//                       const SizedBox(height: 20),
//                       _accessToken != null
//                           ? Text(
//                               prettyPrint(_accessToken!.toJson()),
//                             )
//                           : Container(),
//                       const SizedBox(height: 20),
//                       CupertinoButton(
//                         color: Colors.blue,
//                         child: Text(
//                           _userData != null ? "LOGOUT" : "LOGIN",
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         onPressed: _userData != null ? _logOut : _login,
//                       ),
//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/screens/forget_user_name_and_password/forget_password_screen.dart';
import 'package:reddit/screens/forget_user_name_and_password/recover_username.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/sign_up_screen.dart';
import '/screens/testing_screen.dart';
import 'networks/dio_helper.dart';

void main() {
  /// this is used to insure that every thing has been initialized well
  WidgetsFlutterBinding.ensureInitialized();

  /// and this is used to initialized Dio
  DioHelper.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        RecoverUserName.routeName: (ctx) => RecoverUserName(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        ForgetPasswordScreen.routeName: (ctx) => ForgetPasswordScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const TestingScreen());
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme(
            onError: ColorManager.white,
            brightness: Brightness.dark,
            primaryContainer: ColorManager.blue,
            secondaryContainer: ColorManager.blue,
            inverseSurface: ColorManager.blue,
            errorContainer: ColorManager.white,
            background: ColorManager.blue,
            onSurface: ColorManager.white,
            primary: ColorManager.white,
            secondary: ColorManager.white,
            surface: ColorManager.white,
            error: ColorManager.white,
            onBackground: ColorManager.white,
            onPrimary: ColorManager.white,
            onSecondary: ColorManager.white,
            outline: ColorManager.white,
          ),
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorManager.eggshellWhite,
              ),
              bodyMedium:
                  TextStyle(fontSize: 16, color: ColorManager.eggshellWhite))),
      home: const TestingScreen(),
    );
  }
}
