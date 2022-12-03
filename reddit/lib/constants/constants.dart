/// @author Haitham
import 'package:flutter/material.dart';

const bool isMobile = true;
const List<String> labels = ['Image', 'Video', 'Text', 'Link', 'Poll'];
const List<IconData> icons = [
  Icons.image_outlined,
  Icons.play_circle_outline,
  Icons.article_outlined,
  Icons.add_link_outlined,
];
const List<IconData> selectedIcons = [
  Icons.image_rounded,
  Icons.play_circle_fill_rounded,
  Icons.article,
  Icons.add_link_outlined,
];

const List<String> postTypes = ['image', 'video', 'hybrid', 'link', 'hybrid'];

String? token;
