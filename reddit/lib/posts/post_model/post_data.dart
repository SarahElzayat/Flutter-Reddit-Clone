import 'flair.dart';
import 'moderation/moderation.dart';

class PostData {
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

  PostData({
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

  @override
  String toString() {
    return 'Data(subreddit: $subreddit, postedBy: $postedBy, title: $title, type: $type, content: $content, votes: $votes, numberOfComments: $numberOfComments, flair: $flair, editTime: $editTime, publishTime: $publishTime, inYourSubreddit: $inYourSubreddit, moderation: $moderation, nsfw: $nsfw, spoiler: $spoiler, saved: $saved, vote: $vote)';
  }

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        subreddit: json['subreddit'] as String?,
        postedBy: json['postedBy'] as String?,
        title: json['title'] as String?,
        type: json['type'] as String?,
        content: json['content'] as String?,
        votes: json['votes'] as int?,
        numberOfComments: json['numberOfComments'] as int?,
        flair: json['flair'] == null
            ? null
            : Flair.fromJson(json['flair'] as Map<String, dynamic>),
        editTime: json['editTime'] as String?,
        publishTime: json['publishTime'] as String?,
        inYourSubreddit: json['inYourSubreddit'] as bool?,
        moderation: json['moderation'] == null
            ? null
            : Moderation.fromJson(json['moderation'] as Map<String, dynamic>),
        nsfw: json['nsfw'] as bool?,
        spoiler: json['spoiler'] as bool?,
        saved: json['saved'] as bool?,
        vote: json['vote'] as int?,
        images: json['images'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
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
}
