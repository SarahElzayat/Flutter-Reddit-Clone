class NotificationModel {
  String? before;
  String? after;
  int? unreadCount;
  List<NotificationItSelf>? children;

  NotificationModel({this.before, this.after, this.unreadCount, this.children});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    before = json['before'];
    after = json['after'];
    unreadCount = json['unreadCount'];
    if (json['children'] != null) {
      children = <NotificationItSelf>[];
      json['children'].forEach((v) {
        children!.add(NotificationItSelf.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'before': before,
      'after': after,
      'unreadCount': unreadCount,
      'children': children?.map((v) => v.toJson()).toList(),
    };
    return data;
  }
}

class NotificationItSelf {
  String? id;
  String? commentId;
  String? postId;
  String? title;
  String? type;
  String? link;
  String? photo;
  String? sendAt;
  bool? isRead;

  NotificationItSelf(
      {this.id,
      this.title,
      this.type,
      this.link,
      this.sendAt,
      this.isRead,
      this.commentId,
      this.photo,
      this.postId});

  NotificationItSelf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['commentId'];
    postId = json['postId'];
    title = json['title'];
    type = json['type'];
    link = json['link'];
    photo = json['photo'];
    sendAt = json['sendAt'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'type': type,
      'link': link,
      'sendAt': sendAt,
      'isRead': isRead,
      'commentId': commentId,
      'postId': postId,
      'photo': photo,
    };
    return data;
  }
}
