import 'package:zendriver/entities/recruiter.dart';

class Post {
  int? id;
  String? title;
  String? description;
  String? image;
  String? date;
  Recruiter? recruiter;

  Post(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.date,
        this.recruiter});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    recruiter = json['recruiter'] != null
        ? new Recruiter.fromJson(json['recruiter'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date'] = this.date;
    if (this.recruiter != null) {
      data['recruiter'] = this.recruiter!.toJson();
    }
    return data;
  }
}




