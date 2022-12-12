/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is a common app bar for all setting screens.
import 'package:flutter/material.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// this is the title to be shown in each screen.
  final title;
  const SettingsAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      shadowColor: const Color.fromARGB(255, 187, 184, 184),
      title: Text(title),
    );
  }

  /// defining how much height do we want to take for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
