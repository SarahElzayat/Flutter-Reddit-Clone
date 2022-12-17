///@author

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/app_cubit.dart';
import '../../components/helpers/color_manager.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});
  static const routeName = '/saved_screen_route';

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  /// initial state of the stateful widget
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
  }

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Saved'),
              bottom: TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(fontSize: 14),
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: ColorManager.blue,
                  tabs: cubit.savedTabBarTabs),
            ),
            body: TabBarView(
                controller: _tabController,
                children: cubit.savedTabBarScreens));
      },
    );
  }
}
