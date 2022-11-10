/// The Post model
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'flair.dart';
import 'moderation/moderation.dart';

enum LowerPostBarState { upvoted, downvoted, none }

class PostModel {
  String? id;
  String? subreddit;
  String? postedBy;
  String? title;
  String? type;
  String? content;
  int? votes;
  int? numberOfComments;
  Flair? flair;
  String? editTime;
  String? publishTime;
  bool? inYourSubreddit;
  Moderation? moderation;
  bool? nsfw;
  bool? spoiler;
  bool? saved;
  int? vote;
  final List<String>? images;

  PostModel({
    this.id,
    this.subreddit,
    this.postedBy,
    this.title,
    this.type,
    this.content,
    this.votes,
    this.numberOfComments,
    this.flair,
    this.editTime,
    this.publishTime,
    this.inYourSubreddit,
    this.moderation,
    this.nsfw,
    this.spoiler,
    this.saved,
    this.vote,
    this.images,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as String?,
        subreddit: json['data']['subreddit'] as String?,
        postedBy: json['data']['postedBy'] as String?,
        title: json['data']['title'] as String?,
        type: json['data']['type'] as String?,
        content: json['data']['content'] as String?,
        votes: json['data']['votes'] as int?,
        numberOfComments: json['data']['numberOfComments'] as int?,
        flair: json['data']['flair'] == null
            ? null
            : Flair.fromJson(json['flair'] as Map<String, dynamic>),
        editTime: json['data']['editTime'] as String?,
        publishTime: json['data']['publishTime'] as String?,
        inYourSubreddit: json['data']['inYourSubreddit'] as bool?,
        moderation: json['data']['moderation'] == null
            ? null
            : Moderation.fromJson(json['moderation'] as Map<String, dynamic>),
        nsfw: json['data']['nsfw'] as bool?,
        spoiler: json['data']['spoiler'] as bool?,
        saved: json['data']['saved'] as bool?,
        vote: json['data']['vote'] as int?,
        images: json['data']['images'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subreddit': subreddit,
        'postedBy': postedBy,
        'title': title,
        'type': type,
        'content': content,
        'votes': votes,
        'numberOfComments': numberOfComments,
        'flair': flair?.toJson(),
        'editTime': editTime,
        'publishTime': publishTime,
        'inYourSubreddit': inYourSubreddit,
        'moderation': moderation?.toJson(),
        'nsfw': nsfw,
        'spoiler': spoiler,
        'saved': saved,
        'vote': vote,
        'images': images,
      };

  void setVote(int vote) {
    votes = vote;
  }
}
