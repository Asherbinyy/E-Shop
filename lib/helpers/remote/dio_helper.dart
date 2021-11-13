import 'package:dio/dio.dart';
import 'package:e_shop/styles/constants/constants.dart';

import 'end_points.dart';

class DioHelper {
  static late Dio _dio;
  /// instantiate a new Dio object
  static void init() {
    _dio = Dio(
      BaseOptions(
          baseUrl: URL,
          receiveDataWhenStatusError: true,
        receiveTimeout: 20*1000,
        connectTimeout: 20*1000,
      ),
    );
  }

  static Future<Response> getData({
  required String url,
   Map <String,dynamic> ? query,
    String token = '',
  }) async {
    _dio.options.headers= {
      'Content-Type':'application/json',
      'lang': appLanguage,
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
      'lang': appLanguage,
      'Authorization': token,
    };
    return await _dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String token = '',
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': appLanguage,
      'Authorization': token,
    };
    return await _dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String token = '',

  }) {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': appLanguage,
      'Authorization': token,
    };
    return _dio.delete(url, queryParameters: query );
  }
  static void clearData() => _dio.clear();
}

// class DioHelper {
//    late  Dio ? dio ;
//
//   /// instantiate a new Dio object
//    void init() {
//      dio = Dio(
//       BaseOptions(
//           baseUrl: URL,
//         receiveDataWhenStatusError: true,
//         connectTimeout: 5000,// 5s
//         receiveTimeout: 5000,
//         validateStatus:(int? status) {
//           return status != null && status > 0;
//         }
//       ),
//     );
// }
//
// }
//  class _DioHeaders  {
//    void getHeaders ({String? authorization}){
//    DioHelper()..dio?.options.headers= {
//       'Content-Type':'application/json',
//       'lang': appLanguage,
//       'Authorization':authorization ?? null,
//     };
//   }
// }
// class GetData {
//  static late DioHelper _dioHelper;
//
//  static Future<Response> get({
//   required String url,
//    Map <String,dynamic> ? query,
//     String token = '',
//   }) async {
//     return _dioHelper.dio !=null ?
//     _dioHelper.dio!.get(url,queryParameters: query):
//     Future.error('Error in getting Data');
//   }
//
//   }
//   class PutData  {
//   static late DioHelper dioHelper;
//  static Future<Response> put({
//   required String url,
//    Map <String,dynamic> ? query,
//     String token = '',
//   }) async {
//     return dioHelper.dio !=null ?
//     dioHelper.dio!.get(url,queryParameters: query):
//     Future.error('Error in getting Data');
//   }
//
//
//   }
// //..... and so on
