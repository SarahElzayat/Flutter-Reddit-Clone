// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../Components/bottom_sheet.dart';

enum SortType {
  best,
  newPost,
  top,
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212121),
          // accentColor: const Color(0xff8d857b),
          // accentIconTheme: IconThemeData(color: Colors.black),
          dividerColor: Colors.black12,
        ),
        home: BottomSheetWidget());
  }
}

class BottomSheetWidget extends StatelessWidget {
  final List<SortType> _items = [
    SortType.best,
    SortType.newPost,
    SortType.top,
  ];
  final List<String> _text = [
    'Best',
    'New',
    'Top',
  ];
  final List<IconData> _unselectedIcons = [
    Icons.rocket_outlined,
    Icons.brightness_low_outlined,
    Icons.file_upload_outlined,
  ];

  final List<IconData> _selectedIcons = [
    Icons.rocket,
    Icons.brightness_low,
    Icons.file_upload
  ];

  late dynamic selectedItem;
  BottomSheetWidget({
    Key? key,
    this.selectedItem = SortType.best,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  // key: const ValueKey('button1'),
                  onPressed: () async {
                    selectedItem = await modalBottomSheet(
                      context: context,
                      title: 'AUTOPLAY',
                      text: _text,
                      items: _items,
                      selectedIcons: _selectedIcons,
                      unselectedIcons: _unselectedIcons,
                      selectedItem: selectedItem,
                    );
                  },
                  child: const Text('Bottom Sheet With Icons')),
              MaterialButton(
                  key: const ValueKey('button2'),
                  onPressed: () async {
                    selectedItem = await modalBottomSheet(
                      context: context,
                      title: 'AUTOPLAY',
                      text: _text,
                      items: _items,
                      selectedItem: selectedItem,
                    );
                  },
                  child: const Text('Bottom Sheet Without Icons')),
            ],
          ),
        ),
      ),
    );
  }
}
