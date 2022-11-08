import 'package:flutter/material.dart';
import 'package:reddit/Screens/search/search_results_main_screen.dart';

import 'package:reddit/components/Helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';

import '../../../shared/local/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> items = [
    'Post 1',
    'Post 2',
    'Post 3',
    'Post 4',
    'Post 5',
    'Post 6'
  ];
  final TextEditingController _textEditingController = TextEditingController();
  dynamic _onSubmitted(String value) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResults(
            searchWord: value,
          ),
        ),);
  }

  @override
  Widget build(BuildContext context) {
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
                  child: SearchFiled(
                      onSubmitted: _onSubmitted,
                      textEditingController: _textEditingController),
                ),
                if (CacheHelper.getData(key: 'isAndroid')!)
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.only(left: 10)),
                    child: const Text('Cancel'),
                  )
              ],
            ),
            const Text(
              'Trending today',
              style: TextStyle(color: ColorManager.eggshellWhite),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) => Text(
                  items[index],
                  style: const TextStyle(color: ColorManager.eggshellWhite),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
