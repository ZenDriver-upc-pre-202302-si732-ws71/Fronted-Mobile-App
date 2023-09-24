import 'messages.dart';

class Posts {
  int? id;
  String? title;
  String? description;
  String? image;
  String? date;
  Recruiter? recruiter;

  Posts(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.date,
        this.recruiter});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    recruiter = json['recruiter'] != null
        ? Recruiter.fromJson(json['recruiter'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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