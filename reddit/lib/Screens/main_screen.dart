/// @author Sarah Elzayat
/// @date 3/11/2022
/// @description This screen is the main one that has the bottom navigation bar, the main app bar, drawer and end drawer

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/cubit/app_cubit.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///The method changes the end drawer state from open to closed and vice versa
  void _changeEndDrawer() {
    _scaffoldKey.currentState!.isEndDrawerOpen
        ? _scaffoldKey.currentState?.closeEndDrawer()
        : _scaffoldKey.currentState?.openEndDrawer();
  }

  bool isAndroid = CacheHelper.getData(key: 'isAndroid')!;

  List<Widget> items = [
    const Text(
      'Test ',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Test ',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Test ',
      style: TextStyle(color: Colors.white),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ChangeEndDrawerState) {
          _changeEndDrawer();
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: isAndroid
              ? SafeArea(
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: items,
                    ),
                  ),
                )
              : null,
          endDrawer: isAndroid
              ? SafeArea(
                  child: Drawer(
                    child: ListView(padding: EdgeInsets.zero, children: items),
                  ),
                )
              : null,
          appBar: homeAppBar(context, cubit.currentIndex),
          body: isAndroid? cubit.bottomNavBarScreens[cubit.currentIndex]:null,
          bottomNavigationBar: isAndroid
              ? BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  items: cubit.bottomNavBarIcons,
                  onTap: (value) {
                    setState(() {
                      cubit.changeIndex(value);
                    });
                  },
                )
              : null,
        );
      },
    );
  }
}
