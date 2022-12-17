///@author Sarah Elzayat
///@description model of comments in saved screen
class SavedCommentModel {
  String? commentId;
  String? commentedBy;
  CommentBody? commentBody;
  String? postTitle;
  int? points;
  String? publishTime;
  String? parent;
  int? level;
  bool? inYourSubreddit;
  bool? saved;

  SavedCommentModel(
      {this.commentId,
      this.commentedBy,
      this.commentBody,
      this.postTitle,
      this.points,
      this.publishTime,
      this.parent,
      this.level,
      this.inYourSubreddit,
      this.saved});

  SavedCommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentedBy = json['commentedBy'];
    commentBody = json['commentBody'] != null
        ? CommentBody.fromJson(json['commentBody'])
        : null;
    postTitle = json['postTitle'];
    points = json['points'];
    publishTime = json['publishTime'];
    parent = json['parent'];
    level = json['level'];
    inYourSubreddit = json['inYourSubreddit'];
    saved = json['saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentedBy'] = commentedBy;
    if (commentBody != null) {
      data['commentBody'] = commentBody!.toJson();
    }
    data['postTitle'] = postTitle;
    data['points'] = points;
    data['publishTime'] = publishTime;
    data['parent'] = parent;
    data['level'] = level;
    data['inYourSubreddit'] = inYourSubreddit;
    data['saved'] = saved;
    return data;
  }
}

class CommentBody {
  List<Ops>? ops;

  CommentBody({this.ops});

  CommentBody.fromJson(Map<String, dynamic> json) {
    if (json['ops'] != null) {
      ops = <Ops>[];
      json['ops'].forEach((v) {
        ops!.add(Ops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ops != null) {
      data['ops'] = ops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ops {
  String? insert;

  Ops({this.insert});

  Ops.fromJson(Map<String, dynamic> json) {
    insert = json['insert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['insert'] = insert;
    return data;
  }
}
