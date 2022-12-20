import 'dart:convert';

import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';

import '../../data/add_post/subreddit_flairs.dart';

class SubredditFlairs extends StatefulWidget {
  SubredditFlairs({Key? key}) : super(key: key);

  @override
  State<SubredditFlairs> createState() => _SubredditFlairsState();
}

class _SubredditFlairsState extends State<SubredditFlairs> {
  late SubredditFlairModel subredditFlairs;

  String? flair;

  @override
  void initState() {
    // TODO: implement initState
    AddPostCubit.get(context).getSubredditFlair();
    subredditFlairs = AddPostCubit.get(context).flairs!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final meidaQuery = MediaQuery.of(context);
    final addPostCubit = AddPostCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Flair'),
        actions: [
          TextButton(
            onPressed: (() {}),
            child: const Text(
              'Edit',
              style: TextStyle(color: ColorManager.blue, fontSize: 20),
            ),
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 1,
          child: Container(
              color: ColorManager.darkGrey,
              width: meidaQuery.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.search),
                  Container(
                    width: meidaQuery.size.width * 0.85,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          hintText: 'Search for a post flair',
                          hintStyle: TextStyle(color: ColorManager.lightGrey),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )),
        ),
        Row(
          children: [
            Radio(
              value: null,
              groupValue: flair,
              onChanged: (value) {
                setState(() {
                  flair = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text('None'),
            )
          ],
        ),
        Expanded(
          flex: 11,
          child: ListView.builder(
              itemCount: subredditFlairs.postFlairs!.length,
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    Radio(
                        value: subredditFlairs.postFlairs![index].flairId,
                        groupValue: flair,
                        onChanged: (value) {
                          setState(() {
                            flair = value;
                          });
                        },
                        activeColor: ColorManager.white),
                    Container(
                      padding: EdgeInsets.all(4),
                      color: Color(jsonDecode(
                          subredditFlairs.postFlairs![index].backgroundColor!)),
                      child: Text(
                        subredditFlairs.postFlairs![index].flairName!,
                        style: TextStyle(
                            color: Color(jsonDecode(subredditFlairs
                                .postFlairs![index].textColor!))),
                      ),
                    )
                  ],
                );
              })),
        )
      ]),
    );
  }
}
