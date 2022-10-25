class Post {
  final String id;
  final String title;
  final String body;
  final String userId;
  final String subredditId;

  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.subredditId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
      subredditId: json['subredditId'],
    );
  }
}
