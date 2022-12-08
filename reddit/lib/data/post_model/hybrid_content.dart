import 'content.dart';

class HybridContent {
  String? type;
  Content? content;

  HybridContent({this.type, this.content});

  factory HybridContent.fromJson(Map<String, dynamic> json) => HybridContent(
        type: json['type'] as String?,
        content: json['content'] == null
            ? null
            : Content.fromJson(json['content'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'content': content?.toJson(),
      };
}
