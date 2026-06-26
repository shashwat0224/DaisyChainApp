import 'package:dio/dio.dart';

import 'package:daisy_chain/models/search_models.dart';

class ApiClient {
  static const _baseUrl = 'http://192.168.29.110:8000/api'; // Android emulator

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ));

  static Future<List<Station>> searchStations(String query) async {
    final response = await instance.get(
     '/stations/search/',
      queryParameters: {'q': query},
    );
    final list = response.data['results'] as List;
    return list.map((j) => Station.fromJson(j),).toList();
  }

  static Dio get instance => _dio;
}