/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The search screen on mobile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/components/home_components/functions.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import 'package:reddit/screens/search/search_results_main_screen.dart';
import 'package:reddit/components/search_field.dart';

import '../../components/snack_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key, this.query, this.subredditName, this.isSubreddit = false});
  static const routeName = '/search_screen_route';

  final String? query;
  final String? subredditName;
  final bool isSubreddit;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void endDrawer() {
  //   changeEndDrawer(_scaffoldKey);
  // }

  // void drawer() {
  //   changeLeftDrawer(_scaffoldKey);
  // }

  ///The method changes the end drawer state from open to closed and vice versa
  void _changeEndDrawer() {
    _scaffoldKey.currentState!.isEndDrawerOpen
        ? _scaffoldKey.currentState?.closeEndDrawer()
        : _scaffoldKey.currentState?.openEndDrawer();
  }

  ///The method changes the drawer state from open to closed and vice versa
  void _changeLeftDrawer() {
    _scaffoldKey.currentState!.isDrawerOpen
        ? _scaffoldKey.currentState?.closeDrawer()
        : _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    if (widget.query != null) {
      _textEditingController.text = widget.query!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (kIsWeb) {
          if (state is ChangeRightDrawerState) {
            _changeEndDrawer();
          }
          if (state is ChangeLeftDrawerState) {
            _changeLeftDrawer();
          }

          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
              message: 'An error occurred, please try again later.',
              error: false,
            ));
          }
        }
      },
      child: BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: kIsWeb ? homeAppBar(context, 0) : null,
              drawer: kIsWeb ? const RightDrawer() : null,
              endDrawer: kIsWeb ? const LeftDrawer() : null,
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          kIsWeb ? MediaQuery.of(context).size.width * 0.2 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          kIsWeb
                              ? Expanded(
                                  child: SearchField(
                                      isSubreddit: widget.isSubreddit,
                                      subredditName: widget.subredditName,
                                      onSubmitted: (value) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchResults(
                                              isSubreddit: widget.isSubreddit,
                                              subredditName:
                                                  widget.subredditName,
                                              searchWord: value,
                                            ),
                                          ),
                                        );
                                      },
                                      textEditingController:
                                          _textEditingController),
                                )
                              : Expanded(
                                  child: SearchField(
                                      isSubreddit: widget.isSubreddit,
                                      subredditName: widget.subredditName,
                                      onSubmitted: (value) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchResults(
                                              isSubreddit: widget.isSubreddit,
                                              subredditName:
                                                  widget.subredditName,
                                              searchWord: value,
                                            ),
                                          ),
                                        );
                                      },
                                      textEditingController:
                                          _textEditingController),
                                ),
                          if (!kIsWeb)
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  padding: const EdgeInsets.only(left: 10)),
                              child: const Text('Cancel'),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}
