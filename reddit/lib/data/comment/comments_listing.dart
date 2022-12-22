import 'package:reddit/data/comment/comment_model.dart';

class CommentsListingModel {
  String? before;
  String? after;
  List<CommentModel>? children;

  CommentsListingModel({this.before, this.after, this.children});

  factory CommentsListingModel.fromJson(Map<String, dynamic> json) {
    return CommentsListingModel(
      before: json['before'] as String?,
      after: json['after'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'before': before,
        'after': after,
        'children': children?.map((e) => e.toJson()).toList(),
      };
}
