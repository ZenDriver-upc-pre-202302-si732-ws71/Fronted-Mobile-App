class Drivers {
  int? yearsOfExperience;
  String? categoryName;

  Drivers({this.yearsOfExperience, this.categoryName});

  Drivers.fromJson(Map<String, dynamic> json) {
    yearsOfExperience = json['yearsOfExperience'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yearsOfExperience'] = this.yearsOfExperience;
    data['categoryName'] = this.categoryName;
    return data;
  }
}