/// @author Abdelaziz Salah
/// @date 12/12/2022
/// this file contain a utility widget which contains a header for some screens
/// in the settings which contains the username and the email and the avatar of
/// the user

import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';

class HeaderContainsAvatar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final usrName;
  // ignore: prefer_typing_uninitialized_variables
  final email;
  const HeaderContainsAvatar(
      {super.key, required this.email, required this.usrName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: ColorManager.upvoteRed,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              usrName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(email)
          ],
        )
      ],
    );
  }
}
