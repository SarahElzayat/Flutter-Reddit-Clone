import 'package:flutter/material.dart';
import '../../../widgets/moderation/user_management.dart';

class ApprovedUsers extends StatelessWidget {
  const ApprovedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return UserManagementWidget(screenTitle: 'Approved users');
  }
}
