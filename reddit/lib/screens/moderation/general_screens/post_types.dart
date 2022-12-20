import 'package:flutter/material.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';

class PostTypes extends StatelessWidget {
  static const String routeName = 'post_types';
  PostTypes({super.key});
  bool isChanged = false;
  enabledButton() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: moderationAppBar(context, 'Post type', enabledButton, isChanged),
    );
  }
}
