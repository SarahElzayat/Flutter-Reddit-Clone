import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/app_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              if (cubit.homeMenuDropdown)
                ListView.builder(
                  itemCount: cubit.homeMenuItems.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemExtent: 50,
                  itemBuilder: (context, index) => Container(
                    color: Colors.grey[900],
                    child: Text(
                      cubit.homeMenuItems[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ]),
          ),
        );
      },
    );
  }
}
