import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio;

  DioHelper(this.dio);

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      options: Options(headers: {"authorization": "Bearer $token"}),
      data: data,
    );
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.put(
      url,
      queryParameters: query,
      options: Options(headers: {"authorization": "Bearer $token"}),
      data: data,
    );
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.delete(
      url,
      queryParameters: query,
      options: Options(headers: {"authorization": "Bearer $token"}),
      data: data,
    );
  }
}
