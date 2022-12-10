import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../widgets/moderation/user_management.dart';

class BannedUsers extends StatelessWidget {
  static const String routeName = 'banned_users';
  const BannedUsers({super.key});

  // List<Users> =[];

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(screenTitle: 'Banned users');
  }
}
