import 'package:dio/dio.dart';
import 'package:flutter_new_app/constants/constant_uris.dart';
import 'package:flutter_new_app/models/api/finance_history.dart';
import 'package:flutter_new_app/models/api/finance_account.dart';
import 'package:flutter_new_app/models/api/finance_category.dart';
import 'package:flutter_new_app/models/key_value_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/api/finance_item.dart';
import 'interceptors/auth_interceptor.dart';

class FinanceApi {
  final storage = const FlutterSecureStorage();
  final Dio api = Dio(BaseOptions(baseUrl: Uris.swiftApiUri));

  FinanceApi() {
    api.interceptors.add(AuthInterceptor(api));
  }

  Future<List<FinanceItem>?> getAll() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Finance/histories', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<FinanceItem>.from(response.data.map((x) => FinanceItem.fromJson(x)));
    }
    return null;
  }

  Future<List<FinanceItem>?> getAllByAccount(num id) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Finance/histories/$id', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<FinanceItem>.from(response.data.map((x) => FinanceItem.fromJson(x)));
    }
    return null;
  }

  Future<int?> createAccount(FinanceAccount financeAccount) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Finance/account', data: financeAccount.toJson(),options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<List<KeyValueModel>> getShopCategories() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.get('/Finance/categories',options: Options(headers: requestHeaders));
      return List<KeyValueModel>.from(response.data.map((x) => KeyValueModel(key: x['id'] as num, value: x['shopCategoryName'] as String)));
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<KeyValueModel>> getAccountsKeyValue() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.get('/Finance/accounts',options: Options(headers: requestHeaders));
      return List<KeyValueModel>.from(response.data.map((x) => KeyValueModel(key: x['id'] as num, value: x['accountName'] as String)));
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<FinanceAccount>> getFinanceAccounts() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.get('/Finance/accounts',options: Options(headers: requestHeaders));
      return List<FinanceAccount>.from(response.data.map((x) => FinanceAccount.fromJson(x)));
    } catch (e) {
      print(e);
    }

    return <FinanceAccount>[];
  }

  Future<List<FinanceAccount>> getFinanceAccountsById(List<num> ids) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Finance/accounts/ids', data: List.generate(ids.length, (index) => ids[index]), options: Options(headers: requestHeaders));
      return List<FinanceAccount>.from(response.data.map((x) => FinanceAccount.fromJson(x)));
    } catch (e) {
      print(e);
    }

    return <FinanceAccount>[];
  }

  Future<List<FinanceCategory>> getCategoriesById(List<num> ids) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Finance/categories/ids', data: List.generate(ids.length, (index) => ids[index]), options: Options(headers: requestHeaders));
      return List<FinanceCategory>.from(response.data.map((x) => FinanceCategory.fromJson(x)));
    } catch (e) {
      print(e);
    }

    return <FinanceCategory>[];
  }

  Future<int?> createHistory(FinanceHistory financeHistory) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
    try {
      var response = await api.post('/Finance/history', data: financeHistory.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } on DioError catch (e) {
      print(e);
      return e.response?.statusCode;
    }

    return null;
  }

  Future<int?> createFinanceAccount(FinanceAccount financeAccount) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
    try {
      var response = await api.post('/Finance/account', data: financeAccount.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> createShopCategory(FinanceCategory financeCategory) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
    try {
      var response = await api.post('/Finance/category', data: financeCategory.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> deleteAccount(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Finance/account/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<int?> deleteHistoryItem(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Finance/history/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }
}
