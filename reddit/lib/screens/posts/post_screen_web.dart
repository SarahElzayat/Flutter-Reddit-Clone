/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen fpr the main home
///
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_cubit.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_state.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/helpers/universal_ui/universal_ui.dart';
import '../../components/home_app_bar.dart';
import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/comments/comment.dart';

class PostScreenWeb extends StatefulWidget {
  const PostScreenWeb({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostScreenWeb> createState() => _PostScreenWebState();
}

class _PostScreenWebState extends State<PostScreenWeb> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  QuillController? _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _controller = QuillController.basic();

    scrollController.addListener(() {
      //scroll listener
      double showoffset = MediaQuery.of(context).size.height /
          2; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toolbar = QuillToolbar.basic(
      showUndo: false,
      showRedo: false,
      showBoldButton: true,
      showItalicButton: true,
      showBackgroundColorButton: false,
      showCenterAlignment: false,
      showLeftAlignment: false,
      showRightAlignment: false,
      showJustifyAlignment: false,
      showHeaderStyle: false,
      showListNumbers: true,
      showListBullets: true,
      showCodeBlock: true,
      showStrikeThrough: true,
      showFontSize: false,
      multiRowsDisplay: false,
      showClearFormat: false,
      showIndent: false,
      showQuote: false,
      showColorButton: false,
      showSearchButton: false,
      showDirection: false,
      showDividers: false,
      showFontFamily: false,
      showInlineCode: false,
      showListCheck: false,
      showUnderLineButton: false,
      controller: _controller!,
      embedButtons: FlutterQuillEmbeds.buttons(
        showVideoButton: false,
        showCameraButton: false,
        onImagePickCallback: _onImagePickCallback,
        webImagePickImpl: _webImagePickImpl,
      ),
      showAlignmentButtons: true,
      afterButtonPressed: _focusNode.requestFocus,
    );
    return BlocProvider(
      create: (context) => PostScreenCubit(
        post: widget.post,
      )..getCommentsOfPost(),
      child: BlocConsumer<PostScreenCubit, PostScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          final screenCubit = PostScreenCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: kIsWeb ? homeAppBar(context, 0) : null,
            floatingActionButton: kIsWeb
                ? BackToTopButton(scrollController: scrollController)
                : null,
            drawer: kIsWeb ? const LeftDrawer() : null,
            endDrawer: kIsWeb ? const RightDrawer() : null,
            body: SingleChildScrollView(
              controller: scrollController, //set controller

              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostWidget(
                              post: widget.post,
                              outsideScreen: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // quil editor for web
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              clipBehavior: Clip.antiAlias,
                              height: 200,
                              width: 50.w,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.text,
                                      child: QuillEditor(
                                        controller: _controller!,
                                        readOnly: false,
                                        autoFocus: true,
                                        expands: false,
                                        scrollable: true,
                                        scrollController: ScrollController(),
                                        focusNode: FocusNode(),
                                        placeholder: 'what are your thoughts?',
                                        padding: const EdgeInsets.all(8),
                                        embedBuilders: defaultEmbedBuildersWeb,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color:
                                        const Color.fromARGB(255, 48, 48, 48),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: 50.w - 120, child: toolbar),
                                        // button to submit comment
                                        Container(
                                          width: 100,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              backgroundColor:
                                                  ColorManager.blue,
                                            ),
                                            onPressed: () {},
                                            child: const Text('Comment'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: PostScreenCubit.labels
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: screenCubit.selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    screenCubit.changeSortType(value!);
                                  });
                                },
                              ),
                            ),
                            ..._getCommentsList(screenCubit.comments),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        width: 300,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.red,
                              height: 200,
                              width: 200,
                              child: Text(
                                'Communities near you',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.blue,
                              height: 200,
                              width: 200,
                              child: Text(
                                'Create post',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _getCommentsList(List<CommentModel> l) {
    return l
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
              child: Comment(
                post: widget.post,
                comment: e,
              ),
            ))
        .toList();
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final copiedFile =
    //     await file.copy('${appDocDir.path}/${p.basename(file.path)}');
    return file.path.toString();
  }

  Future<String?> _webImagePickImpl(
      OnImagePickCallback onImagePickCallback) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }

    // Take first, because we don't allow picking multiple files.
    final fileName = result.files.first.name;

    final file = File(fileName);

    return onImagePickCallback(file);
  }
}
