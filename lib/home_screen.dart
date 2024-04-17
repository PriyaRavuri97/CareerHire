import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_service.dart';
import 'regularpost.dart';
import 'post.dart' as PostModel;
import 'connected_candidates.dart';
import 'candidatedetail_screen.dart';

class CustomPostCard extends StatefulWidget {
  final PostModel.Post post;
  final bool isDarkMode;

  const CustomPostCard({
    required this.post,
    required this.isDarkMode,
  });

  @override
  _CustomPostCardState createState() => _CustomPostCardState();
}

class _CustomPostCardState extends State<CustomPostCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.isDarkMode ? Colors.grey[800] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.post.author.imageUrl),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.post.author.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10),
              AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                firstChild: Text(
                  widget.post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                secondChild: Text(
                  widget.post.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CandidateDetailScreen(
                        candidate: widget.post.author,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Read more...',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final postService = Provider.of<PostService>(context, listen: false);

    return AnimatedTheme(
      data: _isDarkMode ? _buildDarkTheme() : ThemeData.light(),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
          ],
        ),
        body: Consumer<ConnectedCandidates>(
          builder: (context, connectedCandidates, _) {
            if (connectedCandidates.connectedCandidates.isEmpty) {
              return _buildNoCandidatesConnected();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Latest Posts',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<PostModel.Post>>(
                      future: postService.fetchPostsForConnectedCandidates(
                          connectedCandidates.connectedCandidates),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Center(child: Text('Error fetching posts'));
                        } else {
                          final posts = snapshot.data!;
                          return ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              return CustomPostCard(
                                post: post,
                                isDarkMode: _isDarkMode,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/create_post')
            as Map<String, dynamic>?;

            if (result != null && result['type'] == 'regular') {
              final newRegularPost = result['post'] as RegularPost;
              print('New Regular Post: $newRegularPost');
            }
          },
          tooltip: 'Create Post',
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.pushNamed(context, '/candidates_screen');
                },
              ),
              IconButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  Navigator.pushNamed(context, '/job_listings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoCandidatesConnected() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'No connected candidates. Connect with candidates to see posts.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/candidates_screen');
          },
          child: Text('Connect with Candidates'),
        ),
      ],
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}
