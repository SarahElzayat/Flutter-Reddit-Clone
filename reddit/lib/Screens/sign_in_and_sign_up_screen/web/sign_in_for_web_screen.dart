import 'package:flutter/material.dart';
import 'package:reddit/Components/default_text_field.dart';
import 'package:reddit/widgets/sign_in_and_sign_up_widgets/continue_button.dart';
import 'package:reddit/widgets/sign_in_and_sign_up_widgets/continue_with_facebook_or_google.dart';

class SignInForWebScreen extends StatelessWidget {
  const SignInForWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SizedBox(
          width: mediaQuery.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 200,
                  child: Image.asset(
                      'reddit/assets/images/WebSideBarBackGroundImage.png')),
              Container(
                height: mediaQuery.size.height,
                width: 300,
                child: Column(
                  children: [
                    Column(
                      children: const [
                        Text('Sign up'),
                        Text(
                          'By continuing, you agree to our '
                          'User Agreement and Privace Policy',
                        ),
                      ],
                    ),
                    const ContinueWithGoOrFB(width: 10),
                    const Text('OR'),
                    const DefaultTextField(
                      labelText: 'Email',
                    ),
                    ContinueButton(appliedFunction: () {}, isPressable: true)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
