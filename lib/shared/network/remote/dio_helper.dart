import 'package:dio/dio.dart';

class DioHelper {
  final String _baseUrl = 'https://api.quotable.io';
  final Dio _dio;
  DioHelper(this._dio);
  Future<Map<String, dynamic>> getQuate() async {
    var response = await _dio.get('$_baseUrl/random');
    return response.data;
  }
}
