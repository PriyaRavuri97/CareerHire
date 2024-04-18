import 'dart:io';

class RegularPost {
  String title;
  String content;
  File? image;

  RegularPost({required this.title, required this.content, this.image});
}
