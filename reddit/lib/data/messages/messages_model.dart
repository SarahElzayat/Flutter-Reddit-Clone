/// @author Abdelaziz Salah
/// @date 20/12/2022
/// This model is used to get the messages from the backend.

class MessageModel {
  dynamic before;
  dynamic after;
  List<MessageChildren>? children;

  MessageModel({this.before, this.after, this.children});

  MessageModel.fromJson(Map<String, dynamic> json) {
    before = json['before'];
    after = json['after'];
    if (json['children'] != null) {
      children = <MessageChildren>[];
      json['children'].forEach((v) {
        children!.add(MessageChildren.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = {
      'before': before,
      'after': after,
      'children': children ?? '',
    };

    return data;
  }
}

class MessageChildren {
  String? id;
  MessageChild? data;

  MessageChildren({this.id, this.data});

  MessageChildren.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? MessageChild.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> newdata = {
      'id': id,
      'data': data,
    };

    return newdata;
  }
}

class MessageChild {
  String? text;
  String? senderUsername;
  String? receiverUsername;
  String? sendAt;
  String? subject;
  String? type;
  String? subredditName;
  String? postTitle;
  String? postId;
  String? commentId;
  int? numOfComments;
  bool? isSenderUser;
  bool? isReceiverUser;
  bool? isRead;
  int? vote;
  String? postOwner;

  MessageChild(
      {this.text,
      this.senderUsername,
      this.receiverUsername,
      this.sendAt,
      this.subject,
      this.type,
      this.subredditName,
      this.postTitle,
      this.postId,
      this.commentId,
      this.numOfComments,
      this.isSenderUser,
      this.isReceiverUser,
      this.isRead,
      this.vote,
      this.postOwner});

  MessageChild.fromJson(Map<String, dynamic> json) {
    // text = json['text'];
    text = '';
    senderUsername = json['senderUsername'];
    receiverUsername = json['receiverUsername'];
    sendAt = json['sendAt'];
    subject = json['subject'];
    type = json['type'];
    subredditName = json['subredditName'];
    postTitle = json['postTitle'];
    postId = json['postId'];
    commentId = json['commentId'];
    numOfComments = json['numOfComments'];
    isSenderUser = json['isSenderUser'];
    isReceiverUser = json['isReceiverUser'];
    isRead = json['isRead'];
    vote = json['vote'];
    postOwner = json['postOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'text': text,
      'senderUsername': senderUsername,
      'receiverUsername': receiverUsername,
      'sendAt': sendAt,
      'subject': subject,
      'type': type,
      'subredditName': subredditName,
      'postTitle': postTitle,
      'postId': postId,
      'commentId': commentId,
      'numOfComments': numOfComments,
      'isSenderUser': isSenderUser,
      'isReceiverUser': isReceiverUser,
      'isRead': isRead,
      'vote': vote,
      'postOwner': postOwner,
    };
    return data;
  }
}
