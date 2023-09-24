import 'dart:convert';

import 'package:zendriver/ui/shared/services/base_service.dart';

import 'package:zendriver/entities/license_category.dart';

class LicenseCategoryService extends BaseService {
  late final String _categoryUrl;
  LicenseCategoryService() {
    _categoryUrl = produceUri("licensecategories");
  }

  Future<List<LicenseCategory>> getAll() async {
    final result = await get(_categoryUrl);
    if(result.statusCode == 200) {
      return (jsonDecode(result.body) as List).map((e) => LicenseCategory.fromJson(e)).toList();
    }

    return List.empty();
  }
}