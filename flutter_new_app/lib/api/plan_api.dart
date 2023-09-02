import 'package:dio/dio.dart';
import 'package:flutter_new_app/constants/constant_uris.dart';
import 'package:flutter_new_app/models/api/plan_entry.dart';
import 'package:flutter_new_app/models/api/plan_stage_entry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'interceptors/auth_interceptor.dart';

class PlanApi {
  final storage = const FlutterSecureStorage();
  final Dio api = Dio(BaseOptions(baseUrl: Uris.swiftApiUri));

  PlanApi() {
    api.interceptors.add(AuthInterceptor(api));
  }

  Future<List<PlanEntry>> getPlans() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Plan', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<PlanEntry>.from(response.data.map((x) => PlanEntry.fromJson(x)));
    }
    return <PlanEntry>[];
  }

  Future<PlanStageEntry?> getPlanEntry(num id) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Plan/stage/$id', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return PlanStageEntry.fromJson(response.data);
    }
    return null;
  }

  Future<int?> addPlan(PlanEntry planEntry) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Plan', data: planEntry.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> deletePlan(num id) async {
    if (id != -1) {
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
      try {
        var response = await api.delete('/Plan/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<List<PlanStageEntry>> getStages(num id) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Plan/stages/$id', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<PlanStageEntry>.from(response.data.map((x) => PlanStageEntry.fromJson(x)));
    }
    return <PlanStageEntry>[];
  }

  Future<int?> addStage(PlanStageEntry planStageEntry) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post(
          '/Plan/stage', data: planStageEntry.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> updateStage(PlanStageEntry planStageEntry) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.put('/Plan/stage/detail', data: planStageEntry.toJson(), options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> deleteStage(num id) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};
    try {
      var response = await api.delete('/Plan/stage/$id', options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
