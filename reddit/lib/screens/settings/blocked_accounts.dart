/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is the Screen which manages the blocked accounts in the settings.

import 'package:flutter/material.dart';
import 'package:reddit/constants/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/default_text_field.dart';
import '../../data/settings/settings_models/blocked_accounts_getter_model.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/settings/settings_app_bar.dart';

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/blocked_accounts_screen';
  const BlockedAccounts({super.key});

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
  late PagingController<String?, BlockedAccountsGetterModel> screenController;
  late TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    screenController = PagingController(
      firstPageKey: null,
    );
    screenController.addPageRequestListener((pageKey) {
      SettingsCubit.get(context)
          .getBlockedUsers(context, pageKey, screenController);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: const SettingsAppBar(
          title: 'Blocked Accounts',
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: mediaQuery.size.height - mediaQuery.padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: DefaultTextField(
                        onChanged: (p0) => setState(() {}),
                        labelText: 'Serch',
                        formController: searchController,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: RefreshIndicator(
                    onRefresh: () =>
                        Future.sync(() => screenController.refresh()),
                    child: SizedBox(
                      child: PagedListView(
                        pagingController: screenController,
                        builderDelegate: PagedChildBuilderDelegate<
                            BlockedAccountsGetterModel>(
                          itemBuilder: (context, item, index) {
                            if (item.username!
                                    .contains(searchController.text) ||
                                searchController.text.isEmpty) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: ColorManager.upvoteRed,
                                ),
                                subtitle: Text(
                                  item.blockDate!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                title: Text(
                                  item.username!,
                                  style: const TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: OutlinedButton(
                                  onPressed: () async {
                                    await SettingsCubit.get(context).unBlock(
                                        item.username,
                                        context,
                                        screenController);
                                    screenController.refresh();
                                  },
                                  child: const Text(
                                    'Unblock',
                                    style: TextStyle(
                                        color: ColorManager.upvoteRed,
                                        fontSize: 16),
                                  ),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/Empty.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
