import 'dart:convert';

import 'package:zendriver/entities/account.dart';
import 'package:zendriver/ui/shared/services/base_service.dart';

class AccountService extends BaseService {
  late final String _accountUrl;
  AccountService() {
    _accountUrl = produceUri("users");
  }
  
  Future<Account?> getById(int id) async {
    var result = await get("$_accountUrl/$id");
    if(result.statusCode == 200) {
      return Account.fromJson(jsonDecode(result.body));
    }
    return null;
  }
}