import 'package:dio/dio.dart';

class ResepService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'http://10.0.2.2:8000/api/resep'; // Sesuaikan endpoint

  Future<List<dynamic>> fetchReseps() async {
    try {
      final response = await _dio.get(_baseUrl); // Panggil endpoint resep
      if (response.statusCode == 200) {
        return response.data['data']; // Ambil data dari respons JSON
      } else {
        throw Exception('Failed to load reseps');
      }
    } catch (e) {
      throw Exception('Failed to load reseps: $e');
    }
  }

  Future<List<dynamic>> fetchResepByCategory(String category) async {
    try {
      final response =
          await _dio.get('$_baseUrl', queryParameters: {'category': category});
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load reseps');
      }
    } catch (e) {
      throw Exception('Failed to load reseps: $e');
    }
  }

  Future<List<dynamic>> fetchAllResep() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        return response.data['data']; // Data resep dari API
      } else {
        throw Exception('Failed to load reseps');
      }
    } catch (e) {
      throw Exception('Failed to load reseps: $e');
    }
  }
}
