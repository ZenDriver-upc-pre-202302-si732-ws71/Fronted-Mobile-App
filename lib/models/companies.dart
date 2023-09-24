class Company {
  int? id;
  String? name;
  String? ruc;
  String? owner;
  String? address;

  Company({this.id, this.name, this.ruc, this.owner, this.address});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ruc = json['ruc'];
    owner = json['owner'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ruc'] = this.ruc;
    data['owner'] = this.owner;
    data['address'] = this.address;
    return data;
  }
}