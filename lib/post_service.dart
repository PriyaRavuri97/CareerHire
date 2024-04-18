import 'package:flutter/material.dart';
import 'candidate.dart';
import 'post.dart';

class PostService extends ChangeNotifier {
  List<Post> allPosts = [];

  Future<List<Post>> fetchPostsForConnectedCandidates(
      List<Candidate> connectedCandidates) async {
    allPosts.clear();

    for (Candidate candidate in connectedCandidates) {
      Post postForCandidate = await fetchPostForCandidate(candidate);
      allPosts.add(postForCandidate);
    }

    notifyListeners();
    return allPosts;
  }

  Future<Post> fetchPostForCandidate(Candidate candidate) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    Post post = Post(
      title: 'New Post from ${candidate.name}',
      content: 'Welcome to Career Hire!!! You are connected with ${candidate.name}',
      author: candidate,
      authorImageUrl: "images/vishnu.jpeg", // Assign the candidate's imageUrl directly
    );

    return post;
  }

}
