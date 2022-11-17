/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen fpr the main home
///
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/app_cubit.dart';
import 'package:reddit/cubit/posts_cubit/posts_cubit.dart';
import 'package:reddit/cubit/posts_cubit/posts_state.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

import '../../components/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen_route';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    scrollController.addListener(() {
      //scroll listener
      double showoffset = MediaQuery.of(context).size.height /
          2; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: kIsWeb ? homeAppBar(context, 0) : null,
          floatingActionButton: kIsWeb
              ? BackToTopButton(scrollController: scrollController)
              : null,
          body: SingleChildScrollView(
            controller: scrollController, //set controller

            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                        width: kIsWeb ? width * 0.5 : width,
                        child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cubit.homeMenuIndex == 0
                                  ? cubit.homwPosts.length
                                  : cubit.popularPosts.length,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                child: cubit.homeMenuIndex == 0
                                    ? cubit.homwPosts[index]
                                    : cubit.popularPosts[index],
                              ),
                            ),
                  ),),
                  if (kIsWeb)
                    SizedBox(
                      height: 500,
                      width: 300,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.red,
                            height: 200,
                            width: 200,
                            child: Text(
                              'Communities near you',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.blue,
                            height: 200,
                            width: 200,
                            child: Text(
                              'Create post',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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
