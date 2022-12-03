import 'package:flutter/material.dart';
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
    //TODO add it to cubit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Saved')),
          bottom: TabBar(
            controller: _tabController,
            labelStyle: const TextStyle(fontSize: 14),
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorColor: ColorManager.blue,
            tabs: const [
              Tab(
                text: 'Posts',
              ),
              Tab(
                text: 'Comments',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            //TODO Add screens depeneding on category
            //TODO Add models to each screen
          ],
        ));
  }
}
