/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'approve.dart';
import 'remove.dart';
import 'spam.dart';

class Moderation {
  Approve? approve;
  Remove? remove;
  Spam? spam;
  bool? lock;

  Moderation({this.approve, this.remove, this.spam, this.lock});

  factory Moderation.fromJson(Map<String, dynamic> json) => Moderation(
        approve: json['approve'] == null
            ? null
            : Approve.fromJson(json['approve'] as Map<String, dynamic>),
        remove: json['remove'] == null
            ? null
            : Remove.fromJson(json['remove'] as Map<String, dynamic>),
        spam: json['spam'] == null
            ? null
            : Spam.fromJson(json['spam'] as Map<String, dynamic>),
        lock: json['lock'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'approve': approve?.toJson(),
        'remove': remove?.toJson(),
        'spam': spam?.toJson(),
        'lock': lock,
      };
}
