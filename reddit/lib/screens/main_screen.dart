/// @author Sarah Elzayat
/// @date 3/11/2022
/// @description This screen is the main one that has the bottom navigation bar, the main app bar, drawer and end drawer
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';

import '../components/home_app_bar.dart';
import '../components/home_components/left_drawer.dart';
import '../components/home_components/right_drawer.dart';
import '../components/snack_bar.dart';
import '../cubit/app_cubit/app_cubit.dart';
import '../screens/add_post/add_post.dart';

class HomeScreenForMobile extends StatefulWidget {
  const HomeScreenForMobile({super.key});
  static const routeName = '/main_screen_route';

  @override
  State<HomeScreenForMobile> createState() => _HomeScreenForMobileState();
}

class _HomeScreenForMobileState extends State<HomeScreenForMobile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAndroid = !kIsWeb;

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
    if (kIsWeb) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context)..getUsername();

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
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
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: const LeftDrawer(),
          endDrawer: const RightDrawer(),
          appBar: homeAppBar(context, cubit.currentIndex),
          body: cubit.bottomNavBarScreens[cubit.currentIndex],
          bottomNavigationBar: isAndroid
              ? BottomNavigationBar(
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
                )
              : null,
        );
      },
    );
  }
}
