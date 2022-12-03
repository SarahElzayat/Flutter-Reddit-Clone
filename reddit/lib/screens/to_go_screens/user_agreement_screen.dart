/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a screen containing privacy and policy commnets
import 'package:flutter/material.dart';

/// to be implemented
class UserAgreementScreen extends StatelessWidget {
  const UserAgreementScreen({super.key});
  static const routeName = '/user_agreement_screen_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('User Agreement'),
      ),
    );
  }
}
