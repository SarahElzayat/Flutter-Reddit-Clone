import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangeProfilePicutre extends StatefulWidget {
  const ChangeProfilePicutre({super.key});

  @override
  State<ChangeProfilePicutre> createState() => _ChangeProfilePicutreState();
}

class _ChangeProfilePicutreState extends State<ChangeProfilePicutre> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
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
                  //todo use the one from backend
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  Flexible(
                    child: MaterialButton(
                      shape: const StadiumBorder(),
                      color: ColorManager.gradientRed,
                      onPressed: () => cubit.deleteProfilePicture(),
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
                          cubit.changeProfilePicture(value!);
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
