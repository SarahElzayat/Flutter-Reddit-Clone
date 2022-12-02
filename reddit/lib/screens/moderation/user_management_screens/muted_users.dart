import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/widgets/moderation/user_management.dart';

class MutedUsers extends StatelessWidget {
  const MutedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(screenTitle: 'Muted users');
  }
}
