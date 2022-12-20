import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import '../../../widgets/moderation/user_management.dart';

class ApprovedUsers extends StatelessWidget {
  ApprovedUsers({super.key});

  late List<dynamic> approvedUsers = [];

  @override
  Widget build(BuildContext context) {
    approvedUsers =
        ModerationCubit.get(context).getUsers(context, UserManagement.approved);
    return UserManagementWidget(
        screenTitle: 'Approved users', users: approvedUsers);
  }
}
