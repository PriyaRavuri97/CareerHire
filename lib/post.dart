import 'candidate.dart';

class Post {
  final String title;
  final String content;
  final Candidate author;
  final String authorImageUrl;

  Post({
    required this.title,
    required this.content,
    required this.author,
    required this.authorImageUrl,
  });
}
