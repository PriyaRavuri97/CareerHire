import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'candidate.dart'; // Import your Candidate class
import 'connected_candidates.dart'; // Import ConnectedCandidates class

class CandidateDetailScreen extends StatelessWidget {
  final Candidate candidate;

  CandidateDetailScreen({required this.candidate});

  @override
  Widget build(BuildContext context) {
    // Check if the candidate is already connected
    bool isConnected = Provider.of<ConnectedCandidates>(context)
        .connectedCandidates
        .contains(candidate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Candidate Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(candidate.imageUrl),
                    radius: 100,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                candidate.name,
                style: TextStyle(fontSize: 22, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                'Position:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                candidate.position,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                'Bio:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                candidate.bio,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                'Contact Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    candidate.email,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    candidate.phone,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (isConnected) {
                      // Disconnect the candidate
                      Provider.of<ConnectedCandidates>(context, listen: false)
                          .disconnectCandidate(candidate);

                      // Show a snackbar to indicate successful disconnection
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Disconnected from the candidate!'),
                        ),
                      );
                    } else {
                      // Connect the candidate
                      Provider.of<ConnectedCandidates>(context, listen: false)
                          .connectCandidate(candidate);

                      // Show a snackbar to indicate successful connection
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Connected with the candidate!'),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isConnected ? Colors.red : Colors.green,
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Text(
                    isConnected ? 'Disconnect' : 'Connect',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
