import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:reddit/functions/post_functions.dart';
import '../../data/post_model/post_model.dart';

class Comment extends StatefulWidget {
  const Comment({
    super.key,
    required this.post,
    this.stop = false,
    this.level = 0,
  });
  final PostModel post;

  final bool stop;

  final int level;

  @override
  State<Comment> createState() => _CommentState();
}

String content =
    '[{"insert":"Heading"},{"insert":"\\n","attributes":{"header":1}},{"insert":"bold","attributes":{"bold":true}},{"insert":"\\n"},{"insert":"bold and italic","attributes":{"bold":true,"italic":true}},{"insert":"\\nsome code"},{"insert":"\\n","attributes":{"code-block":true}},{"insert":"A quote"},{"insert":"\\n","attributes":{"blockquote":true}},{"insert":"ordered list"},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"unordered list"},{"insert":"\\n","attributes":{"list":"bullet"}},{"insert":"link","attributes":{"link":"pub.dev/packages/quill_markdown"}},{"insert":"\\n"}]';

class _CommentState extends State<Comment> {
  bool isCompressed = false;
  QuillController? _controller;
  final FocusNode _focusNode = FocusNode();

  Future<void> _loadFromAssets() async {
    try {
      final result = await rootBundle.loadString('assets/sample_data.json');
      final doc = Document.fromJson(jsonDecode(result));
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      final doc = Document()..insert(0, 'Empty asset');
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Container();
    }

    return ConditionalBuilder(
      condition: isCompressed,
      builder: (context) {
        return Row(
          children: [
            singleRow(post: widget.post, showIcon: true),
          ],
        );
      },
      fallback: (context) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: singleRow(
                    post: widget.post,
                    showDots: false,
                    showIcon: true,
                  ),
                ),
              ],
            ),
            quill.QuillEditor(
              controller: _controller!,
              readOnly: true,
              autoFocus: false,
              expands: false,
              scrollable: false,
              scrollController: ScrollController(),
              focusNode: FocusNode(),
              padding: EdgeInsets.zero,
              embedBuilders: [
                ...FlutterQuillEmbeds.builders(),
              ],
            ),
            _commentsRow(),
          ],
        );
      },
    );
  }

  _commentsRow() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isCompressed = !isCompressed;
                  });
                },
                icon: const Icon(Icons.arrow_drop_down),
              ),
              // const  Text('Comments'),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isCompressed = !isCompressed;
            });
          },
          icon: const Icon(Icons.arrow_drop_up),
        ),
      ],
    );
  }
}
