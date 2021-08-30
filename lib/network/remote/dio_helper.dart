import 'package:dio/dio.dart';
import 'package:e_shop/network/remote/end_points.dart';
import 'package:e_shop/styles/constants.dart';

class DioHelper {
  static late Dio _dio;
  static void init() {
    _dio = Dio(
      BaseOptions(
          baseUrl: URL,
          receiveDataWhenStatusError: true,
        headers: InitialHeaders,
      ),
    );
  }

  static Future<Response> getData({
  required String url,
   Map <String,dynamic> ? query,
}) async {
    _dio.options.headers= {
      'lang': appLang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
   return await _dio.get(url,queryParameters: query);
  }
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String token = '',
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': appLang,
      'Authorization': token,
    };
    return await _dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,

  }) {
    return _dio.delete(url, queryParameters: query, cancelToken: CancelToken() );
  }

  static void clearData() => _dio.clear();











}