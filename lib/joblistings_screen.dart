import 'package:flutter/material.dart';
import 'jobdetail_screen.dart';

void main() {
  runApp(MaterialApp(
    home: JobListingsScreen(),
  ));
}

class JobListingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: jobListings.length,
        itemBuilder: (context, index) {
          final job = jobListings[index];
          return JobListItem(job: job);
        },
      ),
    );
  }
}

class JobListItem extends StatefulWidget {
  final JobListing job;

  JobListItem({required this.job});

  @override
  _JobListItemState createState() => _JobListItemState();
}

class _JobListItemState extends State<JobListItem> {
  bool _isSelected = false;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailScreen(job: widget.job),
          ),
        );
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blue[50]!,
            ],
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Hero(
              tag: 'job_image_${widget.job.id}',
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(widget.job.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(
              widget.job.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            subtitle: Text(
              widget.job.company,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'Roboto',
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isFavorite ? Colors.red : Colors.grey[200],
                ),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class JobListing {
  final String id;
  final String title;
  final String company;
  final String description;
  final String salary;
  final String location;
  final String requirements;
  final String imageUrl;

  JobListing({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.salary,
    required this.location,
    required this.requirements,
    required this.imageUrl,
  });
}

final List<JobListing> jobListings = [
  JobListing(
    id:'1',
    title: 'Flutter Developer',
    company: 'Wipro',
    description: 'We are looking for an experienced Flutter developer to join our team. As a Flutter developer, you will be responsible for designing and implementing mobile applications using the Flutter framework. You will work closely with our development team to create high-quality, performant, and user-friendly applications. The ideal candidate should have a strong understanding of Flutter, Dart programming language, and mobile app development best practices. If you are passionate about mobile app development and eager to work on exciting projects, we would love to hear from you.',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
      imageUrl: 'images/wipro.jpg',
  ),
  JobListing(
    id:'2',
    title: 'UI/UX Designer',
    company: 'CISCO',
    description: 'ABC Designs is seeking a talented UI/UX designer to join our innovative team in New York. As a UI/UX designer, you will play a crucial role in crafting exceptional user experiences for our digital products. You will collaborate with cross-functional teams to understand user requirements, create wireframes, prototypes, and design mockups that effectively communicate the product vision. The ideal candidate should have a keen eye for detail, a deep understanding. If you are a creative thinker with a strong portfolio showcasing your UI/UX expertise.',
    salary: '50k - 70k',
    location: 'New York',
    requirements: 'Strong UI/UX skills, experience with Adobe XD, etc.',
    imageUrl: 'images/cisco.jpg',
  ),
  JobListing(
    id:'3',
    title: 'Software Engineer',
    company: 'Infosys',
    description: 'Tech Innovations is seeking passionate and talented software engineers to join our dynamic team. As a software engineer, you will have the opportunity to work on cutting-edge projects that push the boundaries of technology. You will collaborate with cross-functional teams to design, develop, and deploy software solutions that meet our clients needs. If you are enthusiastic about technology, enjoy tackling complex challenges, and thrive in a collaborative environment, we would love to hear from you.',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
    imageUrl: 'images/infosys.jpg',
  ),
  JobListing(
    id:'4',
    title: 'Mobile App Developer',
    company: 'Intuit',
    description: 'Mobile Solutions Inc. is looking for a highly skilled and innovative Mobile App Developer to join our remote team. As a Mobile App Developer, you will play a key role in designing and developing cutting-edge mobile applications that delight users and solve real-world problems. You will collaborate closely with our product managers, designers, and other developers to deliver high-quality mobile experiences. we encourage you to apply.',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
    imageUrl: 'images/intuit.jpg',
  ),
  JobListing(
    id:'5',
    title: 'Web Developer',
    company: 'Microsoft',
    description: 'WebTech Co. is actively seeking a talented and experienced Web Developer to join our remote team. As a Web Developer, you will be responsible for designing, developing, and maintaining web applications using modern web technologies. You will collaborate closely with our design and product teams to bring our vision to life and create seamless user experiences. The ideal candidate should have a passion for web development. If you are looking for a challenging opportunity to work on exciting projects in a dynamic environment',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
    imageUrl: 'images/microsoft.jpg',
  ),
  JobListing(
    id:'6',
    title: 'Backend Engineer',
    company: 'Oracle',
    description: 'TechOps Ltd. is looking for talented Backend Engineers to join our remote team. As a Backend Engineer, you will play a crucial role in designing and implementing scalable and efficient backend systems that power our applications. You will work closely with frontend developers, architects, and product managers to deliver high-quality solutions. If you are passionate about backend development and eager to tackle challenging projects, we would love to hear from you.',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
    imageUrl: 'images/oracle.jpg',
  ),
  JobListing(
    id:'7',
    title: 'Data Scientist',
    company: 'salesforce',
    description: 'DataTech Analytics is seeking a talented Data Scientist to join our remote team. As a Data Scientist, you will be responsible for analyzing large datasets, developing predictive models, You will collaborate with cross-functional teams to identify opportunities. The ideal candidate should have a strong background in statistics, machine learning, and data analysis. If you are passionate about leveraging data to solve complex problems and drive business growth, we encourage you to apply.',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
    imageUrl: 'images/salesforce.jpg',
  ),
  JobListing(
    id:'8',
    title: 'Product Manager',
    company: 'TCS',
    description: 'Product Innovations Corp. is looking for an experienced Product Manager to join our remote team. As a Product Manager, you will lead the development of innovative products from conception to launch and marketing teams. The ideal candidate should have a proven track record of product management, strong leadership skills, and a deep understanding of user-centered design principles. If you are passionate about building exceptional products and thrive in a fast-paced environment, we would love to hear from you.',
    salary: 'Negotiable',
    location: 'Remote',
    requirements: '3+ years of experience, proficiency in Flutter, etc.',
    imageUrl: 'images/tcs.jpg',
  ),
];
