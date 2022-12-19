class SendedCommentModel {
  String? content;
  String? postId;
  String? parentId;
  String? parentType;
  int? level;
  String? subredditName;
  bool? haveSubreddit;

  SendedCommentModel({
    this.content,
    this.postId,
    this.parentId,
    this.parentType,
    this.level,
    this.subredditName,
    this.haveSubreddit,
  });

  factory SendedCommentModel.fromJson(Map<String, dynamic> json) {
    return SendedCommentModel(
      content: json['content'] as String?,
      postId: json['postId'] as String?,
      parentId: json['parentId'] as String?,
      parentType: json['parentType'] as String?,
      level: json['level'] as int?,
      subredditName: json['subredditName'] as String?,
      haveSubreddit: json['haveSubreddit'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'postId': postId,
        'parentId': parentId,
        'parentType': parentType,
        'level': level,
        'subredditName': subredditName,
        'haveSubreddit': haveSubreddit,
      };
}
