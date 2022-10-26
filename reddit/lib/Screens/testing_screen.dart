/// @author Abdelaziz Salah
/// @date 26/10/2022
/// testing screen to test that the ListTile is working correctly

import 'package:flutter/material.dart';
import '../Components/color_manager.dart';
import '../Components/list_tile.dart';
import '../Components/enums.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> myData = [
      'DummyStrings',
      'DummyStrings2',
      'DummyStrings3',
      'DummyStrings4',
      'DummyStrings5',
      'veryveryveryveryveryvery',
    ];

    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      home: Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: Container(
          decoration: BoxDecoration(color: ColorManager.blueGrey),
          child: Column(
            children: [
              ListTileWidget(
                  items: myData,
                  func: () {},
                  leadingIcon: const Icon(Icons.settings, color: Colors.white),
                  title: 'Language (Beta)',
                  tailingObj: TrailingObjects.dropBox),
              ListTileWidget(
                  items: myData,
                  func: () {},
                  leadingIcon:
                      const Icon(Icons.square_outlined, color: Colors.white),
                  title: 'Default View',
                  tailingObj: TrailingObjects.dropBox),
              ListTileWidget(
                  items: myData,
                  func: () {},
                  leadingIcon:
                      const Icon(Icons.house_outlined, color: Colors.white),
                  title: 'Sort Home posts by',
                  tailingObj: TrailingObjects.dropBox),
              ListTileWidget(
                  items: myData,
                  func: () {},
                  leadingIcon: const Icon(Icons.watch_later_outlined,
                      color: Colors.white),
                  title: 'Create Avatar',
                  tailingObj: TrailingObjects.dropBox),
              ListTileWidget(
                  items: myData,
                  func: () {},
                  leadingIcon: const Icon(Icons.remove_red_eye_outlined,
                      color: Colors.white),
                  title: 'Reduce animations',
                  tailingObj: TrailingObjects.switchButton),
              ListTileWidget(
                  items: myData,
                  func: () {},
                  leadingIcon: const Icon(Icons.remove_red_eye_outlined,
                      color: Colors.white),
                  title: 'Reduce animations',
                  tailingObj: TrailingObjects.tailingIcon),
            ],
          ),
        ),
      ),
    );
  }
}
