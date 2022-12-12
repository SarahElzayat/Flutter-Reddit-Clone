///@author Sarah Elzayat
///@date 3/12/2022
///@description: the screen that shows the history of the user for mobile
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/helpers/enums.dart';
import '../../screens/main_screen.dart';
import '../../widgets/posts/post_upper_bar.dart';
import '../../widgets/posts/post_widget.dart';
import '../../cubit/app_cubit.dart';
import '../add_post/add_post.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.bottomNavBarScreenIndex});
  final int bottomNavBarScreenIndex;
  static const routeName = '/history_screen';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    ///@param [cubit] an instance of the App Cubit to give easier access to the state management cubit
    final AppCubit cubit = AppCubit.get(context)
      ..changeHistoryCategory(HistoyCategory.recent);

    ///@param [historyCategories] a list of history categories names and icons for the bottom modal sheet
    List<ListTile> historyCategories = [
      ListTile(
        leading: const Icon(Icons.timelapse),
        title: const Text('Recent'),
        onTap: () {
          cubit.changeHistoryCategory(HistoyCategory.recent);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_circle_up_rounded),
        title: const Text('Upvoted'),
        onTap: () {
          cubit.changeHistoryCategory(HistoyCategory.upvoted);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_circle_down_rounded),
        title: const Text('Downvoted'),
        onTap: () {
          cubit.changeHistoryCategory(HistoyCategory.downvoted);
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.hide_image_outlined),
        title: const Text('Hidden'),
        onTap: () {
          cubit.changeHistoryCategory(HistoyCategory.hidden);
          Navigator.pop(context);
        },
      )
    ];

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        /// Listening to the app states, if the bottom navigation bar state is changed (a bottom navigation bar has been pressed)
        /// then the current route is changed so the history screen won't always be on top
        if (state is ChangeBottomNavBarState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreenForMobile(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('History')),
          ),

          //TODO make it a fucking reusable zeft
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
                      /// the button that changes the history category
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

                      //TODO change the history view (card-classic)
                      TextButton(
                          onPressed: () {},
                          child: const Icon(Icons.crop_square_outlined)),
                    ],
                  ),

                  /// checking the [histoty] list state, if empty then show the corresponding message
                  /// else show the history
                  //TODO do the before/after thing
                  state is HistoryEmptyState
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.4),
                          child: Center(
                            child: Text(
                              'Wow, such empty',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      :

                      /// a conditional builder on showing the history list
                      /// it shows a circular progress indicator while loading
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
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
