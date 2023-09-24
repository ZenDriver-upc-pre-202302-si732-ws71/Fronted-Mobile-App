class DriverExperiences {
  int? id;
  String? description;
  String? startDate;
  String? endDate;

  DriverExperiences({this.id, this.description, this.startDate, this.endDate});

  DriverExperiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}