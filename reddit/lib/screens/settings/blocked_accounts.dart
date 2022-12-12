/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is the Screen which manages the blocked accounts in the settings.
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/widgets/settings/settings_app_bar.dart';

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/blocked_accounts_screen';
  const BlockedAccounts({super.key});

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
  List<String> blockedUsers = ['ahmed', 'salma', 'mona'];

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
                          leading: const CircleAvatar(
                            backgroundColor: ColorManager.upvoteRed,
                          ),
                          title: Text(
                            blockedUsers[index],
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
