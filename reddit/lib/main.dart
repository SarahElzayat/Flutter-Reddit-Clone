import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/main_screen.dart';
import 'package:reddit/components/Helpers/bloc_observer.dart';
import 'package:reddit/cubit/app_cubit.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:reddit/theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  try {
    if (Platform.isAndroid) {
      CacheHelper.putData(key: 'isAndroid', value: true);
      CacheHelper.putData(key: 'isWindows', value: false);
    } else {
      CacheHelper.putData(key: 'isAndroid', value: false);
      CacheHelper.putData(key: 'isWindows', value: true);
    }
  }  catch (e) {
    CacheHelper.putData(key: 'isAndroid', value: false);
    CacheHelper.putData(key: 'isWindows', value: true);
  }

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
