class Post {
  const Post({
    required this.date,
    required this.name,
    required this.desc,
    required this.photo,
    required this.hashtags,
  });
  final String name;
  final String desc;
  final String photo;
  final String hashtags;
  final String date;
}
