import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import '../../../widgets/moderation/user_management.dart';

class BannedUsers extends StatelessWidget {
  static const String routeName = 'banned_users';
  BannedUsers({super.key});

  late List<dynamic> bannedUsers;

  @override
  Widget build(BuildContext context) {
    bannedUsers =
        ModerationCubit.get(context).getUsers(context, UserManagement.banned);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return UserManagementWidget(
            screenTitle: 'Banned users', users: bannedUsers);
      }),
    );
  }
}
