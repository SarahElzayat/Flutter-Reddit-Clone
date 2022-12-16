///@author Sarah Elzayat
///@description model of comments in saved screen

class SavedCommentModel {
  String? commentId;
  String? commentedBy;
  String? commentBody;
  int? points;
  String? publishTime;
  String? editTime;
  Parent? parent;
  int? level;
  bool? inYourSubreddit;
  Moderation? moderation;

  SavedCommentModel(
      {this.commentId,
      this.commentedBy,
      this.commentBody,
      this.points,
      this.publishTime,
      this.editTime,
      this.parent,
      this.level,
      this.inYourSubreddit,
      this.moderation});

  SavedCommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentedBy = json['commentedBy'];
    commentBody = json['commentBody'];
    points = json['points'];
    publishTime = json['publishTime'];
    editTime = json['editTime'];
    parent =
        json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    level = json['level'];
    inYourSubreddit = json['inYourSubreddit'];
    moderation = json['moderation'] != null
        ? Moderation.fromJson(json['moderation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentedBy'] = commentedBy;
    data['commentBody'] = commentBody;
    data['points'] = points;
    data['publishTime'] = publishTime;
    data['editTime'] = editTime;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    data['level'] = level;
    data['inYourSubreddit'] = inYourSubreddit;
    if (moderation != null) {
      data['moderation'] = moderation!.toJson();
    }
    return data;
  }
}

class Parent {
  String? commentId;
  String? commentedBy;
  String? commentBody;
  int? points;
  String? publishTime;
  String? editTime;

  Parent(
      {this.commentId,
      this.commentedBy,
      this.commentBody,
      this.points,
      this.publishTime,
      this.editTime});

  Parent.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentedBy = json['commentedBy'];
    commentBody = json['commentBody'];
    points = json['points'];
    publishTime = json['publishTime'];
    editTime = json['editTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentedBy'] = commentedBy;
    data['commentBody'] = commentBody;
    data['points'] = points;
    data['publishTime'] = publishTime;
    data['editTime'] = editTime;
    return data;
  }
}

class Moderation {
  Approve? approve;
  Remove? remove;
  Spam? spam;
  bool? lock;

  Moderation({this.approve, this.remove, this.spam, this.lock});

  Moderation.fromJson(Map<String, dynamic> json) {
    approve =
        json['approve'] != null ? Approve.fromJson(json['approve']) : null;
    remove =
        json['remove'] != null ? Remove.fromJson(json['remove']) : null;
    spam = json['spam'] != null ? Spam.fromJson(json['spam']) : null;
    lock = json['lock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approve != null) {
      data['approve'] = approve!.toJson();
    }
    if (remove != null) {
      data['remove'] = remove!.toJson();
    }
    if (spam != null) {
      data['spam'] = spam!.toJson();
    }
    data['lock'] = lock;
    return data;
  }
}

class Approve {
  String? approvedBy;
  String? approvedDate;

  Approve({this.approvedBy, this.approvedDate});

  Approve.fromJson(Map<String, dynamic> json) {
    approvedBy = json['approvedBy'];
    approvedDate = json['approvedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['approvedBy'] = approvedBy;
    data['approvedDate'] = approvedDate;
    return data;
  }
}

class Remove {
  String? removedBy;
  String? removedDate;

  Remove({this.removedBy, this.removedDate});

  Remove.fromJson(Map<String, dynamic> json) {
    removedBy = json['removedBy'];
    removedDate = json['removedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['removedBy'] = removedBy;
    data['removedDate'] = removedDate;
    return data;
  }
}

class Spam {
  String? spammedBy;
  String? spammedDate;

  Spam({this.spammedBy, this.spammedDate});

  Spam.fromJson(Map<String, dynamic> json) {
    spammedBy = json['spammedBy'];
    spammedDate = json['spammedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spammedBy'] = spammedBy;
    data['spammedDate'] = spammedDate;
    return data;
  }
}
