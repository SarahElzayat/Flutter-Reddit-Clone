class CommentModel {
  String? id;
  String? commentedBy;
  String? userImage;
  String? editTime;
  String? publishTime;
  String? commentBody;
  int? votes;
  bool? saved;
  bool? followed;
  int? votingType;
  String? parent;
  int? level;
  int? numberofChildren;
  List<CommentModel>? children;

  CommentModel({
    this.id,
    this.commentedBy,
    this.userImage,
    this.editTime,
    this.publishTime,
    this.commentBody,
    this.votes,
    this.saved,
    this.followed,
    this.votingType,
    this.parent,
    this.level,
    this.numberofChildren,
    this.children,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['commentId'] as String?,
        commentedBy: json['commentedBy'] as String?,
        userImage: json['userImage'] as String?,
        editTime: json['editTime'] as String?,
        publishTime: json['publishTime'] as String?,
        commentBody: json['commentBody'] as String?,
        votes: json['votes'] as int?,
        saved: json['saved'] as bool?,
        followed: json['followed'] as bool?,
        votingType: json['vote'] as int?,
        parent: json['parent'] as String?,
        level: json['level'] as int?,
        numberofChildren: json['numberofChildren'] as int?,
        children: (json['children'] as List<dynamic>?)
            ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'commentId': id,
        'commentedBy': commentedBy,
        'userImage': userImage,
        'editTime': editTime,
        'publishTime': publishTime,
        'commentBody': commentBody,
        'votes': votes,
        'saved': saved,
        'followed': followed,
        'vote': votingType,
        'parent': parent,
        'level': level,
        'numberofChildren': numberofChildren,
        'children': children?.map((e) => e.toJson()).toList(),
      };

  /// equal operator to load the data from the another object
  void overrideWithOther(CommentModel other) {
    id = other.id;
    commentedBy = other.commentedBy;
    userImage = other.userImage;
    editTime = other.editTime;
    publishTime = other.publishTime;
    commentBody = other.commentBody;
    votes = other.votes;
    saved = other.saved;
    followed = other.followed;
    votingType = other.votingType;
    parent = other.parent;
    level = other.level;
    numberofChildren = other.numberofChildren;
    children = other.children;
  }
}
