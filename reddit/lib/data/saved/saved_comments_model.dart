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
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    level = json['level'];
    inYourSubreddit = json['inYourSubreddit'];
    moderation = json['moderation'] != null
        ? new Moderation.fromJson(json['moderation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['commentedBy'] = this.commentedBy;
    data['commentBody'] = this.commentBody;
    data['points'] = this.points;
    data['publishTime'] = this.publishTime;
    data['editTime'] = this.editTime;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['level'] = this.level;
    data['inYourSubreddit'] = this.inYourSubreddit;
    if (this.moderation != null) {
      data['moderation'] = this.moderation!.toJson();
    }
    return data;
  }
}

class Parent {
  String? commentId;
  String? commentedBy;
  Null? commentBody;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['commentedBy'] = this.commentedBy;
    data['commentBody'] = this.commentBody;
    data['points'] = this.points;
    data['publishTime'] = this.publishTime;
    data['editTime'] = this.editTime;
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
        json['approve'] != null ? new Approve.fromJson(json['approve']) : null;
    remove =
        json['remove'] != null ? new Remove.fromJson(json['remove']) : null;
    spam = json['spam'] != null ? new Spam.fromJson(json['spam']) : null;
    lock = json['lock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approve != null) {
      data['approve'] = this.approve!.toJson();
    }
    if (this.remove != null) {
      data['remove'] = this.remove!.toJson();
    }
    if (this.spam != null) {
      data['spam'] = this.spam!.toJson();
    }
    data['lock'] = this.lock;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approvedBy'] = this.approvedBy;
    data['approvedDate'] = this.approvedDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['removedBy'] = this.removedBy;
    data['removedDate'] = this.removedDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spammedBy'] = this.spammedBy;
    data['spammedDate'] = this.spammedDate;
    return data;
  }
}
