import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'joblistings_screen.dart';

// Define the RegularPost class
class RegularPost {
  String title;
  String content;
  File? image;

  RegularPost({required this.title, required this.content, this.image});
}

enum PostType { Regular, JobListing }

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  PostType _postType = PostType.Regular;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Post Type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 8),
              DropdownButton<PostType>(
                value: _postType,
                onChanged: (value) {
                  setState(() {
                    _postType = value!;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: PostType.Regular,
                    child: Text('Regular Post'),
                  ),
                  DropdownMenuItem(
                    value: PostType.JobListing,
                    child: Text('Job Listing'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              if (_postType == PostType.Regular) ...[
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: _image == null
                        ? Icon(Icons.add_photo_alternate, size: 50)
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 16),
              ],
              if (_postType == PostType.JobListing) ...[
                TextFormField(
                  controller: _jobTitleController,
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _companyNameController,
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _jobDescriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Job Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Add more fields specific to job listing
              ],
              ElevatedButton(
                onPressed: () {
                  if (_postType == PostType.Regular) {
                    // Get values entered by the user for regular post
                    String title = _titleController.text;
                    String content = _contentController.text;

                    // Create a new RegularPost object
                    RegularPost newRegularPost = RegularPost(
                      title: title,
                      content: content,
                      image: _image,
                    );

                    // Add the new regular post to the list or handle it as needed
                    // For example, you can pass it to the home page or save it using a state management solution
                    // Here, we're just printing it for demonstration purposes
                    print('New Regular Post: $newRegularPost');

                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  } else if (_postType == PostType.JobListing) {
                    // Get values entered by the user for job listing
                    String title = _jobTitleController.text;
                    String company = _companyNameController.text;
                    String description = _jobDescriptionController.text;

                    // Create a new JobListing object
                    JobListing newJobListing = JobListing(
                      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID based on current time
                      title: title,
                      company: company,
                      description: description,
                      salary: 'Negotiable', // You can add more fields if needed
                      location: 'Remote',
                      requirements: '3+ years of experience, proficiency in Flutter, etc.',
                      imageUrl: 'wipro.jpg',
                    );

                    // Add the new job listing to the list
                    jobListings.add(newJobListing);

                    // Navigate back to the job listings screen
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
