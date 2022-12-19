/// Model Community Search Screen
/// @author Haitham Mohamed
/// @date 2/12/2022

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';

import 'package:reddit/screens/add_post/post_rules.dart';

import 'package:reddit/widgets/add_post/add_post_textfield.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';

class CommunitySearch extends StatefulWidget {
  CommunitySearch({Key? key}) : super(key: key);

  @override
  State<CommunitySearch> createState() => _CommunitySearchState();
  static const routeName = '/community_search_route';

  final List<double> memberNumbers = [15000];
}

/// Screen that you search for the subreddit that will share the post into it
class _CommunitySearchState extends State<CommunitySearch> {
  TextEditingController controller = TextEditingController();
  List<String> subreddits = [
    'news',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post to'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            navigator.pop();
          },
        ),
      ),
      body: Column(children: [
        Container(
          color: ColorManager.darkGrey,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AddPostTextField(
                    mltiline: false,
                    isBold: false,
                    fontSize: 20,
                    hintText: 'Search',
                    onChanged: (val) {
                      setState(() {});
                    },
                    controller: controller),
              ),
              if (controller.text.isNotEmpty)
                IconButton(
                    onPressed: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                    icon: const Icon(Icons.close)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: subreddits.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  addPostCubit.addSubredditName(subreddits[index]);
                  navigator.pushNamed(PostRules.routeName);
                },
                title: Text(
                  subreddits[index],
                  style: TextStyle(fontSize: 18 * mediaQuery.textScaleFactor),
                ),
                subtitle: Text(memberNumber(widget.memberNumbers[index])),
              );
            },
          ),
        ),
      ]),
    );
  }

  String memberNumber(double number) {
    if (number < 1000) {
      return '${number.toInt()} members';
    } else if (number > 1000 && number < 1000000) {
      number /= 1000;
      if ((number - number.toInt()) == 0) {
        return '${number.toInt()}k members';
      } else {
        return '${number.toStringAsFixed(1)}k members';
      }
    } else if (number > 1000000) {
      number /= 1000000;
      if ((number - number.toInt()) == 0) {
        return '${number.toInt()}k members';
      } else {
        return '${number.toStringAsFixed(1)}k members';
      }
    }
    return '$number members';
  }
}
