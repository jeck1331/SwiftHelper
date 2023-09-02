import 'package:dio/dio.dart';
import 'package:flutter_new_app/constants/constant_uris.dart';
import 'package:flutter_new_app/models/api/health_activity_category.dart';
import 'package:flutter_new_app/models/api/health_eat_category.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/api/health_eat.dart';
import '../models/api/health_life_activity.dart';
import 'interceptors/auth_interceptor.dart';

class HealthApi {
  final storage = const FlutterSecureStorage();
  final Dio api = Dio(BaseOptions(baseUrl: Uris.swiftApiUri));

  HealthApi() {
    api.interceptors.add(AuthInterceptor(api));
  }

  Future<List<Eat>?> getEats() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Health/eats', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<Eat>.from(response.data.map((x) => Eat.fromJson(x)));
    }
    return null;
  }

  Future<List<EatCategory>?> getEatCategories() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Health/eat/categories', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<EatCategory>.from(response.data.map((x) => EatCategory.fromJson(x)));
    }
    return null;
  }

  Future<int?> createEatCategory(EatCategory eatCategory) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Health/eat/category', data: eatCategory.toJson(),options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> createEat(Eat eat) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
    try {
      var response = await api.post('/Health/eat', data: eat.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> deleteEat(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Health/eat/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<int?> deleteEatCategory(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Health/eat/category/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<List<LifeActivity>?> getSports() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Health/sports', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<LifeActivity>.from(response.data.map((x) => LifeActivity.fromJson(x)));
    }
    return null;
  }

  Future<List<ActivityCategory>?> getSportCategories() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Health/sport/categories', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<ActivityCategory>.from(response.data.map((x) => ActivityCategory.fromJson(x)));
    }
    return null;
  }

  Future<int?> createSportCategory(ActivityCategory sportCategory) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Health/sport/category', data: sportCategory.toJson(),options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> createSport(LifeActivity activity) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
    try {
      var response = await api.post('/Health/sport', data: activity.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> deleteSport(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Health/sport/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<int?> deleteSportCategory(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Health/sport/category/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }
}
