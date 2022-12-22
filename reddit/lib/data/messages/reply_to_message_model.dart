/// @author Abdelaziz Salah
/// @date 20/12/2022
/// This model is used to reply to a message.

import 'package:reddit/shared/local/shared_preferences.dart';

class ReplyToMessageModel {
  String? text;
  String? senderUsername;
  String? receiverUsername;
  String? subject;
  String? subredditName;
  bool? isReply;
  String? repliedMsgId;

  ReplyToMessageModel(
      {this.text,
      this.senderUsername,
      this.receiverUsername,
      this.subject,
      this.subredditName,
      this.isReply,
      this.repliedMsgId});

  ReplyToMessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    senderUsername = json['senderUsername'];
    receiverUsername = json['receiverUsername'];
    subject = json['subject'];
    subredditName = json['subredditName'];
    isReply = json['isReply'];
    repliedMsgId = json['repliedMsgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'text': text,
      'receiverUsername': '/r/$receiverUsername',
      'subject': 're:subject',
      'subredditName': subredditName,
      'repliedMsgId': repliedMsgId,
      // I am the one who is always repling.
      'isReply': true,
      'senderUsername': '/u/${CacheHelper.getData(key: 'username')}',
    };
    return data;
  }
}
