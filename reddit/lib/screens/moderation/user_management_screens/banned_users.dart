import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/widgets/moderation/user_management.dart';

class BannedUsers extends StatelessWidget {
  const BannedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(screenTitle: 'Banned users');
  }
}
