import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/constant_uris.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  String? accessToken;
  final _storage = const FlutterSecureStorage();

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      await refreshToken();

      final options = error.requestOptions..headers['Authorization'] = 'Bearer $accessToken';
      final result = await dio.request(
        error.requestOptions.path,
        options: Options(headers: options.headers),
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters,
      );
      return result;
    }
    return super.onError(error, handler);
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');

    String body = Uri(queryParameters: <String, String>{
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken ?? '',
    }).query;

    final response = await Dio(BaseOptions(baseUrl: Uris.swiftBaseUri)).post('/connect/token', data: body, options: Options(headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
    }));

    if (response.statusCode == 200) {
      accessToken = response.data['access_token'].toString();
      await _storage.write(
          key: 'accessToken', value: response.data['access_token'].toString());
      await _storage.write(
          key: 'refreshToken', value: response.data['refresh_token'].toString());
      return true;
    } else {
      accessToken = null;
      await _storage.deleteAll();
      return false;
    }
  }
}
