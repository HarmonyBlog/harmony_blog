class Post {
  Post(
      {required this.id,
      required this.createdAt,
      required this.imageUrl,
      required this.userId,
      required this.title,
      required this.desc});

  final String id;
  final String createdAt;
  final String imageUrl;
  final String userId;
  final String title;
  final String desc;
}
