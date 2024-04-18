import 'package:flutter/material.dart';
import 'candidate.dart';

class ConnectedCandidates extends ChangeNotifier {
  List<Candidate> _connectedCandidates = [];
  Map<Candidate, List<String>> _candidatePosts = {};

  List<Candidate> get connectedCandidates => _connectedCandidates;
  Map<Candidate, List<String>> get candidatePosts => _candidatePosts;

  void connectCandidate(Candidate candidate) {
    if (!_connectedCandidates.contains(candidate)) {
      _connectedCandidates.add(candidate);
      _candidatePosts[candidate] = [];
      notifyListeners();
    }
  }

  void disconnectCandidate(Candidate candidate) {
    if (_connectedCandidates.contains(candidate)) {
      _connectedCandidates.remove(candidate);
      _candidatePosts.remove(candidate); // Remove posts for the candidate
      notifyListeners(); // Notify listeners of the change
    }
  }

  void addPost(Candidate candidate, String postContent) {
    if (_connectedCandidates.contains(candidate)) {
      _candidatePosts[candidate]?.add(postContent);
      notifyListeners(); // Notify change
    }
  }
}
