import 'package:flutter/material.dart';
import 'package:reddit/Screens/create_community_test_screen.dart';
import '../Components/Helpers/constants.dart';
import 'dart:io' show Platform;
import 'package:reddit/screens/bottom_sheet_test.dart';
import 'package:reddit/components/button.dart';

void main() {
  try {
    if (Platform.isAndroid) {
      isAndroid = true;
    } else {
      isAndroid = false;
    }
  } catch (e) {}
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateCommunityTestScreen();
  }
}
