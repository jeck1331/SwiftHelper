import 'package:dio/dio.dart';
import 'package:flutter_new_app/constants/constant_uris.dart';
import 'package:flutter_new_app/models/api/register.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/api/login.dart';
import 'interceptors/auth_interceptor.dart';

class AuthApi {
  final Dio api = Dio(BaseOptions(baseUrl: Uris.swiftBaseUri));
  String? accessToken;

  final _storage = const FlutterSecureStorage();

  AuthApi() {
    api.interceptors.add(AuthInterceptor(api));
  }

  Future<int?> registerUser(Register model) async {
    Response response = await api.post(
      '/register',
      data: model.toJson(),
    );

    print('Register: ${response.statusCode}');
    return response.statusCode;
  }

  void logout() async => await _storage.deleteAll();

  Future<int?> login(Login model) async {
    String body = Uri(queryParameters: <String, String>{
      'grant_type': 'password',
      'username': model.userName,
      'password': model.password,
      'scope': 'openid profile email offline_access',
    }).query;

    try {
      Response response = await api.post('/connect/token',
          data: body,
          options: Options(headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
            'Access-Control-Allow-Origin': '*',
            'Content-Length': body.length.toString()
          }));

      var authData = response.data;

      if (response.statusCode == 200) {
       await _storage.write(
            key: 'accessToken', value: authData['access_token'].toString());
       await _storage.write(
            key: 'refreshToken', value: authData['refresh_token'].toString());
      }

      return response.statusCode;
    } on DioError catch (e) {
      print(e.message);
      return 400;
    }
  }

  Future<Response> getUserProfileData() async {
    return await api.get('/user');
  }

  // Future<Response> logout() async {
  //   return api.get('/logout');
  // }
}
