/// @author Abdelaziz Salah
/// @date 20/12/2022
/// This model is used to send a message.

import 'package:reddit/shared/local/shared_preferences.dart';

class SendMessageModel {
  String? text;
  String? senderUsername;
  String? receiverUsername;
  String? subject;
  String? subredditName;
  bool? isReply;
  String? repliedMsgId;

  SendMessageModel(
      {this.text,
      this.senderUsername,
      this.receiverUsername,
      this.subject,
      this.subredditName,
      this.isReply,
      this.repliedMsgId});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
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
      'isReply': isReply,

      // I am always the one who send the message.
      'senderUsername': '/u/${CacheHelper.getData(key: 'username')}',
    };
    return data;
  }
}
