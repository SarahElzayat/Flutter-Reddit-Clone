/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This screen contains the regions from which the user should come from.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/default_text_field.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Location extends StatefulWidget {
  static const routeName = '/countries_screen';
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: moderationAppBar(
                context,
                'Location',
                () => cubit.updateCommunitySettings(context),
                cubit.regionChanged),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Get discovered by local redditors',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                      'Add a location to your community and get discovered by redditors near you.'),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DefaultTextField(
                    labelText: 'Enter country/region',
                    formController: cubit.regionController,
                    onChanged: (location) => cubit.onChangedRegion(),
                  ),
                )
              ],
            ));
      },
    );
  }
}
