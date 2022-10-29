import 'package:flutter/material.dart';

import '../Components/bottom_sheet.dart';

enum SortType {
  best,
  newPost,
  top,
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212121),
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
              /// Two buttons with different color
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
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        titleColor: Colors.black);
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
                      // backgroundColor: Colors.white,
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
