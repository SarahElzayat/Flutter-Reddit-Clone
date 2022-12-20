import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/bottom_sheet.dart';
import '../../components/helpers/enums.dart';
import '../../cubit/subreddit/cubit/subreddit_cubit.dart';
import '../../data/post_model/post_model.dart';
import '../posts/post_widget.dart';

class SubredditPostsWidget extends StatefulWidget {
  const SubredditPostsWidget({Key? key}) : super(key: key);

  @override
  State<SubredditPostsWidget> createState() => _SubredditPostsWidgetState();
}

class _SubredditPostsWidgetState extends State<SubredditPostsWidget> {
  // int selectedIndex = 0;

  PostView postView = PostView.card;

  final List<IconData> _unselectedIcons = [
    Icons.local_fire_department_outlined,
    Icons.brightness_low_outlined,
    Icons.file_upload_outlined,
    Icons.trending_up,
  ];

  final List<IconData> _selectedIcons = [
    Icons.local_fire_department_rounded,
    Icons.brightness_low,
    Icons.file_upload,
    Icons.trending_up,
  ];

  final List<String> _text = [
    'Hot',
    'New',
    'Top',
    'Trending',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final subredditCubit = SubredditCubit.get(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () async {
                final String selectedItem = await modalBottomSheet(
                    context: context,
                    title: 'SORT POSTS BY',
                    text: _text,
                    selectedItem: _text[subredditCubit.selectedIndex],
                    selectedIcons: _selectedIcons,
                    unselectedIcons: _unselectedIcons);

                // print(selectedItem);

                if (subredditCubit.selectedIndex !=
                    _text.indexOf(selectedItem.toString())) {
                  subredditCubit.selectedIndex =
                      _text.indexOf(selectedItem.toString());

                  subredditCubit.pagingController.refresh();
                }
                setState(() {});
              },
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child:
                          Icon(_selectedIcons[subredditCubit.selectedIndex])),
                  Text(
                    _text[subredditCubit.selectedIndex],
                    style: TextStyle(fontSize: 20 * mediaquery.textScaleFactor),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(Icons.arrow_downward)),
                ],
              ),
            ),
            IconButton(
                onPressed: () async {
                  final selectedItem = await modalBottomSheet(
                      context: context,
                      title: 'POST VIEW',
                      text: ['Card', 'Classic'],
                      items: [PostView.card, PostView.classic],
                      selectedItem: postView,
                      selectedIcons: [
                        Icons.view_stream_outlined,
                        Icons.table_rows_outlined
                      ],
                      unselectedIcons: [
                        Icons.view_stream_outlined,
                        Icons.table_rows_outlined
                      ]);

                  // print(selectedItem);
                  if (selectedItem != postView) {
                    postView = selectedItem;
                    setState(() {});
                  }
                },
                icon: Icon((postView == PostView.classic)
                    ? Icons.table_rows_outlined
                    : Icons.view_stream_outlined))
          ],
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                Future.sync(() => subredditCubit.pagingController.refresh()),
            child: PagedListView<String?, PostModel>(
              pagingController: subredditCubit.pagingController,
              builderDelegate: PagedChildBuilderDelegate<PostModel>(
                itemBuilder: (context, item, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: PostWidget(
                    key: ValueKey(index),
                    post: item,
                    postView: postView,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
