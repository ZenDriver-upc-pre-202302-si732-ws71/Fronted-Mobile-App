import 'package:zendriver/entities/simple_account.dart';

class Driver {
  int? id;
  String? address;
  String? birth;
  SimpleAccount? account;

  Driver({this.id, this.address, this.birth, this.account});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    birth = json['birth'];
    account =
    json['account'] != null ? new SimpleAccount.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['birth'] = this.birth;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}