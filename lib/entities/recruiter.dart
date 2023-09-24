import 'package:zendriver/entities/simple_account.dart';

class Recruiter {
  int? id;
  String? email;
  String? description;
  int? companyId;
  SimpleAccount? account;

  Recruiter(
      {this.id, this.email, this.description, this.companyId, this.account});

  Recruiter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    description = json['description'];
    companyId = json['companyId'];
    account =
    json['account'] != null ? new SimpleAccount.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['description'] = this.description;
    data['companyId'] = this.companyId;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}