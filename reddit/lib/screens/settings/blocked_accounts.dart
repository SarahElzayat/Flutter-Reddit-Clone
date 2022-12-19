/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is the Screen which manages the blocked accounts in the settings.
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:reddit/data/settings_models/blocked_accounts_getter_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
=======
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/default_text_field.dart';
import '../../data/settings/settings_models/blocked_accounts_getter_model.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';
>>>>>>> 40631d0f69581fdc20be242bf49bcd860a53f2da
import '../../components/helpers/color_manager.dart';
import '../../widgets/settings/settings_app_bar.dart';

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/blocked_accounts_screen';
  const BlockedAccounts({super.key});

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
  List<Children> blockedUsers = [
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
    Children(
        id: 'x1',
        data: Data.fromJson({
          'username': 'Abdelaziz',
          'userImage':
              'https://www.google.com/search?client=firefox-b-d&q=image#imgrc=JoR7JNzGko0S6M',
          'blockDate': '12/12/2022'
        })),
  ];

  @override
  void initState() {
    _getBlockedUsers();
    super.initState();
<<<<<<< HEAD
  }

  /// this is a utility function used to get
  /// the blocked accounts from the user.
  void _getBlockedUsers() {
    DioHelper.getData(path: blockedAccounts).then((response) {
      if (response.statusCode == 200) {
        final myList = BlockedAccountsGetterModel.fromJson(response.data);
        blockedUsers = myList.children!;
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message.toString())));
=======
    screenController = PagingController(
      firstPageKey: null,
    );
    for (int i = 0; i < 5; i++) {
      SettingsCubit.get(context).blockUser(context, screenController);
    }

    screenController.addPageRequestListener((pageKey) {
      SettingsCubit.get(context)
          .getBlockedUsers(context, pageKey, screenController);
>>>>>>> 40631d0f69581fdc20be242bf49bcd860a53f2da
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
                              blockedUsers[index].data!.userImage!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          subtitle: Text(
                            blockedUsers[index].data!.blockDate!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          title: Text(
                            blockedUsers[index].data!.username!,
                            style: const TextStyle(
                                color: ColorManager.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: OutlinedButton(
                            onPressed: () {
                              setState(() {
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
