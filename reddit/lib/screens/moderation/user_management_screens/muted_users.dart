import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/data/moderation_models/muted_user.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';

import '../../../widgets/moderation/user_management.dart';

class MutedUsers extends StatelessWidget {
  MutedUsers({super.key});

  late List<dynamic> mutedUsers = [];

  @override
  Widget build(BuildContext context) {
    mutedUsers =
        ModerationCubit.get(context).getUsers(context, UserManagement.muted);
    return UserManagementWidget(screenTitle: 'Muted users', users: mutedUsers);
  }
}
