///@author: Yasmine Ghanem
///@date: 16/12/2022
///this screen shows the muted users of a subreddit

import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/components/helpers/enums.dart';
import '../../../widgets/moderation/user_management.dart';

class MutedUsers extends StatelessWidget {
  const MutedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(
        screenTitle: 'Muted users', type: UserManagement.muted);
  }
}
