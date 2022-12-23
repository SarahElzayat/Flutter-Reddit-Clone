/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The file contains helping components for the app bar
import 'package:flutter/material.dart';
import '../screens/search/search_screen.dart';

/// the functions returns the user's profile picture as a circle avatara
///@param [image] is the user's profile picture
///@param [context] is the context of the parent widget
///@param [radius] is the radius of the circular avatar, 20 by default
Widget avatar({required context, image, double radius = 20}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: CircleAvatar(
      // backgroundColor: Colors.red,
      backgroundColor: ColorManager.darkGrey,
      backgroundImage: image != null
          ? NetworkImage('$baseUrl/$image')
          : AppCubit.get(context).profilePicture.isEmpty
              ? const AssetImage('./assets/images/Logo.png') as ImageProvider
              : NetworkImage(
                  '$baseUrl/${AppCubit.get(context).profilePicture}'),
      radius: radius,
    ),
  );
}

/// the method navigates to search screen
/// @param [context] is the context of the screen that's required to navigate to
Future<Object?> navigateToSearch(context) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SearchScreen(
        isSubreddit: false,
      ),
    ),
  );
}
