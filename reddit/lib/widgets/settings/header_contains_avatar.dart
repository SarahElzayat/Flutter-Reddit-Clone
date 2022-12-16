/// @author Abdelaziz Salah
/// @date 12/12/2022
/// this file contain a utility widget which contains a header for some screens
/// in the settings which contains the username and the email and the avatar of
/// the user

import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';

class HeaderContainsAvatar extends StatelessWidget {
  final usrName;
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

          /// TODO: here we will need to use cubit
          children: [
            Text(
              usrName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(email)
          ],
        )
      ],
    );
  }
}
