import 'package:flutter/src/widgets/framework.dart';

import '../../../widgets/moderation/user_management.dart';

class MutedUsers extends StatelessWidget {
  const MutedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(screenTitle: 'Muted users');
  }
}
