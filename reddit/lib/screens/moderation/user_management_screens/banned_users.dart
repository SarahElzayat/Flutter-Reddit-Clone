///@author: Yasmine Ghanem
///@date: 16/12/2022
///this screen shows the banned users of a subreddit

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/components/helpers/enums.dart';
import '../../../widgets/moderation/user_management.dart';

class BannedUsers extends StatelessWidget {
  static const String routeName = 'banned_users';
  const BannedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(
        screenTitle: 'Banned users', type: UserManagement.banned);
  }
}
