/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is the Screen which manages the blocked accounts in the settings.
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/cubit/settings_cubit/settings_cubit.dart';
import 'package:reddit/data/settings_models/block_user_model.dart';
import 'package:reddit/data/settings_models/blocked_accounts_getter_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/settings/settings_app_bar.dart';

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/blocked_accounts_screen';
  const BlockedAccounts({super.key});

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
  /// TODO: this should be replaced with backend get request.
  List<BlockedAccountsGetterModel> blockedUsers = [];

  @override
  void initState() {
    _blockUser();

    setState(() {
      _getBlockedUsers();
    });
    super.initState();
  }

  /// this is a utility function used to get
  /// the blocked accounts from the user.
  void _getBlockedUsers() {
    DioHelper.getData(path: blockedAccounts).then((response) {
      if (response.statusCode == 200) {
        for (var elem in response.data['children']) {
          blockedUsers.add(BlockedAccountsGetterModel.fromJson(elem));
        }
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message.toString())));
    });
  }

  void _blockUser() {
    final userToBeBlocked = BlockModel(username: 'abdelazizSalah', block: true);
    DioHelper.postData(
            path: block,
            data: userToBeBlocked.toJson(),
            token: CacheHelper.getData(key: 'token'))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('abdelazizHasBeenBlocked')));
      }
    }).catchError((err) {
      err = err as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.response?.data)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: const SettingsAppBar(
        title: 'Blocked Accounts',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// TODO: This should be replaced with the search field.
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text('SearchField'),
            ),
          ),
          blockedUsers.isEmpty
              ? Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Image.asset('assets/images/Empty.jpg'),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: blockedUsers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: ColorManager.upvoteRed,
                            child: Image.network(
                              '',
                              // blockedUsers[index].avatar!,
                              // blockedUsers[index].data!.userImage!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          subtitle: Text(
                            blockedUsers[index].blockDate!,
                            // blockedUsers[index].data!.blockDate!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          title: Text(
                            blockedUsers[index].username!,
                            // blockedUsers[index].data!.username!,
                            style: const TextStyle(
                                color: ColorManager.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                SettingsCubit.get(context).unBlock(
                                    blockedUsers[index].username, context);
                                blockedUsers.remove(blockedUsers[index]);
                              });
                            },
                            child: const Text(
                              'Unblock',
                              style: TextStyle(
                                  color: ColorManager.upvoteRed, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
