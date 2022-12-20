import 'package:flutter/material.dart';
import '../../../../components/moderation_components/modtools_components.dart';

class ChooseLanguage extends StatefulWidget {
  static const String routeName = 'choose_language';
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  bool isChanged = false;

  enabledButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: moderationAppBar(
          context, 'Choose Primary Language', enabledButton, isChanged),
    );
  }
}
