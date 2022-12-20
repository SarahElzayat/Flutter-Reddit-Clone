import 'flair.dart';
import 'image.dart';
import 'moderation.dart';

class PostModel {
  String? id;
  String? kind;
  String? title;
  String? subreddit;
  String? link;
  List<Image>? images;
  String? video;
  Map<String, dynamic>? content;
  bool? nsfw;
  bool? spoiler;
  String? sharePostId;
  Flair? flair;
  int? comments;
  int? votes;
  String? postedAt;
  bool? sendReplies;
  bool? markedSpam;
  String? suggestedSort;
  String? editedAt;
  String? postedBy;
  int? votingType;
  bool? saved;
  bool? followed;
  bool? hidden;
  bool? spammed;
  bool? inYourSubreddit;
  Moderation? moderation;

  PostModel({
    this.id,
    this.kind,
    this.title,
    this.subreddit,
    this.link,
    this.images,
    this.video,
    this.content,
    this.nsfw,
    this.spoiler,
    this.sharePostId,
    this.flair,
    this.comments,
    this.votes,
    this.postedAt,
    this.sendReplies,
    this.markedSpam,
    this.suggestedSort,
    this.editedAt,
    this.postedBy,
    this.votingType,
    this.saved,
    this.followed,
    this.hidden,
    this.spammed,
    this.inYourSubreddit,
    this.moderation,
  });

  factory PostModel.fromJsonwithData(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      kind: json['data']['kind'] as String?,
      title: json['data']['title'] as String?,
      subreddit: json['data']['subreddit'] as String?,
      link: json['data']['link'] as String?,
      images: (json['data']['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>?))
          .toList(),
      video: json['data']['video'] as String?,
      content: json['data']['content'] as Map<String, dynamic>?,
      nsfw: json['data']['nsfw'] as bool?,
      spoiler: json['data']['spoiler'] as bool?,
      sharePostId: json['data']['sharePostId'] as String?,
      flair: json['data']['flair'] == null
          ? null
          : Flair.fromJson(json['flair'] as Map<String, dynamic>?),
      comments: json['data']['comments'] as int?,
      votes: json['data']['votes'] as int?,
      postedAt: json['data']['postedAt'] as String?,
      sendReplies: json['data']['sendReplies'] as bool?,
      markedSpam: json['data']['markedSpam'] as bool?,
      suggestedSort: json['data']['suggestedSort'] as String?,
      editedAt: json['data']['editedAt'] as String?,
      postedBy: json['data']['postedBy'] as String?,
      votingType: json['data']['votingType'] as int?,
      saved: json['data']['saved'] as bool?,
      followed: json['data']['followed'] as bool?,
      hidden: json['data']['hidden'] as bool?,
      spammed: json['data']['spammed'] as bool?,
      inYourSubreddit: json['data']['inYourSubreddit'] as bool?,
      moderation: json['data']['moderation'] == null
          ? null
          : Moderation.fromJson(json['moderation'] as Map<String, dynamic>?),
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as String?,
        kind: json['kind'] as String?,
        title: json['title'] as String?,
        subreddit: json['subreddit'] as String?,
        link: json['link'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        video: json['video'] as String?,
        content: json['content'] as Map<String, dynamic>?,
        nsfw: json['nsfw'] as bool?,
        spoiler: json['spoiler'] as bool?,
        sharePostId: json['sharePostId'] as String?,
        flair: json['flair'] == null
            ? null
            : Flair.fromJson(json['flair'] as Map<String, dynamic>),
        comments: json['comments'] as int?,
        votes: json['votes'] as int?,
        postedAt: json['postedAt'] as String?,
        sendReplies: json['sendReplies'] as bool?,
        markedSpam: json['markedSpam'] as bool?,
        suggestedSort: json['suggestedSort'] as String?,
        editedAt: json['editedAt'] as String?,
        postedBy: json['postedBy'] as String?,
        votingType: json['votingType'] as int?,
        saved: json['saved'] as bool?,
        followed: json['followed'] as bool?,
        hidden: json['hidden'] as bool?,
        spammed: json['spammed'] as bool?,
        inYourSubreddit: json['inYourSubreddit'] as bool?,
        moderation: json['moderation'] == null
            ? null
            : Moderation.fromJson(json['moderation'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind,
        'title': title,
        'subreddit': subreddit,
        'link': link,
        'images': images?.map((e) => e.toJson()).toList(),
        'video': video,
        'content': content,
        'nsfw': nsfw,
        'spoiler': spoiler,
        'sharePostId': sharePostId,
        'flair': flair?.toJson(),
        'comments': comments,
        'votes': votes,
        'postedAt': postedAt,
        'sendReplies': sendReplies,
        'markedSpam': markedSpam,
        'suggestedSort': suggestedSort,
        'editedAt': editedAt,
        'postedBy': postedBy,
        'votingType': votingType,
        'saved': saved,
        'followed': followed,
        'hidden': hidden,
        'spammed': spammed,
        'inYourSubreddit': inYourSubreddit,
        'moderation': moderation?.toJson(),
      };

  void overrideWithOther(PostModel postModel) {
    id = postModel.id;
    kind = postModel.kind;
    title = postModel.title;
    subreddit = postModel.subreddit;
    link = postModel.link;
    images = postModel.images;
    video = postModel.video;
    content = postModel.content;
    nsfw = postModel.nsfw;
    spoiler = postModel.spoiler;
    sharePostId = postModel.sharePostId;
    flair = postModel.flair;
    comments = postModel.comments;
    votes = postModel.votes;
    postedAt = postModel.postedAt;
    sendReplies = postModel.sendReplies;
    markedSpam = postModel.markedSpam;
    suggestedSort = postModel.suggestedSort;
    editedAt = postModel.editedAt;
    postedBy = postModel.postedBy;
    votingType = postModel.votingType;
    saved = postModel.saved;
    followed = postModel.followed;
    hidden = postModel.hidden;
    spammed = postModel.spammed;
    inYourSubreddit = postModel.inYourSubreddit;
    moderation = postModel.moderation;

  }
}
