import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../cubit/add_post/cubit/add_post_cubit.dart';
import 'add_post_textfield.dart';

class TextPostWidget extends StatefulWidget {
  TextPostWidget({Key? key}) : super(key: key);

  @override
  State<TextPostWidget> createState() => _TextPostWidgetState();
}

class _TextPostWidgetState extends State<TextPostWidget> {
  bool isMarkdown = false;
  @override
  Widget build(BuildContext context) {
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    quill.QuillController controller = quill.QuillController.basic();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isMarkdown = !isMarkdown;
                });
              },
              child: (isMarkdown)
                  ? Text('Switch to Fancy Pants Editor')
                  : Text('Markdown Mode'),
            ),
          ],
        ),
        (isMarkdown) ? markdown() : quillEditor(controller),
      ],
    );
  }

  Widget quillEditor(quill.QuillController controller) {
    return Column(
      children: [
        quill.QuillToolbar.basic(controller: controller),
        quill.QuillEditor(
            controller: controller,
            placeholder: 'Text (optional)',
            focusNode: FocusNode(),
            scrollController: ScrollController(),
            scrollable: true,
            padding: EdgeInsets.zero,
            autoFocus: true,
            readOnly: false,
            expands: false)
      ],
    );
  }

  Widget markdown() {
    return AddPostTextField(
        onChanged: ((string) {
          AddPostCubit.get(context).checkPostValidation();
        }),
        controller: AddPostCubit.get(context).optionalText,
        mltiline: true,
        isBold: false,
        fontSize: 18,
        hintText: 'Text (optional)');
  }
}
