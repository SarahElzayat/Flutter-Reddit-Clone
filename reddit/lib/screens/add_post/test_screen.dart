import 'package:flutter/material.dart';
import '../../router.dart';

void main() {
  runApp(const AddPostTestScreen());
}

class AddPostTestScreen extends StatelessWidget {
  const AddPostTestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add Post Test Screen',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212121),
        dividerColor: Colors.black12,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      // home: BlocProvider(
      //     create: ((context) => AddPostCubit()), child: const AddPost()),
    );
  }
}
