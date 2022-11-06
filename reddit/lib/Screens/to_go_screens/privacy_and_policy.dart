import 'package:flutter/material.dart';

/// to be implemented
class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});
  static const routeName = '/privacy_screen_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('privacy and policy'),
      ),
    );
  }
}
