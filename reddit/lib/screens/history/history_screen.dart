///@author Sarah Elzayat
///@date 3/12/2022
///@description: the screen that shows the history of the user
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:reddit/screens/main_screen.dart';
import 'package:reddit/widgets/posts/post_upper_bar.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

import '../../cubit/app_cubit.dart';
import '../add_post/add_post.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.bottomNavBarScreenIndex});
  final int bottomNavBarScreenIndex;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context)..changeHistoryCategory(0);

    List<ListTile> historyCategories = [
      ListTile(
        leading: const Icon(Icons.timelapse),
        title: const Text('Recent'),
        onTap: () {
          cubit.changeHistoryCategory(0);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_circle_up_rounded),
        title: const Text('Upvoted'),
        onTap: () {
          cubit.changeHistoryCategory(1);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_circle_down_rounded),
        title: const Text('Downvoted'),
        onTap: () {
          cubit.changeHistoryCategory(2);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.hide_image_outlined),
        title: const Text('Hidden'),
        onTap: () {
          cubit.changeHistoryCategory(3);
          Navigator.pop(context);
        },
      )
    ];

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ChangeBottomNavBarState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('History')),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavBarIcons,
            onTap: (value) {
              setState(() {
                if (value == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPost(),
                  ));
                } else {
                  cubit.changeIndex(value);
                }
              });
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                color: ColorManager.black,
                                child: ListView.builder(
                                  itemBuilder: (context, index) =>
                                      historyCategories[index],
                                  itemCount: historyCategories.length,
                                ));
                          },
                        ),
                        child: Row(
                          children: [
                            cubit.historyCategoriesIcons[
                                cubit.historyCategoryIndex],
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(cubit.historyCategoriesNames[
                                  cubit.historyCategoryIndex]),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: const Icon(Icons.crop_square_outlined)),
                    ],
                  ),
                  if (cubit.history.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: Center(
                        child: Text(
                          'Wow, such empty',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  if (cubit.history.isNotEmpty)
                    ConditionalBuilder(
                        condition: state is! LoadingHistoryState,
                        fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: ColorManager.blue,
                            )),
                        builder: (context) {
                          return ListView.builder(
                            itemBuilder: (context, index) => PostWidget(
                              post: cubit.history[index],
                              upperRowType:
                                  cubit.history[index].subreddit != null
                                      ? ShowingOtions.both
                                      : ShowingOtions.onlyUser,
                            ),
                            itemCount: cubit.history.length,
                            shrinkWrap: true,
                            // ),
                          );
                        })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
