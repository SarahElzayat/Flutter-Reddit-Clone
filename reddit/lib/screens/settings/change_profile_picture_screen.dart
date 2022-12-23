import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/app_bar_components.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/app_cubit/app_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/snack_bar.dart';

class ChangeProfilePicutre extends StatefulWidget {
  const ChangeProfilePicutre({super.key});

  @override
  State<ChangeProfilePicutre> createState() => _ChangeProfilePicutreState();
}

class _ChangeProfilePicutreState extends State<ChangeProfilePicutre> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context)..getUserProfilePicture();
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is DeletedProfilePictureState) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Deleted profile picture successfully',
            error: false,
          ));
        } else if (state is ChangedProfilePictureState) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Changed profile picture successfully',
            error: false,
          ));
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'An error occurred, please try again later.',
            error: false,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Change profile picture'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  avatar(context: context, radius: 100),
                  const Spacer(),
                  if (cubit.profilePicture.isNotEmpty)
                    Flexible(
                      child: MaterialButton(
                        shape: const StadiumBorder(),
                        color: ColorManager.gradientRed,
                        onPressed: () {
                          cubit.deleteProfilePicture();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Text(
                            'Delete profile picture',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  Flexible(
                    child: MaterialButton(
                      shape: const StadiumBorder(),
                      color: ColorManager.blue,
                      onPressed: () async {
                        await _picker
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          if (value != null) cubit.changeProfilePicture(value);
                        });
                      },
                      child: Text(
                        'Change profile picture',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
}
