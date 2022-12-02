import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../components/community_components/create_community_dialog.dart';
import '../../components/helpers/constants.dart';
import 'create_community_screen.dart';

class CreateCommunityTestScreen extends StatelessWidget {
  const CreateCommunityTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              primaryColor: Colors.black,
              brightness: Brightness.dark,
              backgroundColor: const Color(0xFF212121),
              dividerColor: Colors.black12,
              splashColor: Colors.transparent),
          home: (isAndroid == true)
              ? const CreateCommunityScreen()
              : const CreateCommunityWeb());
    });
  }
}
