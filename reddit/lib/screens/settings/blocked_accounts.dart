/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is the Screen which manages the blocked accounts in the settings.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/settings_cubit/settings_cubit.dart';
import 'package:reddit/cubit/settings_cubit/settings_cubit_state.dart';
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
  // List<BlockedAccountsGetterModel> blockedUsers = [];

  /// this is a utility function used to get
  // void _getBlockedUsers() {}
  // /// the blocked accounts from the user.
  // void _getBlockedUsers() {
  //   DioHelper.getData(path: blockedAccounts).then((response) {
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         for (var elem in response.data['children']) {
  //           blockedUsers.add(BlockedAccountsGetterModel.fromJson(elem));
  //         }
  //       });
  //     }
  //   }).catchError((error) {
  //     error = error as DioError;
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(error.message.toString())));
  //   });
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final cubitSettings = SettingsCubit.get(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: const SettingsAppBar(
          title: 'Blocked Accounts',
        ),
        body: BlocBuilder<SettingsCubit, SettingsCubitState>(
            buildWhen: (previous, current) {
          if (previous is UnBlockState || current is UnBlockState) {
            return true;
          }
          return false;
        }, builder: (ctx, state) {
          if (state is UnBlockState && state.isLoaded == true) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () => setState(() {
                          SettingsCubit.get(context).blockUser(context);
                        }),
                    child: const Text('Block')),

                /// TODO: This should be replaced with the search field.
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text('SearchField'),
                  ),
                ),
                cubitSettings.blockedUsers.isEmpty
                    ? Expanded(
                        child: SizedBox(
                          child: Center(
                            child: Image.asset('assets/images/Empty.jpg'),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                        itemCount: cubitSettings.blockedUsers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: ColorManager.upvoteRed,
                                  // child: Image.network(
                                  //   '',
                                  //   // cubitSettings.blockedUsers[index].avatar!,
                                  //   // cubitSettings.blockedUsers[index].data!.userImage!,
                                  //   fit: BoxFit.contain,
                                  // ),
                                ),
                                subtitle: Text(
                                  cubitSettings.blockedUsers[index].blockDate!,
                                  // cubitSettings.blockedUsers[index].data!.blockDate!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                title: Text(
                                  cubitSettings.blockedUsers[index].username!,
                                  // cubitSettings.blockedUsers[index].data!.username!,
                                  style: const TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      SettingsCubit.get(context).unBlock(
                                          cubitSettings
                                              .blockedUsers[index].username,
                                          context);
                                      cubitSettings.blockedUsers.remove(
                                          cubitSettings.blockedUsers[index]);
                                    });
                                  },
                                  child: const Text(
                                    'Unblock',
                                    style: TextStyle(
                                        color: ColorManager.upvoteRed,
                                        fontSize: 16),
                                  ),
                                ),
                              ));
                        },
                      )),
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorManager.upvoteRed,
            ));
          }
        }));
  }
}
