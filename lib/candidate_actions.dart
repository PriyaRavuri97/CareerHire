import 'package:flutter/material.dart';
import 'candidate.dart'; // Import your Candidate class
import 'post.dart'; // Import your Post class

class PostService extends ChangeNotifier {
  List<Post> allPosts = []; // Define allPosts as a class-level variable

  Future<List<Post>> fetchPostsForConnectedCandidates(List<Candidate> connectedCandidates) async {
    allPosts.clear(); // Clear existing posts before fetching new ones

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
