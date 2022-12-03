///@author Sarah Elzayat
///@date 3/12/2022
///@description: the screen that shows the history of the user
import 'package:flutter/material.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';

import '../../cubit/app_cubit.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('History')),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            // height: 200,
                            color: ColorManager.black,
                            child: ListView.builder(itemBuilder: (context, index) => cubit.historyCategories[index],)
                          );
                        },
                      ),
                  child: const Text('Recent')),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: const Icon(Icons.crop_square_outlined)),
            ],
          ),
          MaterialButton(
            onPressed: () => cubit.getRecentHistoryList(),
            child: Text('Hello'),
          ),
        ],
      ),
    );
  }
}
