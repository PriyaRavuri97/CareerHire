import 'candidate.dart';

class Post {
  final String title;
  final String content;
  final Candidate author;
  final String authorImageUrl; // Add authorImageUrl parameter here

  Post({
    required this.title,
    required this.content,
    required this.author,
    required this.authorImageUrl, // Make sure to include it in the constructor
  });
}
