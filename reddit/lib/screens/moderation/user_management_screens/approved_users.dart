///@author: Yasmine Ghanem
///@date: 10/12/2022
///this screens shows approved users in a subreddit

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/enums.dart';
import '../../../widgets/moderation/user_management.dart';

class ApprovedUsers extends StatelessWidget {
  const ApprovedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(
        screenTitle: 'Approved users', type: UserManagement.approved);
  }
}
