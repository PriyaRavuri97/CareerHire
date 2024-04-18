
class Candidate {
  final String name;
  final String position;
  final String experience;
  final String imageUrl;
  final String bio;
  final String email;
  final String phone;

  Candidate({
    required this.name,
    required this.position,
    required this.experience,
    required this.imageUrl,
    required this.bio,
    required this.email,
    required this.phone,
  });
}


List<Candidate> candidates = [
  Candidate(
    name: 'Priya Ravuri',
    position: 'Software Engineer',
    experience: '3 years',
    imageUrl: 'images/priya.jpeg',
    bio: 'I am an experienced software engineer with a strong background in mobile app development. '
        'With 4 years of professional experience, i have skills in designing and implementing robust software solutions for various platforms.',
    email: 'priya@gmail.com',
    phone: '+1234567890',
  ),
  Candidate(
    name: 'Vishnu Karthik',
    position: 'UI/UX Designer',
    experience: '5 years',
    imageUrl: 'images/vishnu.jpeg',
    bio: 'I am Vishnu Karthik, a dynamic UI/UX designer who thrives on the intersection of creativity and functionality, '
        'where digital landscapes transform into immersive experiences.',
    email: 'vishnu@gmail.com',
    phone: '+0987654321',
  ),
  Candidate(
    name: 'Sourav',
    position: 'Software Engineer',
    experience: '7 years',
    imageUrl: 'images/Sourav.jpeg',
    bio: 'I am a seasoned software engineer with a passion for solving complex problems through elegant solutions. '
        'With seven years of experience, I bring a blend of technical expertise and innovative thinking to every project.',
    email: 'sourav@example.com',
    phone: '+1234567890',
  ),
  Candidate(
    name: 'Maansi',
    position: 'Data Scientist',
    experience: '4 years',
    imageUrl: 'images/maansi.jpeg',
    bio: 'I am a data scientist driven by a curiosity to unravel insights from complex datasets. '
        'With four years of experience, I specialize in machine learning algorithms and statistical analysis, '
        'transforming data into actionable intelligence.',
    email: 'maansi@example.com',
    phone: '+1987654321',
  ),
];

