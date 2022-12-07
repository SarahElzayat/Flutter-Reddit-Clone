/// Model Video Widget
/// @author Haitham Mohamed
/// @date 8/11/2022
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';

/// This widget Show video (video Thumbnail) in Add post Screen
/// You allow to add one video only

/// ignore: must_be_immutable
class VideoPost extends StatelessWidget {
  const VideoPost({
    Key? key,
  }) : super(key: key);

  Widget buildDotted(context, AddPostCubit addPostCubit) {
    final mediaQuery = MediaQuery.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: DottedBorder(
        strokeWidth: 1.3,
        dashPattern: const [4, 4],
        color: ColorManager.eggshellWhite,
        child: MaterialButton(
          onPressed: () => addPostCubit.pickVideo(true),
          child: SizedBox(
            height: mediaQuery.size.height * 0.2,
            width: mediaQuery.size.width * 0.38,
            child: Icon(
              Icons.add_outlined,
              color: ColorManager.blue,
              size: mediaQuery.size.width * 0.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStack(context, width, height, AddPostCubit addPostCubit) {
    return Align(
      alignment: Alignment.topLeft,
      child: Stack(children: [
        SizedBox(
          width: width * 0.4,
          height: height * 0.23,
          child: Image.memory(
            addPostCubit.videoThumbnail!,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 10,
          ),
          width: width * 0.4,
          height: height * 0.23,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(100, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: InkWell(
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      print('Remove widget');
                      addPostCubit.removeVideo();
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(7),
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: InkWell(
                        child: const Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        onTap: () {
                          // addPostCubit.pickVideo(false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(100, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: InkWell(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      addPostCubit.pickVideo(false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return BlocBuilder<AddPostCubit, AddPostState>(
      buildWhen: ((previous, current) => current is VideoAddedOrRemoved),
      builder: (context, state) {
        return (state is VideoAddedOrRemoved && state.isAdded)
            ? buildStack(context, mediaQuery.size.width, mediaQuery.size.height,
                addPostCubit)
            : buildDotted(context, addPostCubit);
      },
    );
  }
}
