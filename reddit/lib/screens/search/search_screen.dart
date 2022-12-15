/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The search screen on mobile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import 'package:reddit/screens/search/search_results_main_screen.dart';
import 'package:reddit/components/search_field.dart';

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

  @override
  void initState() {
    // widget.subredditName = hebab;
    if (widget.query != null) {
      _textEditingController.text = widget.query!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SearchField(
                            // isSubreddit: true,sbab',
                            onSubmitted: (value) {
                              // SearchCubit.get(context).setSearchQuery(value);
                              // // if (widget.isSubreddit) {
                              // SearchCubit.get(context)
                              //     .setSearchSubreddit('hebab');
                              // }
                              // }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResults(
                                    // isSubreddit: true,
                                    // subredditName: 'hebab',
                                    searchWord: value,
                                  ),
                                ),
                              );
                            },
                            textEditingController: _textEditingController),
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
                  // const Text(
                  //   'Trending today',
                  //   style: TextStyle(color: ColorManager.eggshellWhite),
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     itemCount: items.length,
                  //     itemBuilder: (context, index) => Text(
                  //       items[index],
                  //       style: const TextStyle(color: ColorManager.eggshellWhite),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
