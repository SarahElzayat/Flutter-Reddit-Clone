class NotificationModel {
  String? before;
  String? after;
  int? unreadCount;
  List<Children>? children;

  NotificationModel({this.before, this.after, this.unreadCount, this.children});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    before = json['before'];
    after = json['after'];
    unreadCount = json['unreadCount'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
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

class Children {
  String? id;
  String? title;
  String? type;
  String? link;
  String? sendAt;
  bool? isRead;

  Children(
      {this.id, this.title, this.type, this.link, this.sendAt, this.isRead});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    link = json['link'];
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
      'isRead': isRead
    };
    return data;
  }
}
