import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_service.dart';
import 'home_screen.dart';
import 'candidates_screen.dart';
import 'createpost_screen.dart';
import 'joblistings_screen.dart';
import 'connected_candidates.dart';
import 'candidate.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostService()),
        Provider<List<Candidate>>(create: (_) => candidates),
        ChangeNotifierProvider(create: (_) => ConnectedCandidates()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        // Define your theme
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/candidates_screen': (context) => CandidatesScreen(),
        '/create_post': (context) => CreatePostScreen(), // Corrected typo here
        '/job_listings': (context) => JobListingsScreen(), // Corrected typo here
      },
    );
  }
}
