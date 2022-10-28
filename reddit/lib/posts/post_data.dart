class Post {
  final String id;
  final String title;
  final String? body;
  final String userId;
  final String subredditId;
  final List<String>? images;

  const Post({
    required this.id,
    required this.title,
    this.body,
    required this.userId,
    required this.subredditId,
    this.images,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
      subredditId: json['subredditId'],
      images: json['images'].cast<String>(),
    );
  }
}
