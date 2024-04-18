import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'joblistings_screen.dart'; // Importing joblisting_screen.dart where JobListing class is defined

class AppliedJobModel extends ChangeNotifier {
  late Set<String> _appliedJobs;

  AppliedJobModel() {
    _loadAppliedJobs();
  }

  Future<void> _loadAppliedJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _appliedJobs = prefs.getStringList('applied_jobs')?.toSet() ?? {};
    notifyListeners();
  }

  Future<void> _saveAppliedJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('applied_jobs', _appliedJobs.toList());
  }

  bool isJobApplied(String id) {
    return _appliedJobs.contains(id);
  }

  void applyJob(String id) {
    _appliedJobs.add(id);
    _saveAppliedJobs();
    notifyListeners();
  }
}
class JobDetailScreen extends StatelessWidget {
  final JobListing job;

  JobDetailScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppliedJobModel(),
      child: Consumer<AppliedJobModel>(
        builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            title: Text('Job Detail'),
            backgroundColor: Colors.indigo, // Custom app bar color
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Text(
                  job.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Custom text color
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Company: ${job.company}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Colors.grey[600], // Custom text color
                  ),
                ),
                SizedBox(height: 16),
                // Image section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      job.imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Description section
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Custom text color
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  job.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800], // Custom text color
                  ),
                ),
                SizedBox(height: 16),
                // Details section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.indigo), // Custom icon color
                            SizedBox(width: 8),
                            Text(
                              job.location,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800], // Custom text color
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: Colors.indigo), // Custom icon color
                            SizedBox(width: 8),
                            Text(
                              job.salary,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800], // Custom text color
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Requirements:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.indigo, // Custom text color
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          job.requirements,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800], // Custom text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Apply button
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: model.isJobApplied(job.id) ? Colors.grey : Colors.indigo, // Custom button color
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Custom shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: model.isJobApplied(job.id)
                        ? null
                        : () {
                      model.applyJob(job.id);
                    },
                    child: Text(
                      model.isJobApplied(job.id) ? 'Applied' : 'Apply Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

