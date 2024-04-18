import 'package:flutter/material.dart';
import 'candidate.dart';
import 'post.dart';

class PostService extends ChangeNotifier {
  List<Post> allPosts = [];

  Future<List<Post>> fetchPostsForConnectedCandidates(List<Candidate> connectedCandidates) async {
    allPosts.clear();

    for (Candidate candidate in connectedCandidates) {
      Post postForCandidate = await fetchPostForCandidate(candidate);
      allPosts.add(postForCandidate);
    }
    return allPosts;
  }

  Future<Post> fetchPostForCandidate(Candidate candidate) async {
    // Simulate fetching a post for the given candidate
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Replace this line with your actual logic to fetch the candidate's image URL
    String imageUrl = candidate.imageUrl;

    // Generate a dummy post (replace with actual logic to fetch posts)
    Post post = Post(
      title: 'Post for ${candidate.name}',
      content: 'Content for ${candidate.name}',
      author: candidate,
      authorImageUrl: imageUrl, // Assign the candidate's image URL
    );

    return post;
  }
}
