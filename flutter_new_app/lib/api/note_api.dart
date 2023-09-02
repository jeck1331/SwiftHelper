import 'package:dio/dio.dart';
import 'package:flutter_new_app/constants/constant_uris.dart';
import 'package:flutter_new_app/models/api/note_detail.dart';
import 'package:flutter_new_app/models/api/note_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'interceptors/auth_interceptor.dart';

class NoteApi {
  final storage = const FlutterSecureStorage();
  final Dio api = Dio(BaseOptions(baseUrl: Uris.swiftApiUri));

  NoteApi() {
    api.interceptors.add(AuthInterceptor(api));
  }

  Future<List<NoteItem>> getAll() async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Note/notes', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return List<NoteItem>.from(response.data.map((x) => NoteItem.fromJson(x)));
    }
    return <NoteItem>[];
  }

  Future<NoteDetail?> getDetailNote(num id) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

    var response = await api.get('/Note/note/$id', options: Options(headers: requestHeaders));

    if (response.statusCode == 200) {
      return NoteDetail.fromJson(response.data);
    }
    return null;
  }

  Future<int?> detailNote(NoteDetail noteDetail) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Note/note/detail', data: noteDetail.toJson(),options: Options(headers: requestHeaders));
      return response.statusCode;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> addNote(NoteItem noteItem) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'};

    try {
      var response = await api.post('/Note/note', data: noteItem.toJson(),options: Options(headers: requestHeaders));
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
        var response = await api.delete('/Note/note/$id', options: Options(headers: requestHeaders));
        return response.statusCode;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }
}
