import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CustomLineMarkdownBody extends MarkdownWidget {
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomLineMarkdownBody(
      {Key? key,
      required String data,
      MarkdownStyleSheet? styleSheet,
      SyntaxHighlighter? syntaxHighlighter,
      MarkdownTapLinkCallback? onTapLink,
      this.overflow,
      this.maxLines})
      : super(
          key: key,
          data: data,
          styleSheet: styleSheet,
          syntaxHighlighter: syntaxHighlighter,
          onTapLink: onTapLink,
        );

  T? _findWidgetOfType<T>(Widget widget) {
    if (widget is T) {
      return widget as T;
    }

    if (widget is MultiChildRenderObjectWidget) {
      final MultiChildRenderObjectWidget multiChild = widget;
      for (final Widget child in multiChild.children) {
        return _findWidgetOfType<T>(child);
      }
    } else if (widget is SingleChildRenderObjectWidget) {
      final SingleChildRenderObjectWidget singleChild = widget;
      return _findWidgetOfType<T>(singleChild.child!);
    }

    return null;
  }

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    print(children!);
    final RichText? richText = _findWidgetOfType<RichText>(children.first);
    if (richText != null) {
      return RichText(
        text: richText.text,
        textScaleFactor: richText.textScaleFactor,
        textAlign: richText.textAlign,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.visible,
      );
    }

    return children.first;
  }
}
