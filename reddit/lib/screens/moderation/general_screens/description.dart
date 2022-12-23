///@author: Yasmine Ghanem
///@date:
/// this screen is for adding/editing the description of the community

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/moderation_components/modtools_components.dart';
import '../cubit/moderation_cubit.dart';
import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';

class Description extends StatefulWidget {
  static const String routeName = 'description';
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  ///the controller that controls textfield
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
        listener: (context, state) {},
        builder: ((context, state) {
          return Scaffold(
            appBar: moderationAppBar(context, 'Description', () {
              cubit.saveDescription();
            }, cubit.descriptionChanged),
            body: Container(
                color: ColorManager.darkGrey,
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: DefaultTextField(
                  formController: cubit.descriptionController,
                  labelText: 'Describe you community',
                  maxLength: 500,
                  onChanged: (description) => cubit.onChangedDescription(),
                ))),
          );
        }));
  }
}
